pageextension 50003 "SalesOrderExt" extends "Sales Order"
{
    layout
    {
        addbefore("Work Description")
        {
            field("EC Order"; Rec."EC Order")
            {
                ApplicationArea = All;
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
            field("Invoice Email"; Rec."Invoice Email")
            {
                ApplicationArea = all;
            }
        }

        modify("Assigned User ID")
        {
            Editable = false;
        }
    }
    local procedure SetAllShipDatesFlag()
    var
        SalesLine: Record "Sales Line";
        AllFilled: Boolean;
    begin
        AllFilled := true;

        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
                if SalesLine."Shipping Date" = 0D then begin
                    AllFilled := false;
                end;
            until (SalesLine.Next() = 0) or (not AllFilled);

        Rec.Validate("Shipping Date Confirmed", AllFilled);
        Rec.Modify();
        CurrPage.Update();
    end;

    trigger OnAfterGetRecord()
    begin
        SetAllShipDatesFlag();
    end;
}







