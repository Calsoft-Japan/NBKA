namespace NBKA.NBKA;

using Microsoft.Sales.Document;

pageextension 50015 SalesquoteExt extends "Sales Quote"
{
    layout
    {
        modify("Shipping Agent Code")
        {
            Editable = false;
        }
        modify("Shipping Agent Service Code")
        {
            Editable = false;
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }
        modify("Payment Method Code")
        {
            Editable = false;
        }
    }
}
