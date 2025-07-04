report 50100 "Create Warehouse Shipment New"
{
    UsageCategory = Tasks;
    ApplicationArea = Warehouse;
    ProcessingOnly = true;
    Caption = 'Create Warehouse Shipment NBK';

    dataset
    {
        dataitem("Warehouse Request"; "Warehouse Request")
        {
            DataItemTableView = sorting("Source Document", "Source No.", "Ship-to Code") where(Type = const(Outbound), "Document Status" = const(Released));
            RequestFilterFields = "Source Document", "Source No.", "Location Code";

            trigger OnAfterGetRecord()
            var
                Location: Record Location;
                SalesHeader: Record "Sales Header";
            begin
                if not Location.RequireShipment("Location Code") then
                    CurrReport.Skip();
                case "Source Document" of
                    "Source Document"::"Purchase Return Order":
                        CreateWarehouseShipmentForPurchaseReturnOrder();
                    "Source Document"::"Sales Order":
                        begin
                            if SalesHeader.Get(SalesHeader."Document Type"::Order, "Warehouse Request"."Source No.") then
                                if SalesHeader."EC Order" then
                                    ECCreateWarehouseShipmentForSalesOrder() //MS Standard Code
                                else
                                    CreateWarehouseShipmentForSalesOrder();
                        end;

                    "Source Document"::"Outbound Transfer":
                        CreateWarehouseShipmentForTransferOrder();
                end;
                OnWarehouseRequestOnAfterGetRecord("Warehouse Request");
            end;

            trigger OnPreDataItem()
            begin
                SingleInstance.SetWarehouseRequestDate(ToBeShippedBY);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field("Do Not Fill Qty. to Handle"; DoNotFillQtytoHandle)
                    {
                        Caption = 'Do not fill Qty. to Handle';
                        ToolTip = 'Specifies if the Quantity to Handle field in the warehouse document is prefilled according to the source document quantities.';
                    }
                    field("Reserved Stock Only"; ReservedFromStock)
                    {
                        Caption = 'Reserved stock only';
                        ToolTip = 'Specifies if you want to include only source document lines that are fully or partially reserved from current stock.';
                        ValuesAllowed = " ", "Full and Partial", Full;
                    }
                    field(ToBeShippedBY; ToBeShippedBY)
                    {
                        Caption = 'To Be Shipped By';
                        ToolTip = 'Specifies if the To Be Shipped By field in the warehouse document is create source document on the date.';
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        ToBeShippedBY := WorkDate();
    end;

    trigger OnPostReport()
    begin
        SingleInstance.ClearWarehouseRequestDate();
    end;

    var
        WhseShptHeader: Record "Warehouse Shipment Header";
        SingleInstance: codeunit SingleInstance;
        DoNotFillQtytoHandle: Boolean;
        ReservedFromStock: Enum "Reservation From Stock";
        ToBeShippedBY: Date;
        PrevCustomerNo, PrevShiptoCode : code[20];
    procedure InitializeRequest(NewDoNotFillQtyToHandle: Boolean; NewReservedFromStock: Enum "Reservation From Stock")
    begin
        DoNotFillQtytoHandle := NewDoNotFillQtyToHandle;
        ReservedFromStock := NewReservedFromStock;
    end;

    local procedure ECCreateWarehouseShipmentForSalesOrder()
    var
        SalesHeader: Record "Sales Header";
        WarehouseRequest: Record "Warehouse Request";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin
        WarehouseRequest.Copy("Warehouse Request");

        SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseRequest."Source No.");
        if SalesHeader.Status <> SalesHeader.Status::Released then
            exit;

        if not SalesHeader.IsApprovedForPostingBatch() then
            exit;

        if SalesHeader.WhseShipmentConflict(SalesHeader."Document Type", SalesHeader."No.", SalesHeader."Shipping Advice") then
            exit;

        if GetSourceDocOutbound.CheckSalesHeader(SalesHeader, false) then
            exit;

        CreateWarehouseShipmentFromWhseRequest(WarehouseRequest);
    end;

    local procedure CreateWarehouseShipmentForSalesOrder()
    var
        SalesHeader: Record "Sales Header";
        WarehouseRequest: Record "Warehouse Request";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin
        WarehouseRequest.Copy("Warehouse Request");
        SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseRequest."Source No.");

        if SalesHeader.Status <> SalesHeader.Status::Released then
            exit;
        if not SalesHeader.IsApprovedForPostingBatch() then
            exit;
        if SalesHeader.WhseShipmentConflict(SalesHeader."Document Type", SalesHeader."No.", SalesHeader."Shipping Advice") then
            exit;
        if GetSourceDocOutbound.CheckSalesHeader(SalesHeader, false) then
            exit;
        if SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Complete then begin
            if not CheckInventoryForSalesOrderComplete(SalesHeader) then
                exit;
        end else if SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Partial then
                if not CheckInventoryForSalesOrderPartial(SalesHeader) then
                    exit;

        if (PrevCustomerNo <> SalesHeader."Sell-to Customer No.") or
        (PrevShiptoCode <> SalesHeader."Ship-to Code") then begin
            PrevCustomerNo := SalesHeader."Sell-to Customer No.";
            PrevShiptoCode := SalesHeader."Ship-to Code";
            CheckAndDeleteEmptyWhseShipHeader();
            CreateShptHeader();
        end;
        CreateWarehouseShipmentFromWhseRequest_Sales(WarehouseRequest);
    end;

    procedure CreateShptHeader()
    var
        Location: Record Location;
    begin
        Location.Get("Warehouse Request"."Location Code");
        WhseShptHeader.Init();
        WhseShptHeader."No." := '';
        WhseShptHeader."Location Code" := "Warehouse Request"."Location Code";
        if Location.Code = WhseShptHeader."Location Code" then
            WhseShptHeader."Bin Code" := Location."Shipment Bin Code";
        WhseShptHeader."External Document No." := "Warehouse Request"."External Document No.";
        WhseShptHeader."Shipment Method Code" := "Warehouse Request"."Shipment Method Code";
        WhseShptHeader."Shipping Agent Code" := "Warehouse Request"."Shipping Agent Code";
        WhseShptHeader."Shipping Agent Service Code" := "Warehouse Request"."Shipping Agent Service Code";
        WhseShptHeader."Shipment Date" := ToBeShippedBY;
        WhseShptHeader.Insert(true);
    end;

    local procedure CheckAndDeleteEmptyWhseShipHeader()
    var
        WarehouseShipLine: Record "Warehouse Shipment Line";
    begin
        if WhseShptHeader."No." = '' then
            exit;

        WarehouseShipLine.Reset();
        WarehouseShipLine.SetRange("No.", WhseShptHeader."No.");
        if not WarehouseShipLine.FindFirst() then begin
            WhseShptHeader.Delete(true);
            Commit();
        end;
    end;

    local procedure CreateWarehouseShipmentForPurchaseReturnOrder()
    var
        PurchaseHeader: Record "Purchase Header";
        WarehouseRequest: Record "Warehouse Request";
    begin
        WarehouseRequest.Copy("Warehouse Request");
        PurchaseHeader.Get(PurchaseHeader."Document Type"::"Return Order", WarehouseRequest."Source No.");
        if PurchaseHeader.Status <> PurchaseHeader.Status::Released then exit;
        CreateWarehouseShipmentFromWhseRequest(WarehouseRequest);
    end;

    local procedure CreateWarehouseShipmentForTransferOrder()
    var
        TransferHeader: Record "Transfer Header";
        WarehouseRequest: Record "Warehouse Request";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin
        WarehouseRequest.Copy("Warehouse Request");
        TransferHeader.Get(WarehouseRequest."Source No.");
        if TransferHeader.Status <> TransferHeader.Status::Released then exit;
        if GetSourceDocOutbound.CheckTransferHeader(TransferHeader, false) then exit;
        CreateWarehouseShipmentFromWhseRequest(WarehouseRequest);
    end;

    procedure CreateWarehouseShipmentFromWhseRequest(var WarehouseRequest: Record "Warehouse Request")
    var
        GetSourceDocuments: Report "Get Source Documents";
    begin
        WarehouseRequest.SetRecFilter();
        GetSourceDocuments.SetDoNotFillQtytoHandle(DoNotFillQtytoHandle);
        GetSourceDocuments.SetReservedFromStock(ReservedFromStock);
        GetSourceDocuments.UseRequestPage(false);
        GetSourceDocuments.SetTableView(WarehouseRequest);
        GetSourceDocuments.SetHideDialog(true);
        GetSourceDocuments.RunModal();
    end;

    procedure CreateWarehouseShipmentFromWhseRequest_Sales(var WarehouseRequest: Record "Warehouse Request")
    var
        GetSourceDocuments: Report "Get Source Documents";
    begin
        WarehouseRequest.SetRecFilter();
        GetSourceDocuments.SetDoNotFillQtytoHandle(DoNotFillQtytoHandle);
        GetSourceDocuments.SetReservedFromStock(ReservedFromStock);
        GetSourceDocuments.UseRequestPage(false);
        GetSourceDocuments.SetTableView(WarehouseRequest);
        GetSourceDocuments.SetHideDialog(true);
        GetSourceDocuments.SetOneCreatedShptHeader(WhseShptHeader);
        GetSourceDocuments.RunModal();
    end;

    local procedure CheckInventoryForSalesOrderComplete(SalesHeader: Record "Sales Header"): boolean
    var
        SalesLine: Record "Sales Line";
        ReservationEntry, ReservationEntry2 : Record "Reservation Entry";
        Item: Record Item;
        ReservedQty: Decimal;
        EmptyDate: Date;
    begin
        SalesLine.reset();
        SalesLine.setrange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
                if ToBeShippedBY <> 0D then
                    if (SalesLine."Shipping Date" > ToBeShippedBY) or (SalesLine."Shipping Date" = EmptyDate) then
                        exit(false);

                // Item.Reset();
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
                            if ReservationEntry2.Get(ReservationEntry."Entry No.", not ReservationEntry.Positive) and (ReservationEntry2."Source Type" = Database::"Item Ledger Entry") then
                                ReservedQty += ReservationEntry2."Quantity (Base)";
                        until ReservationEntry.Next() = 0;
                end;
                if SalesLine."Outstanding Qty. (Base)" > (ReservedQty) then
                    exit(false);
            until SalesLine.Next() = 0;
        exit(true);
    end;

    local procedure CheckInventoryForSalesOrderPartial(SalesHeader: Record "Sales Header"): boolean
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        ReservationEntry, ReservationEntry2 : Record "Reservation Entry";
        SalesWarehouseMgt: Codeunit "Sales Warehouse Mgt.";
        ReservedQty: Decimal;
        RedFlag: Boolean;
    begin
        SalesLine.reset();
        SalesLine.setrange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if ToBeShippedBY <> 0D then
            SalesLine.SetFilter("Shipping Date", '<=%1', ToBeShippedBY);
        //SalesLine.SetFilter("Shipment Date", '<=%1', ToBeShippedBY);
        if SalesLine.FindSet() then begin
            repeat
                // Item.Reset();
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
                            if ReservationEntry2.Get(ReservationEntry."Entry No.", not ReservationEntry.Positive) and (ReservationEntry2."Source Type" = Database::"Item Ledger Entry") then
                                ReservedQty += ReservationEntry2."Quantity (Base)";
                        until ReservationEntry.Next() = 0;
                end;
                if (SalesLine."Outstanding Qty. (Base)" <= (ReservedQty)) and
                SalesWarehouseMgt.CheckIfFromSalesLine2ShptLine(SalesLine, ReservedFromStock) then
                    exit(true);

            until SalesLine.Next() = 0;
        end else
            exit(false);
        exit(false);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnWarehouseRequestOnAfterGetRecord(WarehouseRequest: Record "Warehouse Request")
    begin
    end;
}
