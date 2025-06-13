//FDD301 NBK API table CREATE CUSTOMER.
table 50024 "NBKAPITBL_INSTOKUCD"
{
    Caption = 'NBKAPITBL_INSTOKUCD';
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
        field(6; "Customer No."; CODE[20])
        {
            Caption = 'Customer No.';
        }
        field(7; "TNAME"; Text[100])
        {
            Caption = 'TNAME';
        }
        field(8; "TADDRESS"; Text[100])
        {
            Caption = 'TADDRESS';
        }
        field(9; "TADDRESS2"; Text[50])
        {
            Caption = 'TADDRESS2';
        }
        field(10; "TCOUNTRY"; Text[10])
        {
            Caption = 'TCOUNTRY';
        }
        field(11; "TCITY"; Text[30])
        {
            Caption = 'TCITY';
        }
        field(12; "TSTATE"; Text[30])
        {
            Caption = 'TSTATE';
        }
        field(13; "TPOSTCODE"; Text[20])
        {
            Caption = 'TPOSTCODE';
        }
        field(14; "TTELNO"; Text[30])
        {
            Caption = 'TTELNO';
        }
        field(15; "EMAIL"; Text[80])
        {
            Caption = 'EMAIL';
        }
        field(16; "URL"; Text[80])
        {
            Caption = 'URL';
        }
        field(17; "TCONTACT"; Text[100])
        {
            Caption = 'TCONTACT';
        }
        field(18; "RESELLER"; Text[50])
        {
            Caption = 'RESELLER';
        }
        field(19; "USERCD"; Text[50])
        {
            Caption = 'USERCD';
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
