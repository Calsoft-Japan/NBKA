namespace NBKA.NBKA;

using Microsoft.Sales.History;

tableextension 50006 SalesInvoiceHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50012; "Invoice Email"; Text[300])
        {
            Caption = 'Invoice Email';
        }
    }
}
