namespace NBKA.NBKA;

using Microsoft.Sales.History;

pageextension 50104 PostedSalesShipmentLinesExt extends "Posted Sales Shipment Lines"
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Ship-to PO No."; Rec."Ship-to PO No.")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'End user''s PO number';

            }
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'Gets the certificate of conformance value from sales line';

            }
        }
    }
}
