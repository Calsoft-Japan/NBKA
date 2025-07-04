codeunit 50006 "Sales Quote Approval Events"
{
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeActionEvent', 'SendApprovalRequest', true, true)]
    local procedure ValidateBeforeApproval(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        ApprovalMgt: Codeunit "Sales Approval Mgt";
    begin
        //  1. Discount Calculation Check
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter("Special Product", '=false');
        SalesLine.SetFilter("Line Discount %", '<>0');

        if SalesLine.FindFirst() then
            Error('Discount Price Calculation is not completed.');

        //  2. GP < 60 + Discount Rate check
        if Rec."Discount Rate Updated" and Rec."Gross Profit Rate Below 60" then
            Error('Cannot send approval: Discount too high or GP too low.');

        //  3. Assign Approver Info
        ApprovalMgt.AssignApproverInfo(Rec);
    end;
}
