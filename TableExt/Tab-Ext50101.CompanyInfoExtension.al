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
    }
}
