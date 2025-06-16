codeunit 50005 "Copy Sales Custom Fields"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesDocument', '', false, false)]
    local procedure CopySalesCustomFields(
        FromDocumentType: Option;
        FromDocumentNo: Code[20];
        var ToSalesHeader: Record "Sales Header";
        FromDocOccurenceNo: Integer;
        FromDocVersionNo: Integer;
        IncludeHeader: Boolean;
        RecalculateLines: Boolean;
        MoveNegLines: Boolean)
    var
        Customer: Record Customer;
        FromSalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        FromDocType: Enum "Sales Document Type From";
    begin
        // Ensure we're working with a Sales Order
        if ToSalesHeader."Document Type" <> ToSalesHeader."Document Type"::Order then
            exit;

        // Convert Option to Enum
        FromDocType := Enum::"Sales Document Type From".FromInteger(FromDocumentType);

        // Copy from source Sales Header (e.g., Sales Quote)
        case FromDocType of
            FromDocType::Quote,
            FromDocType::Order:
                begin
                    if FromSalesHeader.Get(FromDocType.AsInteger(), FromDocumentNo) then begin
                        ToSalesHeader."Estimator Role" := FromSalesHeader."Estimator Role";
                        ToSalesHeader."Approval User" := FromSalesHeader."Approval User";
                    end;
                end;
        end;

        // Copy from Customer Card → Sales Line
        if Customer.Get(ToSalesHeader."Sell-to Customer No.") then begin
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", ToSalesHeader."Document Type");
            SalesLine.SetRange("Document No.", ToSalesHeader."No.");

            if SalesLine.FindSet() then
                repeat
                    SalesLine."Certificate of Conformance" := Customer."Certificate of Conformance";
                    SalesLine.Modify();
                until SalesLine.Next() = 0;
        end;
    end;
}
