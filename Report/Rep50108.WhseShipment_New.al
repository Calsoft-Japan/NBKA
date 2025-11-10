
report 50108 "Whse. - Shipment New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/WhseShipmentNew.rdl';
    ApplicationArea = all;
    Caption = 'Warehouse Shipment';
    UsageCategory = Documents;

    dataset
    {
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(HeaderNo_WhseShptHeader; "No.")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(CompanyName; COMPANYPROPERTY.DisplayName())
                {
                }
                column(TodayFormatted; Format(Today, 0, 4))
                {
                }
                column(AssUid__WhseShptHeader; "Warehouse Shipment Header"."Assigned User ID")
                {
                    IncludeCaption = true;
                }
                column(HrdLocCode_WhseShptHeader; "Warehouse Shipment Header"."Location Code")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_WhseShptHeader; "Warehouse Shipment Header"."No.")
                {
                    IncludeCaption = true;
                }
                column(Show1; not Location."Bin Mandatory")
                {
                }
                column(Show2; Location."Bin Mandatory")
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(WarehouseShipmentCaption; WarehouseShipmentCaptionLbl)
                {
                }
                column(Picklistlbl; Picklistlbl)
                {
                }

                column(Customerlbl; Customerlbl)
                {
                }

                column(Shiptoaddresslbl; Shiptoaddresslbl)
                {
                }

                column(Datelbl; Datelbl)
                {
                }

                column(Pagelbl; Pagelbl)
                {
                }

                column(Whslbl; Whslbl)
                {
                }

                column(FreightPaymentbylbl; FreightPaymentbylbl)
                {
                }

                column(CustomerAccountLbl; CustomerAccountLbl)
                {
                }

                column(ShippingAgentlbl; ShippingAgentlbl)
                {
                }

                column(ShippingAgentServicelbl; ShippingAgentServicelbl)
                {
                }
                column(Workdescriptionlbl; Workdescriptionlbl)
                {
                }
                column(SalesHeader_selltocustname; SalesHeader."Sell-to Customer Name")
                {
                }
                column(ShippingAgent_Name; ShippingAgent.Name)
                {
                }
                column(ShippingAgentService_Description; ShippingAgentService.Description)
                {
                }
                column(ShippingAgentService_code; ShippingAgentService.Code)
                {
                }

                column(ShipToAddress1; ShipToAddress[1])
                {
                }
                column(ShipToAddress2; ShipToAddress[2])
                {
                }
                column(ShipToAddress3; ShipToAddress[3])
                {
                }
                column(ShipToAddress4; ShipToAddress[4])
                {
                }
                column(ShipToAddress5; ShipToAddress[5])
                {
                }
                column(ShipToAddress6; ShipToAddress[6])
                {
                }
                column(ShipToAddress7; ShipToAddress[7])
                {
                }
                column(ShipToAddress8; ShipToAddress[8])
                {
                }
                column(EncodedTxt; EncodedTxt)
                {
                }
                column(FreightPaymentby_DshipPackageOptions; DshipPackageOptions."Payment Type")
                {
                }
                column(CustomerAccount_DshipPackageOptions; DshipPackageOptions."Payment Account No.")
                {
                }
                dataitem("Warehouse Shipment Line"; "Warehouse Shipment Line")
                {
                    DataItemLink = "No." = field("No.");
                    DataItemLinkReference = "Warehouse Shipment Header";
                    DataItemTableView = sorting("No.", "Line No.");
                    column(ShelfNo_WhseShptLine; "Shelf No.")
                    {
                        IncludeCaption = true;
                    }
                    column(LineNo__WhseShptLine; "Line No.")
                    {
                    }
                    column(ItemNo_WhseShptLine; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Desc_WhseShptLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(UomCode_WhseShptLine; "Unit of Measure Code")
                    {
                        IncludeCaption = true;
                    }
                    column(LocCode_WhseShptLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Qty_WhseShptLine; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(shippingdate_whsshptLine; SalesLine."Shipping Date")
                    {
                    }
                    column(SourceNo_WhseShptLine; "Source No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SourceDoc_WhseShptLine; "Source Document")
                    {
                        IncludeCaption = true;
                    }
                    column(ZoneCode_WhseShptLine; "Zone Code")
                    {
                        IncludeCaption = true;
                    }
                    column(BinCode_WhseShptLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Item_Prod_no_lbl; Item_Prod_no_lbl)
                    {
                    }
                    column(SOlbl; SOlbl)
                    {
                    }
                    column(Shipdatelbl; Shipdatelbl)
                    {
                    }
                    column(Qtylbl; Qtylbl)
                    {
                    }
                    column(UOMlbl; UOMlbl)
                    {
                    }
                    column(COClbl; COClbl)
                    {
                    }
                    column(DueDate_WhseShptLine; "Due Date")
                    {
                    }
                    column(Coc_salesline; coc)
                    {
                    }
                    column(WorkDescription; WorkDescription)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        WhsShpLine: Record "Warehouse Shipment Line";
                    begin
                        Clear(coc);
                        Clear(WorkDescription);
                        this.GetLocation("Location Code");

                        if SalesLine.Get(SalesLine."Document Type"::Order, "Warehouse Shipment Line"."Source No.", "Warehouse Shipment Line"."Source Line No.") then begin
                            if SalesLine."Certificate of Conformance" then
                                coc := 'Y';
                        end;

                        if SalesHeader.get(SalesHeader."Document Type"::Order, "Warehouse Shipment Line"."Source No.") then begin
                            WorkDescription := '(' + SalesHeader."No." + ') ';
                            SalesHeader.CalcFields("Work Description");
                            SalesHeader."Work Description".CreateInStream(Instr);
                            Instr.ReadText(BufferText);
                            if BufferText <> '' then
                                WorkDescription := WorkDescription + BufferText
                            else
                                WorkDescription := '';
                        end;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                WhsShpLine: Record "Warehouse Shipment Line";
            begin
                this.GetLocation("Location Code");
                WhsShpLine.SetRange("No.", "No.");
                WhsShpLine.SetRange("Source Document", WhsShpLine."Source Document"::"Sales Order");
                if WhsShpLine.FindFirst() then
                    if SalesHeader.get(SalesHeader."Document Type"::Order, WhsShpLine."Source No.") then begin
                        ShipToAddress[1] := SalesHeader."Ship-to Name";
                        ShipToAddress[2] := SalesHeader."Ship-to Contact";
                        ShipToAddress[3] := SalesHeader."Ship-to Address";
                        ShipToAddress[4] := SalesHeader."Ship-to Address 2";
                        ShipToAddress[5] := SalesHeader."Ship-to City";
                        ShipToAddress[6] := SalesHeader."Ship-to County";
                        ShipToAddress[7] := SalesHeader."Ship-to Post Code";
                        If SalesHeader."Ship-to Country/Region Code" <> '' then
                            if Country.Get(SalesHeader."Ship-to Country/Region Code") then
                                ShipToAddress[8] := Country.Name;
                        if ShippingAgent.Get(SalesHeader."Shipping Agent Code") then;
                        if ShippingAgentService.Get(SalesHeader."Shipping Agent Code", SalesHeader."Shipping Agent Service Code") then;
                        if DshipPackageOptions.Get(SalesHeader."No.") then;
                    end;

                Barcodefontprovider := Enum::"Barcode Font Provider"::IDAutomation1D;
                Barcodesymbology := Enum::"Barcode Symbology"::Code128;
                BarcodeStr := '*' + "No." + '*';
                Barcodefontprovider.ValidateInput(BarcodeStr, Barcodesymbology);
                EncodedTxt := Barcodefontprovider.EncodeFont(BarcodeStr, Barcodesymbology);

            end;
        }
    }

    requestpage
    {
        Caption = 'Warehouse Shipment';

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DshipPackageOptions: Record "DSHIP Package Options";
        Barcodesymbology: enum "Barcode Symbology";
        Barcodefontprovider: Interface "Barcode Font Provider";
        TempBlob: Codeunit "Temp Blob";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentService: Record "Shipping Agent Services";
        FormatAddress: Codeunit "Format Address";
        Country: Record "Country/Region";
        ShipToAddress: array[8] of Text[100];
        WorkDescription: Text;
        BufferText: Text;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Location: Record Location;
        CurrReportPageNoCaptionLbl: Label 'Page';
        WarehouseShipmentCaptionLbl: Label 'Warehouse Shipment';
        Picklistlbl: Label 'Pick List';
        Customerlbl: Label 'Customer:';
        Datelbl: Label 'Date';
        Pagelbl: Label 'Page';
        Whslbl: Label 'WHS#';
        FreightPaymentbylbl: Label 'Freight Payment by';
        CustomerAccountLbl: Label 'Customer Account#';
        ShippingAgentlbl: Label 'Shipping Agent';
        ShippingAgentServicelbl: Label 'Shipping Agent Service';
        Workdescriptionlbl: Label 'Work description:';
        Item_Prod_no_lbl: Label 'Item No./Product No.';
        SOlbl: Label 'SO#';
        Shipdatelbl: Label 'Ship date';
        Qtylbl: Label 'Qty.';
        UOMlbl: Label 'UOM';
        COClbl: Label 'COC';
        Shiptoaddresslbl: Label 'Ship-to address:';
        BarcodeStr, EncodedTxt, coc : Text;


        Instr: InStream;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init()
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;
}

