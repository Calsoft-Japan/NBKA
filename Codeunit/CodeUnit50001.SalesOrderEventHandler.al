codeunit 50001 "Sales Order Event Handler"
{
    //Subtype = EventSubscriber;

    // 1. Copy Special Order Work & Special Shipping Work when Customer No. is updated
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    procedure OnAfterValidateCustomerNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        CustomerRec: Record Customer;
    begin
        if Rec."Sell-to Customer No." <> '' then begin

            if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                Rec.Validate("Special Order Work", CustomerRec."Special Order Work");
                Rec.Validate("Special Shipping Work", CustomerRec."Special Shipping Work");
            end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforePerformManualReleaseProcedure', '', false, false)]
    local procedure SalesHeader_OnBeforePerformManualReleaseProcedure(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin

            // 🔸 1. Special Order Work Validation
            if (SalesHeader."Special Order Work") and (not SalesHeader."Special Order Work Completed") then
                Error('Special Order Work is not completed.');

            // 🔸 2. Discount Price Validation (independent of Special Order)
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            if SalesLine.FindSet() then
                repeat
                    if (not SalesLine."Special Product") and (SalesLine."Line Discount %" <> 0) then
                        Error('Discount Price Calculation is not completed.');
                until SalesLine.Next() = 0;
        end;
    end;


    // 3. Set Shipping Advice to Complete when specific Sales Line condition is met

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterManualReleaseSalesDoc', '', false, false)]
    local procedure OnAfterManualReleaseSalesDocSubscriber(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        // Ensure we only check for released documents
        if SalesHeader.Status = SalesHeader.Status::Released then begin
            // Filter all lines for this Sales Header
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");

            if SalesLine.FindSet() then begin
                repeat
                    if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."No." = 'JB-FREIGHT') then begin
                        SalesHeader."Shipping Advice" := SalesHeader."Shipping Advice"::Complete;
                        SalesHeader.Modify();
                        break;
                    end;
                until SalesLine.Next() = 0;
            end;
        end;
    end;

    //4. Limit "Copy Document" Lookup to Only Released Quotes
    // [EventSubscriber(ObjectType::Report, Report::"Copy Sales Document", 'OnBeforeLookupSalesDoc', '', false, false)]
    // local procedure FilterSalesQuoteListOnCopySalesDoc(var SalesHeader: Record "Sales Header")
    // begin
    //     if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then begin
    //         Message('Triggered OnBeforeLookupSalesDoc. Filtering Released quotes.');
    //         SalesHeader.SetRange(Status, SalesHeader.Status::Released);
    //     end;

    // end;
}
