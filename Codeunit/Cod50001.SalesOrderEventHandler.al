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

            //2. Special Order Work Validation
            if (SalesHeader."Special Order Work") and (not SalesHeader."Special Order Work Completed") then
                Error('Special Order Work is not completed.');

            //3. Contact Information Validation (FDD005/CR)
            if IsBlank(SalesHeader."Sell-to Contact No.") or IsBlank(SalesHeader."Sell-to Contact") then
                Error('The ''Contact No. and Contact'' fields in Sell-to are required.');

            // Discount Price Validation (independent of Special Order)
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            if SalesLine.FindSet() then
                repeat
                    if (not SalesLine."Special Product") and (SalesLine."Line Discount %" <> 0) then
                        Error('Discount Price Calculation is not completed.');
                until SalesLine.Next() = 0;
        end;
    end;

    // Helper function to check if a Text value is blank
    local procedure IsBlank(Value: Text): Boolean
    begin
        exit(DelChr(Value, '=', ' ') = '');
    end;


    // 4. Set Shipping Advice to Complete when specific Sales Line condition is met

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
                    if (SalesLine.Type = SalesLine.Type::Resource) then begin
                        SalesHeader."Shipping Advice" := SalesHeader."Shipping Advice"::Complete;
                        SalesHeader.Modify();
                        break;
                    end;
                until SalesLine.Next() = 0;
            end;
        end;
    end;

    // FDD-004: Updates 'Discount Rate Updated' flag when 'Discount Rate' differs from 'Original Discount %' 
    // and 'Special Product' is FALSE. Applies on Sales Line modify.
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeModifyEvent', '', false, false)]
    local procedure SalesLineOnBeforeModify(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        if not Rec."Special Product" then begin
            if Rec."Original Discount %" <> Rec."Discount Rate" then begin
                // Update line flag
                Rec."Discount Rate Updated" := true;

                // Update header only if not already true (to reduce Modify() calls)
                if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                    if not SalesHeader."Discount Rate Updated" then begin
                        SalesHeader."Discount Rate Updated" := true;
                        SalesHeader.Modify(true);
                    end;
                end;
            end else begin
                // Reset line flag when rates match
                Rec."Discount Rate Updated" := false;
            end;
        end;
    end;

}
