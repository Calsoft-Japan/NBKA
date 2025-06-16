codeunit 50002 "Sales Approval Mgt"
{
    procedure AssignApproverInfo(var SalesHeader: Record "Sales Header")
    var
        UserSetup: Record "User Setup";
    begin
        if not SalesHeader.FindFirst() then
            exit;

        SalesHeader.Validate("Assigned User ID", UserId);

        if UserSetup.Get(UserId) then
            SalesHeader.Validate("Estimator Role", Format(UserSetup."User Role"))
        else
            Error('User Role not found for user %1 in User Setup.', UserId);

        SalesHeader.Modify(true);
    end;
}
