//FDD311 Page Ext for Purchase Order
pageextension 50022 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("EDI Order Completed"; Rec."EDI Order Completed")
            {
                ApplicationArea = All;
            }
            field("EDI Order Completed Date-Time"; Rec."EDI Order Completed Date-Time")
            {
                ApplicationArea = All;
            }
        }
    }
}
