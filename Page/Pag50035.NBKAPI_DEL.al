//FDD304 page for the NBKAPI DEL.
page 50035 "NBKAPI_DEL"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_DEL';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_DEL';
    EntitySetName = 'NBKAPI_DEL';
    EntityCaption = 'NBKAPI_DEL';
    EntityName = 'NBKAPI_DEL';
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_DEL";
    UsageCategory = Administration;
    Extensible = false;
    DelayedInsert = true;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EntryNo; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Createddatetime; Rec."Created datetime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(P_RTCD; Rec.P_RTCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(P_ERRCD; Rec.P_ERRCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(P_ERRMSG; Rec.P_ERRMSG)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(JUCH1; Rec.JUCH1)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RecSalesHeader: Record "Sales Header";
        RecSalesLine: Record "Sales Line";
        RecPurchaseHeader: Record "Purchase Header";
        PONo: Code[20];
        CanDelete: Boolean;
    begin
        if Rec.JUCH1.Trim() <> '' then begin
            Rec."Created datetime" := CurrentDateTime;
            RecSalesHeader.Reset();
            RecSalesHeader.SetRange("No.", Rec.JUCH1);
            RecSalesHeader.SetRange("Document Type", RecSalesHeader."Document Type"::Order);
            if RecSalesHeader.FindFirst() then begin
                RecSalesLine.Reset();
                RecSalesLine.SetRange("Document No.", Rec.JUCH1);
                RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                RecSalesLine.SetRange(Type, RecSalesLine.Type::Item);
                CanDelete := true;
                if not RecSalesLine.IsEmpty() then begin
                    RecSalesLine.FindSet();
                    repeat
                        PONo := '';
                        if RecSalesLine."Drop Shipment" then begin
                            PONo := RecSalesLine."Purchase Order No."
                        end
                        else begin
                            PONo := RecSalesLine."Special Order Purchase No.";
                        end;
                        if PONo <> '' then begin
                            RecPurchaseHeader.Reset();
                            RecPurchaseHeader.SetRange("No.", PONo);
                            RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
                            if RecPurchaseHeader.FindFirst() then begin
                                Rec.P_RTCD := '99';
                                Rec.P_ERRCD := 'NBKAPI_DEL';
                                Rec.P_ERRMSG := 'Sales Order cannot be deleted because it is associated with Purchase Order.';
                                CanDelete := false;
                                break;
                            end;
                        end;
                    until RecSalesLine.Next() = 0;
                end;
                if CanDelete then begin
                    RecSalesLine.Reset();
                    RecSalesLine.SetRange("Document No.", Rec.JUCH1);
                    RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                    if not RecSalesLine.IsEmpty() then begin
                        RecSalesLine.FindSet();
                        repeat
                            if RecSalesLine."Quantity Shipped" > 0 then begin
                                Rec.P_RTCD := '99';
                                Rec.P_ERRCD := 'NBKAPI_DEL';
                                Rec.P_ERRMSG := 'Sales Order cannot be deleted because shipment has been posted.';
                                CanDelete := false;
                            end;
                        until RecSalesLine.Next() = 0;
                    end;
                    if CanDelete then begin
                        RecSalesLine.DeleteAll();
                        if RecSalesHeader.Delete() then begin
                            Rec.P_RTCD := '00';
                            Rec.P_ERRCD := '';
                            Rec.P_ERRMSG := '';
                        end
                        else begin
                            Rec.P_RTCD := '99';
                            Rec.P_ERRCD := 'NBKAPI_DEL';
                            Rec.P_ERRMSG := 'Sales Order cannot be deleted, the detailed error message is: ' + GetLastErrorText();
                        end;
                    end;
                end;
            end
            else begin
                Rec.P_RTCD := '00';
                Rec.P_ERRCD := '';
                Rec.P_ERRMSG := '';
            end;
        end else begin
            Rec."Created datetime" := 0DT;
            exit(false);
        end;
        exit(true);
        if Rec.Insert(true) then begin
            exit(false);
        end
        else begin
            exit(false);
        end;
    end;
}
