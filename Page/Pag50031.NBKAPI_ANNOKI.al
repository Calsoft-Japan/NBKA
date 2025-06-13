//FDD305 page for the NBKAPI ANNOKI.
page 50031 "NBKAPI_ANNOKI"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_ANNOKI';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_ANNOKI';
    EntitySetName = 'NBKAPI_ANNOKI';
    EntityCaption = 'NBKAPI_ANNOKI';
    EntityName = 'NBKAPI_ANNOKI';
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_ANNOKI";
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
                field(ANNOKI; Rec.ANNOKI)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Rec."Created datetime" := CurrentDateTime;
        if Rec.JUCH1.Trim() <> '' then begin
            SalesHeader.Reset();
            SalesHeader.SetRange("No.", Rec.JUCH1);
            if SalesHeader.FindFirst() then begin
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", Rec.JUCH1);
                if SalesLine.FindFirst() then begin
                    if SalesLine."Shipping Date" <> 0D then begin
                        Rec.P_RTCD := '00';
                        Rec.P_ERRCD := '';
                        Rec.P_ERRMSG := '';
                        Rec.ANNOKI := CustomFormatDate(SalesLine."Shipping Date");
                    end
                    else begin
                        Rec.P_RTCD := '99';
                        Rec.P_ERRCD := 'NBKAPI_ANNOKI';
                        Rec.P_ERRMSG := 'Shipping Date is blank on a sales line.';
                        Rec.ANNOKI := '';
                    end;
                end;
            end
            else begin
                Rec.P_RTCD := '99';
                Rec.P_ERRCD := 'NBKAPI_ANNOKI';
                Rec.P_ERRMSG := 'Sales Order does not exist.';
                Rec.ANNOKI := '';
            end;
        end else begin
            Rec.P_RTCD := '99';
            Rec.P_ERRCD := 'NBKAPI_ANNOKI';
            Rec.P_ERRMSG := 'Sales Order does not exist.';
            Rec.ANNOKI := '';
        end;
        if Rec.Insert(true) then begin
            exit(false);
        end
        else begin
            exit(false);
        end;
    end;

    local procedure CustomFormatDate(DateValue: Date): Text
    begin
        exit(Format(DateValue, 0, '<year4><month,2><day,2>'));
    end;
}
