pageextension 50012 "Sales Quote Ext" extends "Sales Quote"
{
    layout
    {
        addbefore("Work Description")
        {
            field("Estimator Role"; Rec."Estimator Role")
            {
                ApplicationArea = All;
                Editable = false;
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
            field("Special Quote work"; Rec."Special Quote work")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Special Quote work Completed"; Rec."Special Quote work Completed")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        modify("Assigned User ID")
        {
            Editable = false;
        }


    }
    actions
    {
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                if rec."Special Quote work" and not rec."Special Quote work Completed" then
                    Error('Special Quote work is required, but it is not completed.');
            end;
        }
    }
}







