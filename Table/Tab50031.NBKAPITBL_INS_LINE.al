//FDD303 NBK API table Create Order Line.
table 50031 "NBKAPITBL_INS_LINE"
{
    Caption = 'NBKAPITBL_INS_LINE';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Created datetime"; DateTime)
        {
            Caption = 'Created datetime';
            Editable = false;
        }
        field(3; "P_RTCD"; Text[2])
        {
            Caption = 'P_RTCD';
            Editable = false;
        }
        field(4; "P_ERRCD"; Text[20])
        {
            Caption = 'P_ERRCD';
            Editable = false;
        }
        field(5; "P_ERRMSG"; Text[250])
        {
            Caption = 'P_ERRMSG';
            Editable = false;
        }
        field(6; "Header Entry No."; Integer)
        {
            Caption = 'Header Entry No.';
            Editable = false;
        }
        field(7; "CART2"; Text[35])
        {
            Caption = 'CART2';
        }
        field(8; "SEHNCD"; Code[50])
        {
            Caption = 'SEHNCD';
        }
        field(9; "QTY"; Decimal)
        {
            Caption = 'QTY';
        }
        field(10; "UNITPRICE"; Decimal)
        {
            Caption = 'UNITPRICE';
        }
        field(11; "REQUESTDATE"; Date)
        {
            Caption = 'REQUESTDATE';
        }
        field(12; "JUCH2"; Integer)
        {
            Caption = 'JUCH2';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
