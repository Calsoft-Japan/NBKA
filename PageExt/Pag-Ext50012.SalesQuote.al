pageextension 50012 "Sales Quote Ext" extends "Sales Quote"
{
    layout
    {
        addbefore("Work Description")
        {
            field("Estimator Role"; Rec."Estimator Role")
            {
                ApplicationArea = All;
                Editable = true;//
            }
            field("Discount Rate Updated"; Rec."Discount Rate Updated")
            {
                ApplicationArea = All;
                Editable = false;
                DrillDown = false;
            }
            field("Gross Profit Rate Updated"; Rec."Gross Profit Rate Updated")
            {
                ApplicationArea = All;
                Editable = false;
                DrillDown = false;
            }
            field("Gross Profit Rate < 60%"; Rec."Gross Profit Rate Below 60")
            {
                ApplicationArea = All;
                Editable = false;
                DrillDown = false;
            }
            field("Approval User"; Rec."Approval User")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Assigned User ID")
        {
            Editable = true;// Change is needed after testing.
        }

    }

    actions
    {
        addlast(Processing)
        {
            action(RequestApproval)
            {
                ApplicationArea = All;
                Caption = 'Request Approval';
                Image = Approve;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    ApprovalMgt: Codeunit "Sales Approval Mgt";
                begin
                    // Validate Discount Price Logic
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");

                    if SalesLine.FindSet() then
                        repeat
                            if not SalesLine."Special Product" and (SalesLine."Line Discount %" <> 0) then
                                Error('Discount Price Calculation is not completed.');
                        until SalesLine.Next() = 0;

                    // Delegate assignment logic to codeunit
                    ApprovalMgt.AssignApproverInfo(Rec);

                    CurrPage.Update(false);
                    Message('Approval request initiated by %1.', UserId);
                end;
            }
        }
    }
}







