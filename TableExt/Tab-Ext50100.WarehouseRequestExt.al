tableextension 50100 WarehouseRequestExt extends "Warehouse Request"
{
    fields
    {
        field(50100; "Ship-to Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key7; "Ship-to Code")
        {
        }
    }
    fieldgroups
    {
    // Add changes to field groups here
    }
    var myInt: Integer;
}
