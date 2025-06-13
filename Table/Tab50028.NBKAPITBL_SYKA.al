//FDD306 NBKA API table ANNOKI.
table 50028 "NBKAPITBL_SYKA"
{
    Caption = 'NBKAPITBL_SYKA';
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
        field(6; JUCH1; Text[20])
        {
            Caption = 'JUCH1';
        }
        field(7; SYKABI; Text[8])
        {
            Caption = 'SYKABI';
        }
        field(8; OKURNO; Text[30])
        {
            Caption = 'OKURNO';
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
