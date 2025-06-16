tableextension 50005 "User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50000; "User Role"; Option)
        {
            ToolTip = 'Specifies the User Role for each User from the list.';
            OptionMembers = NBKam_Trainee,NBKam,NBKjp,NBKam_Approver,NBKjp_Approver,Approver2;
        }
        field(50001; "User Signature"; MediaSet)
        {
            Caption = 'User Signature';
            ToolTip = ' Specifies the signature image to be used for reports.';
        }
    }

}