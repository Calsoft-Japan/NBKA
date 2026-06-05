namespace NBKA.NBKA;

using Microsoft.Purchases.Pricing;

pageextension 50118 PurchasePriceListLinesExt extends "Purchase Price List Lines"
{
    layout
    {
        addafter(Description)
        {
            field("P/N"; Rec."P/N")
            {
                ApplicationArea = all;
            }
        }
    }
}
