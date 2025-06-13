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

    //2.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforePerformManualReleaseProcedure, '', false, false)]
    local procedure SalesHeader_OnBeforePerformManualReleaseProcedure(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        if (SalesHeader."Special Order Work") and (not SalesHeader."Special Order Work Completed") then begin
            Error('Special Order Work is not completed.');
            IsHandled := true;

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



    // 4. Copy Certificate of Conformance from Customer to Sales Line
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    procedure OnSalesLineCreated(var Rec: Record "Sales Line")
    var
        CustomerRec: Record Customer;
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(Rec."Type", Rec."No.") then begin

            if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then begin
                Rec.Validate("Certificate of Conformance", CustomerRec."Certificate of Conformance");
                Rec.Modify();
            end;

        end;
    end;


}
