namespace NBKA.NBKA;

using Microsoft.Sales.Customer;

pageextension 50016 "Ship-toAddressListExt" extends "Ship-to Address List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
            {
                ApplicationArea = Basic, Suite;
            }

        }
    }
}
