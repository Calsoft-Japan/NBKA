pageextension 50008 ItemListExt extends "Item List"
{
    layout
    {
        addbefore("Description")
        {
            field("P/N"; Rec."P/N")
            {
                ApplicationArea = All;
            }
            field("Web Product No."; Rec."Web Product No.")
            {
                ApplicationArea = All;
            }
        }

        addlast(Control1)
        {
            field("Effective Date"; Rec."Effective Date")
            {
                ApplicationArea = All;
            }
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
            }
            field("Special Product"; Rec."Special Product")
            {
                ApplicationArea = All;
            }
        }
    }
}
