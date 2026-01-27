namespace NBKA.NBKA;

using Microsoft.Inventory.Item;

tableextension 50105 ItemTemplext extends "Item Templ."
{
    fields
    {
        field(50004; "Special Product"; Boolean)
        {
            ToolTip = 'Specifies if the item is special product';
        }
    }
}
