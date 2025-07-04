//FDD306 page for the NBKAPI SYKA.
page 50033 "NBKAPI_SYKA"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_SYKA';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_SYKA';
    EntitySetName = 'NBKAPI_SYKA';
    EntityCaption = 'NBKAPI_SYKA';
    EntityName = 'NBKAPI_SYKA';
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_SYKA";
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
                field(SYKABI; Rec.SYKABI)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(OKURNO; Rec.OKURNO)
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
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        Rec."Created datetime" := CurrentDateTime;
        if Rec.JUCH1.Trim() <> '' then begin
            SalesHeader.Reset();
            SalesHeader.SetRange("No.", Rec.JUCH1);
            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
            if SalesHeader.FindFirst() then begin
                SalesHeader.calcfields("Completely Shipped");
                if SalesHeader."Completely Shipped" then begin
                    SalesShipmentHeader.Reset();
                    SalesShipmentHeader.SetRange("Order No.", Rec.JUCH1);
                    SalesShipmentHeader.SETCURRENTKEY("Posting Date");
                    if SalesShipmentHeader.FindFirst() then begin
                        Rec.P_RTCD := '00';
                        Rec.P_ERRCD := '';
                        Rec.P_ERRMSG := '';
                        Rec.SYKABI := CustomFormatDate(SalesShipmentHeader."Posting Date");
                        Rec.OKURNO := SalesShipmentHeader."Package Tracking No.";
                    end;
                end
                else begin
                    Rec.P_RTCD := '99';
                    Rec.P_ERRCD := 'NBKAPI_SYKA';
                    Rec.P_ERRMSG := 'Sales Order has not been shipped.';
                    Rec.SYKABI := '';
                    Rec.OKURNO := '';
                end;
            end
            else begin
                Rec.P_RTCD := '99';
                Rec.P_ERRCD := 'NBKAPI_SYKA';
                Rec.P_ERRMSG := 'Sales Order does not exist.';
                Rec.SYKABI := '';
                Rec.OKURNO := '';
            end;
        end else begin
            Rec.P_RTCD := '99';
            Rec.P_ERRCD := 'NBKAPI_SYKA';
            Rec.P_ERRMSG := 'Sales Order does not exist.';
            Rec.SYKABI := '';
            Rec.OKURNO := '';
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
