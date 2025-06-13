pageextension 50006 "VendorListExt" extends "Vendor List"
{
    layout
    {
        addlast(Control1)
        {
            field("Expenses Rate %"; Rec."Expenses Rate %")
            {
                ApplicationArea = All;
            }
            field("EDI Target"; Rec."EDI Target")
            {
                ApplicationArea = All;
            }
        }
    }
}
