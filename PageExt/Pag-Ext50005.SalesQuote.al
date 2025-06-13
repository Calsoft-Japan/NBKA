pageextension 50005 "Sales Quote Subform Ext" extends "Sales Quote Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = All;
                // trigger OnValidate()
                // var
                //     CustomerRec: Record Customer;
                //     SalesHeaderRec: Record "Sales Header";
                // begin
                //     //Get the Sales Header linked to this Sales Line
                //     if SalesHeaderRec.Get(Rec."Document Type", Rec."Document No.") then begin
                //         //fetch the customer using "Sell-to Customer No."
                //         if CustomerRec.Get(SalesHeaderRec."Sell-to Customer No.") then
                //             Rec.Validate("Certificate of Conformance", CustomerRec."Certificate of Conformance");
                //     end;
                // end;
            }

            field("P/N"; Rec."P/N")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    ItemRec: Record Item;
                begin
                    if Rec.Type = Rec.Type::Item then begin
                        if ItemRec.Get(Rec."Sell-to Customer No.") then begin
                            Rec.Validate("P/N", ItemRec."P/N");
                        end;
                    end;
                end;
            }

            field("Web Product No."; Rec."Web Product No.")
            {
                ApplicationArea = All;
                Visible = false;

                trigger OnValidate()
                var
                    ItemRec: Record Item;
                begin
                    if Rec.Type = Rec.Type::Item then begin
                        if ItemRec.Get(Rec."Sell-to Customer No.") then begin
                            Rec.Validate("Web Product No.", ItemRec."Web Product No.");
                        end;
                    end;
                end;
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
            }
        }
    }


    actions
    {
        addafter("Dimensions")
        {
            //    action("Price Calculation")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Price Calculation';
            //         Image = Calculate;
            //         ToolTip = 'Executes the Price Calculation process.';

            //         trigger OnAction()
            //         begin
            //             // Logic to be added later
            //             Message('Price Calculation executed!');
            //         end;
            //     }
        }
    }
}
