namespace NBKA.NBKA;

using Microsoft.Pricing.PriceList;

pageextension 50117 PriceListLinesExt extends "Price List Lines"
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
