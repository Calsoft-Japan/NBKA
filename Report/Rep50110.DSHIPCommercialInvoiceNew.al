report 50110 "DSHIPCommercialInvoiceNew"
{
    ApplicationArea = All;
    Caption = 'Dynamic Ship Commercial Invoice';
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/DSHIPCommercialInvoiceNew.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(diLPHeader; "IWX LP Header")
        {
            MaxIteration = 1;
            column(diLPHeader_No; diLPHeader."No.")
            {
                IncludeCaption = true;
            }
            column(diLPHeader_Order; diLPHeader."Source No.")
            {
            }
            column(diLPHeader_Weight; LpGrossWeight)
            {
            }
            column(diLPHeader_Count; LpCount)
            {
            }
            column(diShipFrom_TaxID; ShipFromTaxID)
            {
            }
            column(diShipFrom_Contact; ShipFromDetails.Name)
            {
            }
            column(diShipFrom_PhoneNo; ShipFromDetails."Phone No.")
            {
            }
            column(diShipFrom_Name; ShipFromDetails.Company)
            {
            }
            column(diShipFrom_Address; ShipFromDetails.Address)
            {
            }
            column(diShipFrom_Address2; ShipFromDetails."Address 2")
            {
            }
            column(diShipFrom_City; ShipFromDetails.City)
            {
            }
            column(diShipFrom_County; ShipFromDetails.County)
            {
            }
            column(diShipFrom_PostCode; ShipFromDetails."Post Code")
            {
            }
            column(diShipFrom_Country; ShipFromDetails."Country/Region Code")
            {
            }
            column(diShipTo_TaxID; ShipToTaxID)
            {
            }
            column(diShipTo_Name; ShipToDetails.Company)
            {
            }
            column(diShipTo_PhoneNo; ShipToDetails."Phone No.")
            {
            }
            column(diShipTo_Address; ShipToDetails.Address)
            {
            }
            column(diShipTo_Address2; ShipToDetails."Address 2")
            {
            }
            column(diShipTo_City; ShipToDetails.City)
            {
            }
            column(diShipTo_County; ShipToDetails.County)
            {
            }
            column(diShipTo_PostCode; ShipToDetails."Post Code")
            {
            }
            column(diShipTo_Country; ShipToDetails."Country/Region Code")
            {
            }
            column(diBroker_Name; BrokerDetails.Company)
            {
            }
            column(diBroker_PhoneNo; BrokerDetails."Phone No.")
            {
            }
            column(diBroker_Contact; BrokerDetails.Name)
            {
            }
            column(SalesOrderNumber; SalesHeaderNo)
            {
            }
            column(ExternalDocumentNo; ExtDocNo)
            {
            }
            column(YourReference; YourRef)
            {
            }
            column(OrderDate; OrderDate)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(ShipmentDate; ShipmentDate)
            {
            }
            column(ShipmentMethodCode; ShipMethod)
            {
            }
            column(OrderClass; OrderClass)
            {
            }
            column(RequestedDeliveryDate; ReqDeliveryDate)
            {
            }
            column(PromisedDeliveryDate; PromisedDeliveryDate)
            {
            }
            column(MasterPackageTrackingNo; PackageTracking)
            {
            }
            column(Currentdate; Today)
            {
            }
            column(Location_email; location."E-Mail")
            {
            }
            column(EmailLbl; EmailLbl)
            {
            }
            column(CommercialInvoiceNolbl; CommercialInvoiceNolbl)
            {
            }
            column(InvoiceDatelbl; InvoiceDatelbl)
            {
            }
            dataitem(diCustomsLine; "DSHIP Shipment Customs Line")
            {
                DataItemLink = "Customs No." = field("Customs No.");
                column(diItemLine_Quantity; diCustomsLine.Quantity)
                {
                    IncludeCaption = true;
                }
                column(diItemLine_UOM; diCustomsLine."Qty. Unit of Measure Code")
                {
                    IncludeCaption = true;
                }
                column(diItemLine_ItemNo; diCustomsLine."Item No.")
                {
                    IncludeCaption = true;
                }
                column(diItemLine_Description; diCustomsLine."Item Description")
                {
                    IncludeCaption = true;
                }
                column(diItemLine_TariffNo; diCustomsLine."HS Tariff No.")
                {
                    IncludeCaption = true;
                }
                column(diItemLine_CountryOfOrigin; diCustomsLine."Origin Country/Region Code")
                {
                    IncludeCaption = true;
                }
                column(diItemLine_Weight; diCustomsLine."Weight Per Item Qty.")
                {
                    IncludeCaption = true;
                }
                column(diItemLine_WeightUOM; diCustomsLine."Weight Unit of Measure Code")
                {
                    IncludeCaption = true;
                }
                column(diItemLine_Value; diCustomsLine."Value Per Item Qty.")
                {
                    IncludeCaption = true;
                }
                column(diItemLine_Currency; diCustomsLine."Currency Code")
                {
                    IncludeCaption = true;
                }
            }

            trigger OnAfterGetRecord()
            var
                customsHeader: Record "DSHIP Shipment Customs Header";
                packMgmt: Codeunit "DSHIP Package Management";
                docType: Option;
            begin
                LpCount := diLPHeader.Count();
                if (diLPHeader.CalcSums("Shipment Gross Weight")) then
                    LpGrossWeight += diLPHeader."Shipment Gross Weight";
                // Calc field source and shipped source. Use non-blank.
                if (not IsOrderRetrieved) then begin
                    if (diLPHeader."Source No." <> '') then begin
                        GetDetailsFromLP(diLPHeader);
                    end else
                        if (diLPHeader."Shipment No." <> '') then begin
                            GetDetailsFromPostedLP(diLPHeader);
                        end;

                    SetDataItems();
                    location.Get(diLPHeader."Location Code");
                    if (diLPHeader."Source Document" <> diLPHeader."Source Document"::" ") then begin
                        packMgmt.getDShipDocTypeFromLPSrcType(diLPHeader."Source Document", docType);
                        diLPHeader."Customs No." := CreateCustomsHeader(diLPHeader."Customs No.", docType,
                                                                        diLPHeader."Source No.");
                        if (customsHeader.Get(diLPHeader."Customs No.")) then begin
                            AddressMgmt.GetAddressWithSource(customsHeader, false, BrokerDetails);
                        end;
                    end;
                end;
            end;
        }
    }

    var
        location: Record Location;
        ShipToDetails: Record "DSHIP Address Buffer" temporary;
        ShipFromDetails: Record "DSHIP Address Buffer" temporary;
        BrokerDetails: Record "DSHIP Address Buffer" temporary;
        SalesHeader: Record "Sales Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        AddressMgmt: Codeunit "DSHIP Address Management";
        OrderDate: Date;
        PostingDate: Date;
        ShipmentDate: Date;
        ReqDeliveryDate: Date;
        PromisedDeliveryDate: Date;
        ShipFromTaxID: Text;
        ShipToTaxID: Text;
        YourRef: Text;
        PackageTracking: Text;
        SalesHeaderNo: Code[50];
        ExtDocNo: Code[50];
        ShipMethod: Code[50];
        OrderClass: Code[50];
        LpGrossWeight: Decimal;
        LpCount: Integer;
        IsOrderRetrieved: Boolean;
        EmailLbl: Label 'Email:';
        CommercialInvoiceNolbl: Label 'Commercial Invoice No.:';
        InvoiceDatelbl: Label 'Invoice Date:';

    local procedure GetDetailsFromLP(var lpHeader: Record "IWX LP Header")
    var
        whseShipHeader: Record "Warehouse Shipment Header";
        whseShipLine: Record "Warehouse Shipment Line";
        transferHeader: Record "Transfer Header";
        location: Record Location;
        locationCode: Code[50];
    begin
        case lpHeader."Source Document" of
            lpHeader."Source Document"::Shipment:
                begin
                    if (whseShipHeader.Get(lpHeader."Source No.")) then begin
                        locationCode := whseShipHeader."Location Code";
                        AddressMgmt.GetAddressWithSource(whseShipHeader, false, ShipToDetails);
                        whseShipLine.SetRange("No.", whseShipHeader."No.");
                        whseShipLine.SetRange("Source Document", whseShipLine."Source Document"::"Sales Order");
                        if (AddressMgmt.GetRelevantWhseShipLine(whseShipLine)) then
                            if (SalesHeader.Get(whseShipLine."Source Subtype", whseShipLine."Source No.")) then;
                    end;
                end;
            lpHeader."Source Document"::"Sales Order":
                begin
                    if (SalesHeader.Get(SalesHeader."Document Type"::Order, lpHeader."Source No.")) then begin
                        locationCode := SalesHeader."Location Code";
                        AddressMgmt.GetAddressWithSource(SalesHeader, false, ShipToDetails);
                    end;
                end;
            lpHeader."Source Document"::"Outbound Transfer":
                begin
                    if (transferHeader.Get(lpHeader."Source No.")) then begin
                        locationCode := transferHeader."Transfer-from Code";
                        AddressMgmt.GetAddressWithSource(transferHeader, false, ShipToDetails);
                    end;
                end;
        end;

        if (location.Get(locationCode)) then begin
            AddressMgmt.GetAddressWithSource(location, false, ShipFromDetails);
        end;

        // Set tax id.
        if (ShipFromDetails."State Tax ID" <> '') then begin
            ShipFromTaxID := ShipFromDetails."State Tax ID";
        end else
            if (ShipFromDetails."Federal Tax ID" <> '') then begin
                ShipFromTaxID := ShipFromDetails."Federal Tax ID";
            end;

        if (ShipToDetails."State Tax ID" <> '') then begin
            ShipToTaxID := ShipToDetails."State Tax ID";
        end else begin
            if (ShipToDetails."Federal Tax ID" <> '') then begin
                ShipToTaxID := ShipToDetails."Federal Tax ID";
            end;
        end;

        // Processed order, prevent subsequent runs.
        IsOrderRetrieved := true;
    end;

    local procedure GetDetailsFromPostedLP(var lpHeader: Record "IWX LP Header")
    var
        postedWhseShipHeader: Record "Posted Whse. Shipment Header";
        postedWhseShipLine: Record "Posted Whse. Shipment Line";
        transferShipmentHeader: Record "Transfer Shipment Header";
        location: Record Location;
        locationCode: Code[50];
    begin
        //xx: Use GetPostedDocument from Common - probably write an overload
        // Get address details.
        case lpHeader."Shipped Source Document" of
            lpHeader."Shipped Source Document"::Shipment:
                begin
                    if (postedWhseShipHeader.Get(lpHeader."Shipment No.")) then begin
                        locationCode := postedWhseShipHeader."Location Code";
                        AddressMgmt.GetAddressWithSource(postedWhseShipHeader, false, ShipToDetails);
                        postedWhseShipLine.SetRange("Posted Source Document", postedWhseShipLine."Posted Source Document"::"Posted Shipment");
                        postedWhseShipLine.SetRange("No.", postedWhseShipHeader."No.");
                        if (postedWhseShipLine.FindFirst()) then
                            if (SalesShipmentHeader.Get(postedWhseShipLine."Posted Source No.")) then;
                    end;
                end;
            lpHeader."Shipped Source Document"::"Sales Order":
                begin
                    if (SalesShipmentHeader.Get(lpHeader."Shipment No.")) then begin
                        locationCode := SalesShipmentHeader."Location Code";
                        AddressMgmt.GetAddressWithSource(SalesShipmentHeader, false, ShipToDetails);
                    end;
                end;
            lpHeader."Shipped Source Document"::"Outbound Transfer":
                begin
                    if (transferShipmentHeader.Get(lpHeader."Shipment No.")) then begin
                        locationCode := transferShipmentHeader."Transfer-from Code";
                        AddressMgmt.GetAddressWithSource(transferShipmentHeader, false, ShipToDetails);
                    end;
                end;
        end;

        if (location.Get(locationCode)) then begin
            AddressMgmt.GetAddressWithSource(location, false, ShipFromDetails);
        end;

        // Set tax id.
        if (ShipFromDetails."State Tax ID" <> '') then begin
            ShipFromTaxID := ShipFromDetails."State Tax ID";
        end else
            if (ShipFromDetails."Federal Tax ID" <> '') then begin
                ShipFromTaxID := ShipFromDetails."Federal Tax ID";
            end;

        if (ShipToDetails."State Tax ID" <> '') then begin
            ShipToTaxID := ShipToDetails."Federal Tax ID";
        end else begin
            if (ShipToDetails."Federal Tax ID" <> '') then begin
                ShipToTaxID := ShipToDetails."Federal Tax ID";
            end;
        end;

        // Processed order, prevent subsequent runs.
        IsOrderRetrieved := true;
    end;

    local procedure CreateCustomsHeader(customsNo: Code[50]; docType: Option; cocNo: Code[50]): Code[20]
    var
        customsMgmt: Codeunit "DSHIP Package Customs Mgmt.";
    begin
        if (customsNo = '') then begin
            customsNo := customsMgmt.GenerateCustoms(docType, cocNo, true);
        end;

        exit(CopyStr(customsNo, 1, 20));
    end;

    local procedure SetDataItems()
    begin
        // These exists so customers can add to the report as needed.
        if (SalesHeader."No." <> '') then begin
            SalesHeaderNo := SalesHeader."No.";
            ExtDocNo := SalesHeader."External Document No.";
            YourRef := SalesHeader."Your Reference";
            OrderDate := SalesHeader."Order Date";
            PostingDate := SalesHeader."Posting Date";
            ShipmentDate := SalesHeader."Shipment Date";
            ShipMethod := SalesHeader."Shipment Method Code";
            OrderClass := SalesHeader."Order Class";
            ReqDeliveryDate := SalesHeader."Requested Delivery Date";
            PromisedDeliveryDate := SalesHeader."Promised Delivery Date";
            PackageTracking := SalesHeader."Package Tracking No.";
        end else begin
            SalesHeaderNo := SalesShipmentHeader."Order No.";
            ExtDocNo := SalesShipmentHeader."External Document No.";
            YourRef := SalesShipmentHeader."Your Reference";
            OrderDate := SalesShipmentHeader."Order Date";
            PostingDate := SalesShipmentHeader."Posting Date";
            ShipmentDate := SalesShipmentHeader."Shipment Date";
            ShipMethod := SalesShipmentHeader."Shipment Method Code";
            ReqDeliveryDate := SalesShipmentHeader."Requested Delivery Date";
            PromisedDeliveryDate := SalesShipmentHeader."Promised Delivery Date";
            PackageTracking := SalesShipmentHeader."Package Tracking No.";
        end;
    end;
}