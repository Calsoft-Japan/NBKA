pageextension 50002 "Vendor Card Ext" extends "vendor Card"
{
    layout
    {
        addafter("Payment method Code")
        {
            field("Expenses Rate %"; Rec."Expenses Rate %")
            {
                ApplicationArea = all;
            }

        }

        addafter("Responsibility Center")
        {
            field("EDI Target"; Rec."EDI Target")
            {
                ApplicationArea = all;
            }

        }

    }

}
