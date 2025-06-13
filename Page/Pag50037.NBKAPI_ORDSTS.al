//FDD307 page for the NBKAPI ORDSTS.
page 50037 "NBKAPI_ORDSTS"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_ORDSTS';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_ORDSTS';
    EntitySetName = 'NBKAPI_ORDSTS';
    EntityCaption = 'NBKAPI_ORDSTS';
    EntityName = 'NBKAPI_ORDSTS';
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_ORDSTS";
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
        StatusOK: Boolean;
    begin
        Rec."Created datetime" := CurrentDateTime;
        if Rec.JUCH1.Trim() <> '' then begin
            RecSalesHeader.Reset();
            RecSalesHeader.SetRange("No.", Rec.JUCH1);
            RecSalesHeader.SetRange("Document Type", RecSalesHeader."Document Type"::Order);
            if RecSalesHeader.FindFirst() then begin
                RecSalesLine.Reset();
                RecSalesLine.SetRange("Document No.", Rec.JUCH1);
                RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                RecSalesLine.SetRange(Type, RecSalesLine.Type::Item);
                StatusOK := true;
                if RecSalesLine.IsEmpty() then begin
                    Rec.P_RTCD := '99';
                    Rec.P_ERRCD := 'NBKAPI_ORDSTS';
                    Rec.P_ERRMSG := 'The input Sales Order does not exist.';
                end
                else begin
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
                                if (not RecPurchaseHeader."EDI Order Completed") then begin
                                    Rec.P_RTCD := '99';
                                    Rec.P_ERRCD := 'NBKAPI_ORDSTS';
                                    Rec.P_ERRMSG := 'One or more Purchase Orders have not been completed yet.';
                                    StatusOK := false;
                                    break;
                                end;
                            end
                            else begin
                                Rec.P_RTCD := '99';
                                Rec.P_ERRCD := 'NBKAPI_ORDSTS';
                                Rec.P_ERRMSG := 'One or more Purchase Orders have not been completed yet.';
                                StatusOK := false;
                            end;
                        end
                        else begin
                            Rec.P_RTCD := '99';
                            Rec.P_ERRCD := 'NBKAPI_ORDSTS';
                            Rec.P_ERRMSG := 'One or more Purchase Orders have not been completed yet.';
                            StatusOK := false;
                        end;
                    until RecSalesLine.Next() = 0;
                end;
                if StatusOK then begin
                    Rec.P_RTCD := '00';
                    Rec.P_ERRCD := '';
                    Rec.P_ERRMSG := '';
                end;
            end
            else begin
                Rec.P_RTCD := '99';
                Rec.P_ERRCD := 'NBKAPI_ORDSTS';
                Rec.P_ERRMSG := 'The input Sales Order does not exist.';
            end;
        end else begin
            Rec.P_RTCD := '99';
            Rec.P_ERRCD := 'NBKAPI_ORDSTS';
            Rec.P_ERRMSG := 'The input Sales Order No. is invalid.';
        end;
        if Rec.Insert(true) then begin
            exit(false);
        end
        else begin
            exit(false);
        end;
    end;
}
