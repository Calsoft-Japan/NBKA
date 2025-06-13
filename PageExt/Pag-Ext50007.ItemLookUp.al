pageextension 50007 ItemLookupExt extends "Item Lookup"
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
        }
    }
}
