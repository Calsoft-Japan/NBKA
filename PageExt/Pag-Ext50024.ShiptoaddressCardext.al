namespace NBKA.NBKA;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Setup;

pageextension 50024 ShiptoaddressCardext extends "Ship-to Address"
{
    layout
    {
        modify(Code)
        {
            trigger OnAssistEdit()
            begin
                if Rec.AssistEdit(xRec) then
                    CurrPage.Update();
            end;
        }
    }
}
