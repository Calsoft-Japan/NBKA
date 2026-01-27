namespace NBKA.NBKA;

using Microsoft.Sales.Document;
using System.Security.AccessControl;

pageextension 50015 SalesquoteExt extends "Sales Quote"
{
    layout
    {
        modify("Shipping Agent Code")
        {
            Editable = false;
        }
        modify("Shipping Agent Service Code")
        {
            Editable = false;
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }
        modify("Payment Method Code")
        {
            Editable = false;
        }
        modify("Sell-to Customer No.")
        {
            ShowMandatory = true;
        }
        modify("Sell-to Customer Name")
        {
            ShowMandatory = true;
        }
        modify("Sell-to Contact No.")
        {
            ShowMandatory = true;
        }
        modify("Sell-to Contact")
        {
            ShowMandatory = true;
        }
        modify("Quote Valid Until Date")
        {
            ShowMandatory = true;
        }
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
