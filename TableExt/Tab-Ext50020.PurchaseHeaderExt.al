//FDD311 Table Ext for Purchase Header
tableextension 50020 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50000; "EDI Order Completed"; Boolean)
        {
            Caption = 'EDI Order Completed';
        }
        field(50001; "EDI Order Completed Date-Time"; DateTime)
        {
            Caption = 'EDI Order Completed Date-Time';
        }
    }
}
