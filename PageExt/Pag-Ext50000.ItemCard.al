pageextension 50000 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter("Description")
        {
            field("P/N"; Rec."P/N")
            {
                ApplicationArea = all;
            }
            field("Web Product No."; Rec."Web Product No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Item Category Code")
        {
            field("Special Product"; Rec."Special Product")
            {
                ApplicationArea = all;
            }
            field("Effective Date"; Rec."Effective Date")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                NotBlank = true;
            }
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                NotBlank = true;
            }
        }
    }
}
