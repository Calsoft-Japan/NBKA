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
        field(9; "TKHAC"; Code[35])
        {
            Caption = 'TKHAC';
        }
        field(10; "FREIGHT"; Decimal)
        {
            Caption = 'FREIGHT';
        }
        field(11; "AMOUNT"; Decimal)
        {
            Caption = 'AMOUNT';
        }
        field(12; "SHIPAGENT"; Code[10])
        {
            Caption = 'SHIPAGENT';
        }

        //CR: FDD303/add new field
        field(13; "SHIPSERVICE"; Text[10])
        {
            Caption = 'SHIPSERVICE';
        }
        //End CR: FDD303/add new field

        field(14; "PAYMENT"; Code[10])
        {
            Caption = 'PAYMENT';
        }
        field(15; "ORDERDATE"; Date)
        {
            Caption = 'ORDERDATE';
        }
        field(16; "TNAME"; Text[100])
        {
            Caption = 'TNAME';
        }
        field(17; "TPOSTCODE"; Text[20])
        {
            Caption = 'TPOSTCODE';
        }
        field(18; "TADDRESS"; Text[100])
        {
            Caption = 'TADDRESS';
        }
        field(19; "TADDRESS2"; Text[50])
        {
            Caption = 'TADDRESS2';
        }
        field(20; "TTELNO"; Text[30])
        {
            Caption = 'TTELNO';
        }
        field(21; "TCOUNTRY"; Text[10])
        {
            Caption = 'TCOUNTRY';
        }
        field(22; "TCITY"; Text[30])
        {
            Caption = 'TCITY';
        }
        field(23; "TSTATE"; Text[30])
        {
            Caption = 'TSTATE';
        }
        field(24; "TCONTACT"; Text[100])
        {
            Caption = 'TCONTACT';
        }
        field(25; "UPSACCOUNT"; Text[80])
        {
            Caption = 'UPSACCOUNT';
        }
        field(26; "FDXACCOUNT"; Text[80])
        {
            Caption = 'FDXACCOUNT';
        }
        field(27; "RESELLER"; Text[50])
        {
            Caption = 'RESELLER';
        }
        field(28; "NNAME"; Text[100])
        {
            Caption = 'NNAME';
        }
        field(29; "NADDRESS"; Text[100])
        {
            Caption = 'NADDRESS';
        }
        field(30; "NADDRESS2"; Text[50])
        {
            Caption = 'NADDRESS2';
        }
        field(31; "NPOSTCODE"; Text[20])
        {
            Caption = 'NPOSTCODE';
        }
        field(32; "NTELNO"; Text[30])
        {
            Caption = 'NTELNO';
        }
        field(33; "NCOUNTRY"; Text[10])
        {
            Caption = 'NCOUNTRY';
        }
        field(34; "NCITY"; Text[30])
        {
            Caption = 'NCITY';
        }
        field(35; "NSTATE"; Text[30])
        {
            Caption = 'NSTATE';
        }
        field(36; "NCONTACT"; Text[100])
        {
            Caption = 'NCONTACT';
        }
        field(37; "JUCH1"; Code[20])
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
