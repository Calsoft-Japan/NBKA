namespace NBKA.NBKA;

using Microsoft.Warehouse.Structure;

pageextension 50107 BinContentsExt extends "Bin Contents"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item_Description"; Rec."Item Description")
            {
                Caption = 'Item Description';
                Editable = false;
                ApplicationArea = all;
            }
        }
    }
}
