namespace NBKA.NBKA;

using Microsoft.Sales.Document;

pageextension 50013 SalesInvoiceext extends "Sales Invoice"
{
    layout
    {
        Addafter(Status)
        {
            field("Invoice Email"; Rec."Invoice Email")
            {
                ApplicationArea = all;
            }
        }
    }
}
