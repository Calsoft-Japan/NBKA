page 50001 "User Setup API"
{
    PageType = API;
    SourceTable = "User Setup";
    //SourceTableView = where("Document Type" = const(Order));
    APIPublisher = 'CalsoftJapan';//
    APIGroup = 'setup';
    APIVersion = 'v2.0';
    EntityName = 'userSetupAPI';
    EntitySetName = 'userSetupAPI';
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field("UserID"; Rec."User ID") { }
            field("UserRole"; Rec."User Role") { }
            field("Email"; Rec."E-Mail") { }
        }

    }
}