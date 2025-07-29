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
        }
        modify("Assigned User ID")
        {
            Editable = false;
        }

    }
}







