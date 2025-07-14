page 50003 "Update Estimator API"
{
    PageType = API;
    SourceTable = "Sales Header";
    APIPublisher = 'CalsoftJapan';
    APIGroup = 'update';
    APIVersion = 'v1.0';
    EntityName = 'updateEstimator';
    EntitySetName = 'updateEstimators';
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(No; Rec."No.") { }
            field(AssignedUserID; Rec."Assigned User ID") { Editable = true; }
            field(EstimatorRole; Rec."Estimator Role") { Editable = true; }
        }
    }
}
