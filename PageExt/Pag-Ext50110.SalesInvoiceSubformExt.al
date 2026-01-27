namespace NBKA.NBKA;

using Microsoft.Sales.Document;

pageextension 50110 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Item Reference No.")
        {
            field("Ship-to PO No."; Rec."Ship-to PO No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'End user''s PO number';
            }
        }
    }
}
