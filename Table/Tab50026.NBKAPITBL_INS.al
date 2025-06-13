//FDD303 NBK API table Create Order.
table 50026 "NBKAPITBL_INS"
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
        field(6; "CART1"; Text[35])
        {
            Caption = 'CART1';
        }
        field(7; "CART2"; Text[35])
        {
            Caption = 'CART2';
        }
        field(8; "TOKUCD"; Code[20])
        {
            Caption = 'TOKUCD';
        }
        field(9; "NONYCD"; Code[10])
        {
            Caption = 'NONYCD';
        }
        field(10; "TKHAC"; Code[35])
        {
            Caption = 'TKHAC';
        }
        field(11; "SEHNCD"; Code[50])
        {
            Caption = 'SEHNCD';
        }
        field(12; "QTY"; Decimal)
        {
            Caption = 'QTY';
        }
        field(13; "UNITPRICE"; Decimal)
        {
            Caption = 'UNITPRICE';
        }
        field(14; "FREIGHT"; Decimal)
        {
            Caption = 'FREIGHT';
        }
        field(15; "AMOUNT"; Decimal)
        {
            Caption = 'AMOUNT';
        }
        field(16; "REQUESTDATE"; Date)
        {
            Caption = 'REQUESTDATE';
        }
        field(17; "SHIPAGENT"; Code[10])
        {
            Caption = 'SHIPAGENT';
        }
        field(18; "PAYMENT"; Code[10])
        {
            Caption = 'PAYMENT';
        }
        field(19; "ORDERDATE"; Date)
        {
            Caption = 'ORDERDATE';
        }
        field(20; "TNAME"; Text[100])
        {
            Caption = 'TNAME';
        }
        field(21; "TPOSTCODE"; Text[20])
        {
            Caption = 'TPOSTCODE';
        }
        field(22; "TADDRESS"; Text[100])
        {
            Caption = 'TADDRESS';
        }
        field(23; "TADDRESS2"; Text[50])
        {
            Caption = 'TADDRESS2';
        }
        field(24; "TTELNO"; Text[30])
        {
            Caption = 'TTELNO';
        }
        field(25; "TCOUNTRY"; Text[10])
        {
            Caption = 'TCOUNTRY';
        }
        field(26; "TCITY"; Text[30])
        {
            Caption = 'TCITY';
        }
        field(27; "TSTATE"; Text[30])
        {
            Caption = 'TSTATE';
        }
        field(28; "TCONTACT"; Text[100])
        {
            Caption = 'TCONTACT';
        }
        field(29; "UPSACCOUNT"; Text[80])
        {
            Caption = 'UPSACCOUNT';
        }
        field(30; "FDXACCOUNT"; Text[80])
        {
            Caption = 'FDXACCOUNT';
        }
        field(31; "RESELLER"; Text[50])
        {
            Caption = 'RESELLER';
        }
        field(32; "NNAME"; Text[100])
        {
            Caption = 'NNAME';
        }
        field(33; "NADDRESS"; Text[100])
        {
            Caption = 'NADDRESS';
        }
        field(34; "NADDRESS2"; Text[50])
        {
            Caption = 'NADDRESS2';
        }
        field(35; "NPOSTCODE"; Text[20])
        {
            Caption = 'NPOSTCODE';
        }
        field(36; "NTELNO"; Text[30])
        {
            Caption = 'NTELNO';
        }
        field(37; "NCOUNTRY"; Text[10])
        {
            Caption = 'NCOUNTRY';
        }
        field(38; "NCITY"; Text[30])
        {
            Caption = 'NCITY';
        }
        field(39; "NSTATE"; Text[30])
        {
            Caption = 'NSTATE';
        }
        field(40; "NCONTACT"; Text[100])
        {
            Caption = 'NCONTACT';
        }
        field(41; "JUCH1"; Code[20])
        {
            Caption = 'JUCH1';
        }
        field(42; "JUCH2"; Integer)
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
