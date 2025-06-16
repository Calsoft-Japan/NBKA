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
        }

        modify("Assigned User ID")
        {
            Editable = false;
        }
    }
}







