//FDD308 page for the NBKAPI CHKITEM.
page 50024 "NBKAPI_CHKITEM"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_CHKITEM';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_CHKITEM';
    EntitySetName = 'NBKAPI_CHKITEM';
    EntityCaption = 'NBKAPI_CHKITEM';
    EntityName = 'NBKAPI_CHKITEM';
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_CHKITEM";
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
                field(PN; Rec."P/N")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RecItem: Record Item;
    begin
        Rec."Created datetime" := CurrentDateTime;
        if Rec."P/N".Trim() <> '' then begin
            RecItem.Reset();
            RecItem.SetRange("P/N", rec."P/N");
            if RecItem.FindFirst() then begin
                if RecItem.Blocked then begin
                    Rec.P_RTCD := '99';
                    Rec.P_ERRCD := 'NBKAPI_CHKITEM';
                    Rec.P_ERRMSG := 'Item is blocked.';
                end
                else if RecItem.Type <> RecItem.Type::Inventory then begin
                    Rec.P_RTCD := '99';
                    Rec.P_ERRCD := 'NBKAPI_CHKITEM';
                    Rec.P_ERRMSG := 'Item not found due to misbatched field.';
                end
                else begin
                    Rec.P_RTCD := '00';
                    Rec.P_ERRCD := '';
                    Rec.P_ERRMSG := '';
                end;
            end
            else begin
                Rec.P_RTCD := '99';
                Rec.P_ERRCD := 'NBKAPI_CHKITEM';
                Rec.P_ERRMSG := 'Item not found.';
            end;
        end else begin
            Rec.P_RTCD := '99';
            Rec.P_ERRCD := 'NBKAPI_CHKITEM';
            Rec.P_ERRMSG := 'Item not found.';
        end;
        if Rec.Insert(true) then begin
            exit(false);
        end
        else begin
            exit(false);
        end;
    end;
}
