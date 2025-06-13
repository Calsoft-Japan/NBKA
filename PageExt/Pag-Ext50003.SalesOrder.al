pageextension 50003 "SalesOrderExt" extends "Sales Order"
{
    layout
    {
        addbefore("Work Description")
        {
            field("EC Order"; Rec."EC Order")
            {
                ApplicationArea = All;
            }
            field("Special Order Work"; Rec."Special Order Work")
            {
                ApplicationArea = All;
                // trigger OnValidate()
                // var
                //     CustomerRec: Record Customer;
                // begin
                //     if Rec."No." <> '' then begin
                //         if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                //             Rec."Special Order Work" := CustomerRec."Special Order Work";
                //         end;
                //     end;
                // end;
            }
            field("Special Order Work Completed"; Rec."Special Order Work Completed")
            {
                ApplicationArea = All;
            }
            field("Special Shipping Work"; Rec."Special Shipping Work")
            {
                ApplicationArea = All;
                // trigger OnValidate()
                // var
                //     CustomerRec: Record Customer;
                // begin
                //     if Rec."No." <> '' then begin
                //         if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                //             Rec."Special Shipping Work" := CustomerRec."Special Shipping Work";
                //         end;
                //     end;
                // end;
            }
            field("Special Shipping Work Completed"; Rec."Special Shipping Completed")
            {
                ApplicationArea = All;
            }
        }
    }
}







