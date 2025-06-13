pageextension 50009 "Customer List Ext" extends "Customer List"
{
    layout
    {
        addafter("Contact")
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = All;
            }
            field("Special Order Work"; Rec."Special Order Work")
            {
                ApplicationArea = All;
            }
            field("Special Shipping Work"; Rec."Special Shipping Work")
            {
                ApplicationArea = All;
            }
        }
    }
}
