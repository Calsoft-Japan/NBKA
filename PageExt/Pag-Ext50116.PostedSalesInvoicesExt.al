namespace NBKA.NBKA;

using Microsoft.Sales.History;
using System.Security.AccessControl;

pageextension 50116 PostedSalesInvoicesExt extends "Posted Sales Invoices"
{
    layout
    {
        addlast(Control1)
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
