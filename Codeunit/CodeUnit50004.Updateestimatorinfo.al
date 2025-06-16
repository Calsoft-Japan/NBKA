// codeunit 50004 "Update Estimator Info"
// {
//     [ServiceEnabled]
//     procedure Update(SalesQuoteNo: Code[20]; RequestUserId: Code[50])
//     var
//         SalesHeader: Record "Sales Header";
//         UserSetup: Record "User Setup";
//     begin
//         if SalesHeader.Get(SalesHeader."Document Type"::Quote, SalesQuoteNo) then begin
//             SalesHeader.Validate("Assigned User ID", RequestUserId);
//             if UserSetup.Get(RequestUserId) then
//                 SalesHeader.Validate("Estimator Role", Format(UserSetup."User Role"));
//             SalesHeader.Modify(true);
//         end;
//     end;
// }
