namespace NBKA.NBKA;

using Microsoft.Sales.History;

tableextension 50103 SalesInvoiceLineExt extends "Sales Invoice Line"
{
    fields
    {
        field(50017; "Ship-to PO No."; Code[100])
        {
            Caption = 'Ship-to PO No.';
            DataClassification = ToBeClassified;
            ToolTip = 'End user''s PO number';

        }
    }
}
