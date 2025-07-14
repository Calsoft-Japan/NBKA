codeunit 50006 "Sales Quote Approval Events"
{
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeActionEvent', 'SendApprovalRequest', true, true)]
    local procedure ValidateBeforeApproval(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        ApprovalMgt: Codeunit "Sales Approval Mgt";
    begin
        //  Discount Calculation Check
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter("Special Product", '=false');
        SalesLine.SetFilter("Line Discount %", '<>0');

        if SalesLine.FindFirst() then
            Error('Discount Price Calculation is not completed.');

        //  Assign Approver Info
        ApprovalMgt.AssignApproverInfo(Rec);
    end;
}
