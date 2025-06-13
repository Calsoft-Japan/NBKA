tableextension 50004 "SalesLine Ext" extends "Sales Line"
{
    fields
    {
        field(50000; "Certificate of Conformance"; Boolean)
        {
            ToolTip = 'Print Certificate of Conformance when Ship is posted';
            Caption = 'Certificate of Conformance';
            DataClassification = ToBeClassified;
        }
        field(50001; "P/N"; Code[50])
        {
            Caption = 'P/N';
            DataClassification = CustomerContent;
        }
        field(50002; "Web Product No."; Code[50])
        {
            Caption = 'Web Product No.';
            DataClassification = CustomerContent;
        }
        field(50003; "Quantity (min)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity (min)';
            Editable = false;
        }
        field(50004; "Quantity (max)"; Decimal)
        {
            Caption = 'Quantity (max)';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50005; "Gross Profit Rate %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Gross Profit Rate %';
        }
        field(50006; "Lead Time"; Integer)
        {
            Caption = 'Lead Time';
            DataClassification = ToBeClassified;
        }
        field(50007; "Discount Rate Updated"; Boolean)
        {
            ToolTip = 'Mark if the default rate has been changed.';
            DataClassification = ToBeClassified;
        }

        field(50008; "Gross Profit Rate Updated"; Boolean)
        {
            ToolTip = 'Mark if the default rate has been changed.';
            DataClassification = ToBeClassified;
        }
        field(50009; "Special Product"; Boolean)
        {
            ToolTip = 'Specifies if the item is a Special Product.';
            DataClassification = ToBeClassified;
        }
    }
}
