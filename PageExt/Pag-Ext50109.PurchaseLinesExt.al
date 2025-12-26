namespace NBKA.NBKA;

using Microsoft.Purchases.Document;

pageextension 50109 PurchaseLinesExt extends "Purchase Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Planned Receipt Date"; Rec."Planned Receipt Date")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
