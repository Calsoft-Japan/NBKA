pageextension 50020 "Sales Quote Subform Ext 2" extends "Sales Quote Subform"
{
    actions
    {
        addafter("Dimensions")
        {
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
                            Rec."Lead Time" := QuPrice."Lead Time";
                            Rec."Gross Profit Rate %" := QuPrice."Gross Profit Rate %";
                            Rec."Gross Profit Rate Updated" := QuPrice."Gross Profit Rate Updated";
                            Rec.Validate("Unit of Measure Code", QuPrice."Unit Type");//Rec."Unit of Measure Code" := QuPrice."Unit Type";
                            if QuPrice."Quantity (max)" <> 0 then
                                Rec.Validate(Quantity, QuPrice."Quantity (max)") //Rec.Quantity := QuPrice."Quantity (max)"
                            else
                                Rec.Validate(Quantity, QuPrice."Quantity (min)");//Rec.Quantity := QuPrice."Quantity (min)";
                            Rec.Validate("Unit Price", QuPrice."Quote Unit Price");//Rec."Unit Price" := QuPrice."Quote Amount Price";
                        end;
                    end else
                        Message(StrSubstNo('%1 is not a special item.(Doc Type: %2,Rec Type: %3,Unit Price: %4)', Rec."No.", Format(Rec."Document Type"), Format(Rec.Type), Format(Rec."Unit Price")));
                end;
            }
        }
    }
}
