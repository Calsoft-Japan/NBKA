namespace NBKA.NBKA;

using Microsoft.Inventory.Item;

pageextension 50111 ItemTemplCardext extends "Item Templ. Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Special Product"; Rec."Special Product")
            {
                ApplicationArea = all;
            }

        }

    }
}
