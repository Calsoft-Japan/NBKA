//FDD303 NBK API table Create Order.
table 50026 "NBKAPITBL_INS"
{
    Caption = 'NBKAPITBL_INS';
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
        field(6; "CART1"; Text[35])
        {
            Caption = 'CART1';
        }
        field(7; "TOKUCD"; Code[20])
        {
            Caption = 'TOKUCD';
        }
        field(8; "NONYCD"; Code[10])
        {
            Caption = 'NONYCD';
        }
        field(9; "FREIGHT"; Decimal)
        {
            Caption = 'FREIGHT';
        }
        field(10; "AMOUNT"; Decimal)
        {
            Caption = 'AMOUNT';
        }
        field(11; "SHIPAGENT"; Code[10])
        {
            Caption = 'SHIPAGENT';
        }

        //CR: FDD303/add new field
        field(12; "SHIPSERVICE"; Text[10])
        {
            Caption = 'SHIPSERVICE';
        }
        //End CR: FDD303/add new field

        field(13; "PAYMENT"; Code[10])
        {
            Caption = 'PAYMENT';
        }
        field(14; "ORDERDATE"; Date)
        {
            Caption = 'ORDERDATE';
        }
        field(15; "TNAME"; Text[100])
        {
            Caption = 'TNAME';
        }
        field(16; "TPOSTCODE"; Text[20])
        {
            Caption = 'TPOSTCODE';
        }
        field(17; "TADDRESS"; Text[100])
        {
            Caption = 'TADDRESS';
        }
        field(18; "TADDRESS2"; Text[50])
        {
            Caption = 'TADDRESS2';
        }
        field(19; "TTELNO"; Text[30])
        {
            Caption = 'TTELNO';
        }
        field(20; "TCOUNTRY"; Text[10])
        {
            Caption = 'TCOUNTRY';
        }
        field(21; "TCITY"; Text[30])
        {
            Caption = 'TCITY';
        }
        field(22; "TSTATE"; Text[30])
        {
            Caption = 'TSTATE';
        }
        field(23; "TCONTACT"; Text[100])
        {
            Caption = 'TCONTACT';
        }
        field(24; "UPSACCOUNT"; Text[80])
        {
            Caption = 'UPSACCOUNT';
        }
        field(25; "FDXACCOUNT"; Text[80])
        {
            Caption = 'FDXACCOUNT';
        }
        field(26; "RESELLER"; Text[50])
        {
            Caption = 'RESELLER';
        }
        field(27; "NNAME"; Text[100])
        {
            Caption = 'NNAME';
        }
        field(28; "NADDRESS"; Text[100])
        {
            Caption = 'NADDRESS';
        }
        field(29; "NADDRESS2"; Text[50])
        {
            Caption = 'NADDRESS2';
        }
        field(30; "NPOSTCODE"; Text[20])
        {
            Caption = 'NPOSTCODE';
        }
        field(31; "NTELNO"; Text[30])
        {
            Caption = 'NTELNO';
        }
        field(32; "NCOUNTRY"; Text[10])
        {
            Caption = 'NCOUNTRY';
        }
        field(33; "NCITY"; Text[30])
        {
            Caption = 'NCITY';
        }
        field(34; "NSTATE"; Text[30])
        {
            Caption = 'NSTATE';
        }
        field(35; "NCONTACT"; Text[100])
        {
            Caption = 'NCONTACT';
        }
        field(36; "JUCH1"; Code[20])
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
