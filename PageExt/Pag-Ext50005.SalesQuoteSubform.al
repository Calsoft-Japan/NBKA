pageextension 50005 "Sales Quote Subform Ext" extends "Sales Quote Subform"
{
    layout
    {
        addafter("Description")
        {
            field("P/N"; Rec."P/N")
            {
                ApplicationArea = All;
            }
            field("Web Product No."; Rec."Web Product No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Special Product"; Rec."Special Product")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Line Discount %")
        {
            Visible = false;
            Editable = false;
        }
        addafter("Line Discount %")
        {
            field("Original Price"; Rec."Original Price")
            {
                ApplicationArea = All;
                Caption = 'Original Price';
            }
            field("Original Discount %"; Rec."Original Discount %")
            {
                ApplicationArea = All;
                Caption = 'Original Discount %';
            }
            field("Discount Rate"; Rec."Discount Rate")
            {
                ApplicationArea = All;
                Caption = 'Discount Rate';
            }
        }
        addafter("Amount Including VAT")
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = All;
            }
            field("Quantity (min)"; Rec."Quantity (min)")
            {
                ApplicationArea = All;
            }
            field("Quantity (max)"; Rec."Quantity (max)")
            {
                ApplicationArea = All;
            }
            field("Gross Profit Rate %"; Rec."Gross Profit Rate %")
            {
                ApplicationArea = All;
            }
            field("Lead Time"; Rec."Lead Time")
            {
                ApplicationArea = All;
                //Visible = false;//FDD003
            }
            field("Discount Rate Updated"; Rec."Discount Rate Updated")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Updated when Approval Workflow API executed.';
            }
            field("Gross Profit Rate Updated"; Rec."Gross Profit Rate Updated")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Updated when Approval Workflow API is executed.';
            }
        }
        //==========FDD003=============
        addafter("Gross Profit Rate %")
        {
            field("Lead Time text"; Rec."Lead Time text")
            {
                ApplicationArea = All;
            }
        }
        //===========FDD003===========
    }

    actions
    {
        addafter("Dimensions")
        {
            action(DiscountPrice)
            {
                Caption = 'Discount Price';
                ApplicationArea = All;
                Image = Discount;
                trigger OnAction()
                var
                    CalcPrice: Codeunit "Discount Price";
                    SalesHeader: Record "Sales Header";
                begin
                    if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
                        CalcPrice.RunForDocument(SalesHeader);
                end;
            }

            //===========FDD003===========
            action("Calculate Price")
            {
                ApplicationArea = All;
                Caption = 'Calculate Price';
                Image = Calculate;
                ToolTip = 'Executes the Price Calculation process.';

                trigger OnAction()
                var
                    PgSalesQuoteCal: Page "Quote Price Calculation";
                    QuPrice: Record "Quote Price Calculation" temporary;
                begin
                    if (Rec."Document Type" = Rec."Document Type"::Quote) and (Rec.Type = Rec.Type::Item) then begin// and (Rec."Unit Price" = 0) 
                        PgSalesQuoteCal.InitPage(Rec);
                        PgSalesQuoteCal.LookupMode(true);
                        if PgSalesQuoteCal.RunModal() = Action::LookupOK then begin
                            PgSalesQuoteCal.GetRecord(QuPrice);
                            Rec."Quantity (min)" := QuPrice."Quantity (min)";
                            Rec."Quantity (max)" := QuPrice."Quantity (max)";
                            //Rec."Lead Time" := QuPrice."Lead Time";
                            Rec."Lead Time text" := Format(QuPrice."Lead Time");
                            Rec."Gross Profit Rate %" := QuPrice."Gross Profit Rate %";
                            Rec."Gross Profit Rate Updated" := QuPrice."Gross Profit Rate Updated";
                            Rec.Validate("Unit of Measure Code", QuPrice."Unit Type");//Rec."Unit of Measure Code" := QuPrice."Unit Type";
                            if QuPrice."Quantity (max)" <> 0 then
                                Rec.Validate(Quantity, QuPrice."Quantity (max)") //Rec.Quantity := QuPrice."Quantity (max)"
                            else
                                Rec.Validate(Quantity, QuPrice."Quantity (min)");//Rec.Quantity := QuPrice."Quantity (min)";
                            Rec.Validate("Line Discount %", 0);
                            Rec.Validate("Unit Price", QuPrice."Quote Unit Price");//Rec."Unit Price" := QuPrice."Quote Amount Price";
                        end;
                    end else
                        Message(StrSubstNo('%1 is not a special item.(Doc Type: %2,Rec Type: %3,Unit Price: %4)', Rec."No.", Format(Rec."Document Type"), Format(Rec.Type), Format(Rec."Unit Price")));
                end;
            }
            //===========FDD003===========
        }
    }
}
