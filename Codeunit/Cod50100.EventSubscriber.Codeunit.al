codeunit 50100 EventSubscriber
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Sales Release", OnBeforeCreateWhseRequest, '', false, false)]
    local procedure OnBeforeCreateWhseRequest(var WhseRqst: Record "Warehouse Request"; var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; WhseType: Option Inbound,Outbound)
    begin
        WhseRqst."Ship-to Code" := SalesHeader."Ship-to Code";
    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", OnBeforeSalesLineOnAfterGetRecord, '', false, false)]
    local procedure OnBeforeSalesLineOnAfterGetRecord(SalesLine: Record "Sales Line"; WarehouseRequest: Record "Warehouse Request"; RequestType: Option; var IsHandled: Boolean; SkipBlockedItem: Boolean)
    var
        SalesHeader: Record "Sales Header";
        Item: Record item;
        ReservationEntry, ReservationEntry2 : Record "Reservation Entry";
        SingleInstance: Codeunit SingleInstance;
        ShippingDate, EmptyDate : date;
        ReservedQty: Decimal;
    begin
        SingleInstance.GetWarehouseRequestDate(ShippingDate);
        if SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") and (SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Partial) then begin
            if ((ShippingDate <> EmptyDate) and (SalesLine."Shipping Date" > ShippingDate)) or (SalesLine."Shipping Date" = EmptyDate) then begin
                IsHandled := true;
                exit;
            end;
            //Item.Reset();
            // Item.SetRange("No.", SalesLine."No.");
            // Item.SetFilter("Location Filter", SalesLine."Location Code");
            // if Item.FindFirst() then;
            Clear(ReservedQty);
            SalesLine.CalcFields("Reserved Qty. (Base)");
            if SalesLine."Reserved Qty. (Base)" <> 0 then begin
                ReservationEntry.Reset();
                ReservationEntry.SetRange("Source Type", Database::"Sales Line");
                ReservationEntry.SetRange("Source Subtype", 1);
                ReservationEntry.SetRange("Item No.", SalesLine."No.");
                ReservationEntry.SetRange("Source ID", SalesLine."Document No.");
                ReservationEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
                ReservationEntry.SetRange("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
                if ReservationEntry.FindSet() then
                    repeat
                        if ReservationEntry2.Get(ReservationEntry."Entry No.", not ReservationEntry.Positive) and (ReservationEntry2."Source Type" = Database::"Item Ledger Entry") then ReservedQty += ReservationEntry2."Quantity (Base)";
                    until ReservationEntry.Next() = 0;
            end;
            if SalesLine."Outstanding Qty. (Base)" > (ReservedQty) then IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnCreateTempActivityLineOnAfterValidateQuantity, '', false, false)]
    local procedure OnCreateTempActivityLineOnAfterValidateQuantity(var TempWhseActivLine: Record "Warehouse Activity Line" temporary)
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        CreatePick: Codeunit "Create Pick";
        SingleInstance: Codeunit SingleInstance;
        ToBinCode: Code[20];
        FromBinCode: Code[20];
    begin
        singleInstance.GetWarehouseShipmentLine(WarehouseShipmentLine);
        SingleInstance.GetToPickBin(ToBinCode);
        SingleInstance.GetFromPickBin(FromBinCode);
        if ToBinCode <> TempWhseActivLine."Bin Code" then begin
            TempWhseActivLine."Bin Code" := FromBinCode;
            //TempWhseActivLine.Quantity := WarehouseShipmentLine."Qty. Outstanding";
            //TempWhseActivLine."Qty. (Base)" := WarehouseShipmentLine."Qty. Outstanding (Base)";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnBeforeGetBinContent, '', false, false)]
    local procedure OnBeforeGetBinContent(var TempBinContent: Record "Bin Content" temporary; ItemNo: Code[20]; VariantCode: Code[10]; UnitofMeasureCode: Code[10]; LocationCode: Code[10]; ToBinCode: Code[20]; CrossDock: Boolean; IsMovementWorksheet: Boolean; WhseItemTrkgExists: Boolean; BreakbulkBins: Boolean; SmallerUOMBins: Boolean; WhseItemTrackingSetup: Record "Item Tracking Setup"; TotalQtytoPick: Decimal; TotalQtytoPickBase: Decimal; var Result: Boolean; var IsHandled: Boolean)
    var
        BinContent: Record "Bin Content";
        TempWhseActivLine: Record "Warehouse Activity Line" temporary;
        SingleInstance: Codeunit SingleInstance;
        AvailableQtytoPickBase: Decimal;
        PreBinQtyBase: Decimal;
        QtyMoreThanRequired: boolean;
        PickBin: Code[20];
    begin
        singleInstance.SetToPickBin(ToBinCode);
        Result := TempBinContent.GetBinContent(ItemNo, VariantCode, UnitofMeasureCode, LocationCode, ToBinCode, CrossDock, IsMovementWorksheet, WhseItemTrkgExists, WhseItemTrackingSetup);
        isHandled := true;
        QtyMoreThanRequired := true;
        singleInstance.ClearFromPickBin();
        BinContent.Reset();
        BinContent.CopyFilters(TempBinContent);
        if binContent.FindSet() then
            repeat
                AvailableQtytoPickBase := CalcQtyToPickBase(BinContent, TempWhseActivLine);
                if AvailableQtytoPickBase <= TotalQtytoPickBase then QtyMoreThanRequired := false;
                if (TotalQtytoPickBase <= AvailableQtytoPickBase) and ((PreBinQtyBase >= AvailableQtytoPickBase) or (PreBinQtyBase = 0)) then begin
                    PreBinQtyBase := AvailableQtytoPickBase;
                    PickBin := BinContent."Bin Code";
                end;
            until BinContent.Next() = 0;
        if not QtyMoreThanRequired then
            if PickBin <> '' then begin
                TempBinContent.SetRange("Bin Code", PickBin);
                TempBinContent.FindSet();
                singleInstance.SetFromPickBin(PickBin);
            end;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Whse.-Shipment - Create Pick", OnAfterGetRecordWarehouseShipmentLineOnBeforeCreatePickTempLine, '', false, false)]
    local procedure OnAfterGetRecordWarehouseShipmentLineOnBeforeCreatePickTempLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        SingleInstance: Codeunit SingleInstance;
    begin
        SingleInstance.SetWarehouseShipmentLine(WarehouseShipmentLine);
    end;

    local procedure CalcQtyToPickBase(var BinContent: Record "Bin Content"; var TempWhseActivLine: Record "Warehouse Activity Line" temporary): Decimal
    var
        WhseEntry: Record "Warehouse Entry";
        WhseActivLine: Record "Warehouse Activity Line";
        WhseJournalLine: Record "Warehouse Journal Line";
        QtyPlaced: Decimal;
        QtyTaken: Decimal;
    begin
        WhseEntry.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
        WhseEntry.SetRange("Location Code", BinContent."Location Code");
        WhseEntry.SetRange("Bin Code", BinContent."Bin Code");
        WhseEntry.SetRange("Item No.", BinContent."Item No.");
        WhseEntry.SetRange("Variant Code", BinContent."Variant Code");
        WhseEntry.SetRange("Unit of Measure Code", BinContent."Unit of Measure Code");
        WhseEntry.SetTrackingFilterFromBinContent(BinContent);
        WhseEntry.CalcSums("Qty. (Base)");
        WhseActivLine.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Action Type", "Variant Code", "Unit of Measure Code", "Breakbulk No.", "Activity Type", "Lot No.", "Serial No.");
        WhseActivLine.SetRange("Location Code", BinContent."Location Code");
        WhseActivLine.SetRange("Action Type", WhseActivLine."Action Type"::Take);
        WhseActivLine.SetRange("Bin Code", BinContent."Bin Code");
        WhseActivLine.SetRange("Item No.", BinContent."Item No.");
        WhseActivLine.SetRange("Variant Code", BinContent."Variant Code");
        WhseActivLine.SetRange("Unit of Measure Code", BinContent."Unit of Measure Code");
        WhseActivLine.SetTrackingFilterFromBinContent(BinContent);
        WhseActivLine.CalcSums("Qty. Outstanding (Base)");
        QtyTaken := WhseActivLine."Qty. Outstanding (Base)";
        TempWhseActivLine.Copy(WhseActivLine);
        TempWhseActivLine.CalcSums("Qty. Outstanding (Base)");
        QtyTaken += TempWhseActivLine."Qty. Outstanding (Base)";
        TempWhseActivLine.SetRange("Action Type", WhseActivLine."Action Type"::Place);
        TempWhseActivLine.CalcSums("Qty. Outstanding (Base)");
        QtyPlaced := TempWhseActivLine."Qty. Outstanding (Base)";
        TempWhseActivLine.Reset();
        WhseJournalLine.SetCurrentKey("Item No.", "From Bin Code", "Location Code", "Entry Type", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
        WhseJournalLine.SetRange("Location Code", BinContent."Location Code");
        WhseJournalLine.SetRange("From Bin Code", BinContent."Bin Code");
        WhseJournalLine.SetRange("Item No.", BinContent."Item No.");
        WhseJournalLine.SetRange("Variant Code", BinContent."Variant Code");
        WhseJournalLine.SetRange("Unit of Measure Code", BinContent."Unit of Measure Code");
        WhseJournalLine.SetTrackingFilterFromBinContent(BinContent);
        WhseJournalLine.CalcSums("Qty. (Absolute, Base)");
        exit(WhseEntry."Qty. (Base)" + WhseJournalLine."Qty. (Absolute, Base)" + QtyPlaced - QtyTaken);
    end;
}
