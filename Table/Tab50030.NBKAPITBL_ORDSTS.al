//FDD304 NBKA API table ORDSTS.
table 50030 "NBKAPITBL_ORDSTS"
{
    Caption = 'NBKAPITBL_ORDSTS';
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
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
