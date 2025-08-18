namespace NBKA.NBKA;

using Microsoft.Sales.History;

pageextension 50014 Postedsalesinvoiceext extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("Invoice Email"; Rec."Invoice Email")
            {
                ApplicationArea = all;
            }
        }
    }
}
