pageextension 50100 CompanyInfoPageExtension extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field("COC Signer Name"; Rec."COC Signer Name")
            {
                ApplicationArea = all;
            }
            field("COC Signer Title"; Rec."COC Signer Title")
            {
                ApplicationArea = all;
            }
            field("COC Signer Dept."; Rec."COC Signer Dept.")
            {
                ApplicationArea = all;
            }
            field("COC Signer Company"; Rec."COC Signer Company")
            {
                ApplicationArea = all;
            }
            field("COC Signer Signature"; Rec."COC Signer Signature")
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
        }
    }
}
