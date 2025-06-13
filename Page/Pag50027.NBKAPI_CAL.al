//FDD301 page for the NBKAPI INSTOKUCD.
page 50027 "NBKAPI_CAL"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_CAL';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_CAL';
    EntitySetName = 'NBKAPI_CAL';
    EntityCaption = 'NBKAPI_CAL';
    EntityName = 'NBKAPI_CAL';
    ODataKeyFields = "P_RTCD", "P_ERRCD", "P_ERRMSG", "YYMMDD";
    SourceTable = "NBKAPITBL_CAL";
    SourceTableTemporary = true;
    UsageCategory = Administration;
    //Extensible = false;
    DelayedInsert = true;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                field(YYMMDD; Rec."YYMMDD")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(HANTEIS; Rec.HANTEIS)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(HANTEIK; Rec.HANTEIK)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(YOBIKB; Rec.YOBIKB)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(YOUBI; Rec.YOUBI)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(FROMTIME; Rec.FROMTIME)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TOTIME; Rec.TOTIME)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        RecDate: Record Date;
        FromDate: Date;
        EndDate: Date;
    begin
        FromDate := DMY2Date(1, Today.Month, Today.Year);
        EndDate := CalcDate('<CM>', CalcDate('<5M>', FromDate));
        RecDate.Reset();
        RecDate.SetRange("Period Start", FromDate, EndDate);
        RecDate.SetRange("Period Type", RecDate."Period Type"::Date);
        if not RecDate.IsEmpty then begin
            RecDate.FindSet();
            repeat
                Rec.Init();
                Rec.P_RTCD := '00';
                Rec.P_ERRCD := '';
                Rec.P_ERRMSG := '';
                Rec."YYMMDD" := CustomFormatDate(RecDate."Period Start");
                if IsWorkingDay(RecDate."Period Start") then begin
                    Rec.HANTEIS := '';
                    Rec.HANTEIK := '';
                end else begin
                    Rec.HANTEIS := '1';
                    Rec.HANTEIK := '1';
                end;
                Rec.YOBIKB := FORMAT(RecDate."Period No." Mod 7);
                Rec.YOUBI := RecDate."Period Name".Substring(1, 3).ToUpper();
                Rec.FROMTIME := '0000';
                Rec.TOTIME := '2359';
                Rec.Insert();
            until RecDate.Next() = 0;
        end;
    end;

    local procedure IsWorkingDay(DateToCheck: Date): Boolean
    var
        CalManagement: Codeunit "Calendar Management";
        RecBaseCal: Record "Base Calendar";
        CustCalChange: Record "Customized Calendar Change";
        "IsWorkDay": Boolean;
    begin
        IsWorkDay := true;
        if RecBaseCal.FindFirst() then begin
            // Use the Company as the calendar source.
            // (You can change the Calendar Source Type if you have a different base calendar set up.)
            CustCalChange.SetSource(Enum::"Calendar Source Type"::Company, '', '', RecBaseCal.Code);

            // Check if DateToCheck is a non‐working day based on the base calendar, set it as not to change to is working day.
            "IsWorkDay" := not CalManagement.IsNonworkingDay(DateToCheck, CustCalChange);
        end;
        exit("IsWorkDay");
    end;


    local procedure CustomFormatDate(DateValue: Date): Text
    begin
        exit(Format(DateValue, 0, '<year4><month,2><day,2>'));
    end;
}
