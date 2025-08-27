//FDD303 page for the NBKAPI INS.
page 50039 "NBKAPI_INS_LINE"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_INS_LINE';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_INS_LINE';
    EntitySetName = 'salesLine';
    EntityCaption = 'NBKAPI_INS_LINE';
    EntityName = 'NBKAPI_INS_LINE';
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_INS_LINE";
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
                field(HeaderEntryNo; Rec."Header Entry No.")
                {
                    Visible = false;
                }
                field(CART2; Rec.CART2)
                {
                    ApplicationArea = All;
                }
                field(JUCH2; Rec.JUCH2)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(SEHNCD; Rec.SEHNCD)
                {
                    ApplicationArea = All;
                }
                field(QTY; Rec.QTY)
                {
                    ApplicationArea = All;
                }
                field(UNITPRICE; Rec.UNITPRICE)
                {
                    ApplicationArea = All;
                }
                field(REQUESTDATE; Rec.REQUESTDATE)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RecNBKAPITBL_INS: Record NBKAPITBL_INS;
        RecNBKAPITBL_INS_LINE: Record NBKAPITBL_INS_LINE;
        RecItem: Record Item;
        HasError: Boolean;
        ErrMsg: Text;
        LineNo: Integer;
    begin
        HasError := false;
        ErrMsg := '';
        Rec."Created datetime" := CurrentDateTime;
        RecNBKAPITBL_INS_LINE.Reset();
        RecNBKAPITBL_INS_LINE.SetRange("Header Entry No.", Rec."Header Entry No.");
        if RecNBKAPITBL_INS_LINE.FindLast() then begin
            LineNo := RecNBKAPITBL_INS_LINE.JUCH2;
        end
        else begin
            LineNo := 0;
        end;
        LineNo += 10000;
        Rec.JUCH2 := LineNo;
        if Rec.SEHNCD = '' then begin
            HasError := true;
            ErrMsg += 'SEHNCD must not be blank.';
        end;
        if Rec.QTY = 0 then begin
            HasError := true;
            ErrMsg += 'QTY must not be blank.';
        end;
        if Rec.UNITPRICE = 0 then begin
            HasError := true;
            ErrMsg += 'UNITPRICE must not be blank.';
        end;
        RecItem.Reset();
        RecItem.SetRange("P/N", Rec.SEHNCD);
        if RecItem.IsEmpty() then begin
            HasError := true;
            ErrMsg += 'Item with this P/N [' + Rec.SEHNCD + '] does not exist.';
        end;
        if HasError then begin
            Rec.P_RTCD := '99';
            Rec.P_ERRCD := 'NBKAPI_INS';
            Rec.P_ERRMSG := ErrMsg;
            if RecNBKAPITBL_INS.Get(Rec."Header Entry No.") then begin
                RecNBKAPITBL_INS.P_RTCD := '99';
                RecNBKAPITBL_INS.P_ERRCD := 'NBKAPI_INS';
                if RecNBKAPITBL_INS.P_ERRMSG = '' then begin
                    RecNBKAPITBL_INS.P_ERRMSG := 'Error Message for INS LINE ' + Rec.CART2 + ': ' + ErrMsg;
                end;
                RecNBKAPITBL_INS.Modify();
            end;
        end
        else begin
            Rec.P_RTCD := '00';
            Rec.P_ERRCD := '';
            Rec.P_ERRMSG := '';
        end;
        if Rec.Insert(true) then begin
            exit(false);
        end
        else begin
            exit(false);
        end;
    end;
}
