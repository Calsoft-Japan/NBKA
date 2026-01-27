pageextension 50003 "SalesOrderExt" extends "Sales Order"
{
    layout
    {
        addbefore("Work Description")
        {
            field("EC Order"; Rec."EC Order")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Special Order Work"; Rec."Special Order Work")
            {
                ApplicationArea = All;
            }
            field("Special Order Work Completed"; Rec."Special Order Work Completed")
            {
                ApplicationArea = All;
            }
            field("Special Shipping Work"; Rec."Special Shipping Work")
            {
                ApplicationArea = All;
            }
            field("Special Shipping Work Completed"; Rec."Special Shipping Completed")
            {
                ApplicationArea = All;
            }
            field("Shipping Date Confirmed"; Rec."Shipping Date Confirmed")
            {
                ApplicationArea = All;
            }
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

        modify("Assigned User ID")
        {
            Editable = false;
        }
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
        modify("Sell-to E-Mail")
        {
            ShowMandatory = true;
        }
        modify(ShippingOptions)
        {
            ShowMandatory = true;
        }
        modify(BillToOptions)
        {
            ShowMandatory = true;
        }
        modify("Shipping Advice")
        {
            ShowMandatory = true;
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







