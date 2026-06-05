namespace NBKA.NBKA;

using Microsoft.Pricing.PriceList;
using Microsoft.Inventory.Item;

tableextension 50107 PriceListLineExt extends "Price List Line"
{
    fields
    {
        field(50002; "P/N"; Code[50])
        {
            ToolTip = 'Specifies P/N of the item';
        }
        modify("Product No.")
        {
            trigger OnAfterValidate()
            var
                Itemvar: Record Item;
            begin
                if ("Asset Type" = "Asset Type"::Item) and ("Product No." <> '') then begin
                    if ItemVar.Get("Product No.") then
                        "P/N" := ItemVar."P/N";
                end;
            end;
        }
    }
}
