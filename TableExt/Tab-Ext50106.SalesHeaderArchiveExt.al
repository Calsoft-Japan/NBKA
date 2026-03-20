

tableextension 50106 SalesHeaderArchiveExt extends "Sales Header Archive"
{
    fields
    {
        field(50000; "EC Order"; Boolean)
        {
            Caption = 'EC Order';
            ToolTip = 'Indicate whether it was received from EC';
            DataClassification = ToBeClassified;
        }
    }
}
