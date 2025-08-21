tableextension 50003 "SalesHeader Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "EC Order"; Boolean)
        {
            Caption = 'EC Order';
            ToolTip = 'Indicate whether it was received from EC';
            DataClassification = ToBeClassified;
        }
        field(50001; "Special Order Work"; Boolean)
        {
            Caption = 'Special Order Work';
            ToolTip = 'If the customer requires Special Order Work';
            DataClassification = ToBeClassified;
        }
        field(50002; "Special Order Work Completed"; Boolean)
        {
            Caption = 'Special Order Work Completed';
            ToolTip = 'If Special Order Work is completed';
            DataClassification = ToBeClassified;
        }
        field(50003; "Special Shipping Work"; Boolean)
        {
            Caption = 'Special Shipping Work';
            ToolTip = 'If the customer requires Special Shipping Work';
            DataClassification = ToBeClassified;
        }
        field(50004; "Special Shipping Completed"; Boolean)
        {
            Caption = 'Special Shipping Completed';
            ToolTip = 'If Special Shipping Work is completed';
            DataClassification = ToBeClassified;
        }
        field(50005; "Estimator Role"; Code[50])
        {
            Caption = 'Estimator Role';
            ToolTip = 'Specifies the User Role of the Quote Author.';
            DataClassification = CustomerContent;
        }
        field(50007; "Discount Rate Updated"; Boolean)
        {
            Caption = 'Discount Rate Updated';
            ToolTip = 'Defines whether the Sales Quote contains an updated Discount Rate % from the default value.';
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" where("Document Type" = const(Quote), "Document No." = field("No."), "Discount Rate Updated" = const(true)));
        }
        field(50008; "Gross Profit Rate Updated"; Boolean)
        {
            Caption = 'Gross Profit Rate Updated';
            ToolTip = 'Defines whether the Sales Quote contains an updated Gross Profit Rate % from the default value.';
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" where("Document Type" = const(Quote), "Document No." = field("No."), "Gross Profit Rate Updated" = const(true)));
        }
        field(50009; "Gross Profit Rate below 60"; Boolean)
        {
            Caption = 'Gross Profit Rate < 60%';
            ToolTip = 'Defines whether the Sales Quote contains lines with less than 60% profit.';
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" where("Document Type" = const(Quote), "Document No." = field("No."), "Special Product" = const(true), "Gross Profit Rate %" = filter(.. 59.99999)));
        }
        field(50010; "Approval User"; Code[50])
        {
            Caption = 'Approval User';
            ToolTip = 'Specifies the User who approved the Sales Quote';
        }
        field(50011; "Shipping Date Confirmed"; Boolean)
        {
            Caption = 'Shipping Date Confirmed';
            Editable = false;
        }
        field(50012; "Invoice Email"; Text[300])
        {
            Caption = 'Invoice Email';
        }
    }

    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
    begin
        // Set the creator's User ID as the currently logged-in user
        "Assigned User ID" := UserId;

        // Autofill Estimator Role from User Setup
        if UserSetup.Get(UserId) then
            "Estimator Role" := Format(UserSetup."User Role");
    end;



}
