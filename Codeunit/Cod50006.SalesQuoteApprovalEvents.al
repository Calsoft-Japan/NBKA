codeunit 50006 "Sales Quote Approval Events"
{
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeActionEvent', 'SendApprovalRequest', true, true)]
    local procedure ValidateBeforeApproval(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        //  Discount Calculation Check
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter("Special Product", '=false');
        SalesLine.SetFilter("Line Discount %", '<>0');

        if SalesLine.FindFirst() then
            Error('Discount Price Calculation is not completed.');

        //  Zero Quantity Check
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter(Type, '%1|%2', SalesLine.Type::Item, SalesLine.Type::Resource);
        SalesLine.SetFilter(Quantity, '=0');

        if SalesLine.FindFirst() then
            Error('Quantity must not be zero in Sales Lines.');
    end;
}
