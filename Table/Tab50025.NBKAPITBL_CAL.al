//FDD302 NBK API table Get Calendar.
table 50025 "NBKAPITBL_CAL"
{
    Caption = 'NBKAPITBL_CAL';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "P_RTCD"; Text[2])
        {
            Caption = 'P_RTCD';
            Editable = false;
        }
        field(2; "P_ERRCD"; Text[20])
        {
            Caption = 'P_ERRCD';
            Editable = false;
        }
        field(3; "P_ERRMSG"; Text[250])
        {
            Caption = 'P_ERRMSG';
            Editable = false;
        }
        field(4; "YYMMDD"; Text[8])
        {
            Caption = 'YYMMDD';
            Editable = false;
        }
        field(5; "HANTEIS"; Text[1])
        {
            Caption = 'HANTEIS';
            Editable = false;
        }
        field(6; "HANTEIK"; Text[1])
        {
            Caption = 'HANTEIK';
            Editable = false;
        }
        field(7; "YOBIKB"; Text[1])
        {
            Caption = 'YOBIKB';
            Editable = false;
        }
        field(8; "YOUBI"; Text[3])
        {
            Caption = 'YOUBI';
            Editable = false;
        }
        field(9; "FROMTIME"; Text[4])
        {
            Caption = 'FROMTIME';
        }
        field(10; "TOTIME"; Text[4])
        {
            Caption = 'TOTIME';
        }
    }
    keys
    {
        key(PK; "P_RTCD", "P_ERRCD", "P_ERRMSG", "YYMMDD")
        {
            Clustered = true;
        }
    }
}
