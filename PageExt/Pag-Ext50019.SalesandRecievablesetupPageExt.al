namespace NBKA.NBKA;

using Microsoft.Sales.Setup;

pageextension 50019 SalesandRecievablesetupPageExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Price List Nos.")
        {
            field("Ship-to address No."; Rec."Ship-to address No.")
            {
                Caption = 'Ship-to address No.';
                ApplicationArea = all;
            }
        }
    }

}
