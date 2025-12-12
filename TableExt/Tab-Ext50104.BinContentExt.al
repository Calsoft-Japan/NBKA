namespace NBKA.NBKA;

using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Item;

tableextension 50104 "BinContentExt " extends "Bin Content"
{
    fields
    {
        field(50001; "Item Description"; text[100])
        {
            Caption = 'Item Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = field("Item No.")));
        }
        // modify("Item No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         ItemRec: Record Item;
        //     begin
        //         if ItemRec.get("Item No.") then
        //             "Item Description" := ItemRec.Description;
        //     end;
        // }
    }
}
