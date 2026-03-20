namespace NBKA.NBKA;

using Microsoft.Sales.History;
using System.Security.AccessControl;

pageextension 50115 PostedSalesCreditMemoExt extends "Posted Sales Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field(SystemCreatedBy; GetUserName(Rec.SystemCreatedBy))
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field(SystemModifiedBy; GetUserName(Rec.SystemModifiedBy))
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
        }
    }
    local procedure GetUserName(UserSecurityId: Guid): Text
    var
        User: Record User;
    begin
        if User.Get(UserSecurityId) then
            exit(User."User Name")
        else
            exit('');
    end;
}
