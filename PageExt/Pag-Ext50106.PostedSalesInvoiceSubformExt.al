namespace NBKA.NBKA;

using Microsoft.Sales.History;

pageextension 50106 PostedSalesInvoiceSubformExt extends "Posted Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Ship-to PO No."; Rec."Ship-to PO No.")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'End user''s PO number';

            }
        }
    }

}
