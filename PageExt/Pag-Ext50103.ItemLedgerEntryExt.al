namespace NBKA.NBKA;

using Microsoft.Inventory.Ledger;

pageextension 50103 ItemLedgerEntryExt extends "Item Ledger Entries"
{
    actions
    {
        addafter("&Value Entries")
        {
            action(ProductLabel)
            {
                Caption = 'ProductLabel';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    ProductLabelReport: Report ItemLedgerProductLabel;
                    ItemLedgEntry: Record "Item Ledger Entry";
                begin
                    Clear(ProductLabelReport);
                    ProductLabelReport.setfilters(Format(Rec."Entry No."));
                    ProductLabelReport.Run();
                end;
            }
        }

    }
}
