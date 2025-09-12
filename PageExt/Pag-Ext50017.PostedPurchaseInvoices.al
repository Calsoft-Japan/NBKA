pageextension 50017 "Posted Purchase Invoices Ext" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
    }
}
