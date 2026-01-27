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
        modify(Name)
        {
            ShowMandatory = true;
        }
        modify(Address)
        {
            ShowMandatory = true;
        }
        modify(City)
        {
            ShowMandatory = true;
        }
        modify(County)
        {
            ShowMandatory = true;
        }
        modify("Post Code")
        {
            ShowMandatory = true;
        }
        modify("Country/Region Code")
        {
            ShowMandatory = true;
        }
        modify("Phone No.")
        {
            ShowMandatory = true;
        }
        modify("Location Code")
        {
            ShowMandatory = true;
        }
        modify("Shipping Agent Code")
        {
            ShowMandatory = true;
        }
        modify("Shipping Agent Service Code")
        {
            ShowMandatory = true;
        }
        modify("Tax Liable")
        {
            ShowMandatory = true;
        }
        modify("Tax Area Code")
        {
            ShowMandatory = true;
        }
    }
}
