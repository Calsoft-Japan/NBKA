pageextension 50011 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addafter("Register Time")
        {
            field("User Role"; Rec."User Role")
            {
                ApplicationArea = All;
            }

        }

        //Add FactBox to show signature image
        addlast(factboxes)
        {
            part(SignatureFactBox; "User Signature Part")
            {
                ApplicationArea = All;
                SubPageLink = "User ID" = field("User ID");
                Caption = 'User Signature Picture';
            }
        }
    }
}
