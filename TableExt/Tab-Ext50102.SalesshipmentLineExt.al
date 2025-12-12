namespace NBKAExtension_CalsoftSystems_.NBKAExtension_CalsoftSystems_;

using Microsoft.Sales.History;

tableextension 50102 SalesshipmentLineExt extends "Sales Shipment Line"
{
    fields
    {
        field(50000; "Certificate of Conformance"; Boolean)
        {
            Caption = 'Certificate of Conformance';
            DataClassification = ToBeClassified;
        }
        field(50017; "Ship-to PO No."; Code[100])
        {
            Caption = 'Ship-to PO No.';
            DataClassification = ToBeClassified;
            ToolTip = 'End user''s PO number';

        }
    }
}
