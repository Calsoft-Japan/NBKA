tableextension 50101 CompanyInfoExtension extends "Company Information"
{
    fields
    {
        field(50100; "COC Signer Name"; Text[30])
        {
            Caption = 'COC Signer Name';
            DataClassification = ToBeClassified;
        }
        field(50101; "COC Signer Title"; Text[50])
        {
            Caption = 'COC Signer Title';
            DataClassification = ToBeClassified;
        }
        field(50102; "COC Signer Dept."; Text[50])
        {
            Caption = 'COC Signer Dept.';
            DataClassification = ToBeClassified;
        }
        field(50103; "COC Signer Company"; Text[50])
        {
            Caption = 'COC Signer Company';
            DataClassification = ToBeClassified;
        }
        field(50104; "COC Signer Signature"; Blob)
        {
            Caption = 'COC Signer Signature';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50105; "NBK Check Address"; Text[50])
        {
            Caption = 'NBK Check Address';
        }
        field(50106; "NBK Check City"; Text[30])
        {
            Caption = 'NBK Check City';
            TableRelation = if ("NBK Check State" = const('')) "Post Code".City
            else
            if ("NBK Check State" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("NBK Check Country"));
            ValidateTableRelation = false;
        }
        field(50107; "NBK Check State"; Text[30])
        {
            Caption = 'NBK Check State';
        }
        field(50108; "NBK Check Zip Code"; Code[20])
        {
            Caption = 'NBK Check Zip Code';
            TableRelation = if ("NBK Check Country" = const('')) "Post Code".Code
            else
            if ("NBK Check Country" = filter(<> '')) "Post Code".Code where("Country/Region Code" = field("NBK Check Country"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                NbKPostCode.LookupPostCode("NBK Check City", "NBK Check Zip Code", "NBK Check State", "NBK Check Country");
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                if not IsHandled then
                    NbKPostCode.ValidatePostCode("NBK Check City", "NBK Check Zip Code", "NBK Check State", "NBK Check Country", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50109; "NBK Check Country"; Code[10])
        {
            Caption = 'NBK Check Country';
            TableRelation = "Country/Region";

        }
    }
    var
        NbKPostCode: Record "Post Code";
}
