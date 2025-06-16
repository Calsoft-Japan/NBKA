page 50000 "Sales Header Approval API"
{
    PageType = API;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Quote));
    APIPublisher = 'CalsoftJapan';
    APIGroup = 'approval';
    APIVersion = 'v2.0';
    EntityName = 'salesHeaderApproval';
    EntitySetName = 'salesHeaderApprovals';
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field("SystemId"; Rec.SystemId)
            {
                Caption = 'System ID';
            }
            field("EstimatorRole"; Rec."Estimator Role")
            {
                Editable = true;
            }
            field("DiscountRateUpdated"; Rec."Discount Rate Updated") { }
            field("GrossProfitRateUpdated"; Rec."Gross Profit Rate Updated") { }
            field("GrossProfitRateBelow60"; Rec."Gross Profit Rate Below 60") { }
            field("No"; Rec."No.") // Sales Quote No.
            {
                Caption = 'Sales Quote No.';
            }
            field("ApprovalUser"; Rec."Approval User")
            {
                Caption = 'Approval User';
            }
        }
    }
}
