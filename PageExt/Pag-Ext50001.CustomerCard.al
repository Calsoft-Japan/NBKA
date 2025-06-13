pageextension 50001 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = all;
            }
            field("Special Order Work"; Rec."Special Order Work")
            {
                ApplicationArea = all;
            }
            field("Special Shipping Work"; Rec."Special Shipping Work")
            {
                ApplicationArea = all;
            }

        }

    }

}
