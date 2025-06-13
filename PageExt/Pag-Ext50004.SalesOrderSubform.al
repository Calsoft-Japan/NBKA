pageextension 50004 "SalesLine Ext" extends "Sales Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = All;
            }
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























































// field("Quantity (min)"; Rec."Quantity (min)")
// {
//     ApplicationArea = All;
// }
// field("Quantity (max)"; Rec."Quantity (max)")
// {
//     ApplicationArea = All;
// }
// field("Gross Profit Rate %"; Rec."Gross Profit Rate %")
// {
//     ApplicationArea = All;
// }
// field("Lead Time"; Rec."Lead Time")
// {
//     ApplicationArea = All;
// }