table 50020 "Gross Profit Rate"
{
    Caption = 'Gross Profit Rate';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer Type"; Code[20])
        {
            Caption = 'Customer Type';
            TableRelation = "Customer Discount Group".Code;
        }
        field(2; "Item Category"; Code[20])
        {
            Caption = 'Item Category';
            TableRelation = "Item Discount Group".Code;
        }
        field(3; "Gross Profit Rate %"; Decimal)
        {
            Caption = 'Gross Profit Rate %';
        }
    }
    keys
    {
        key(PK; "Customer Type", "Item Category")
        {
            Clustered = true;
        }
    }
}
