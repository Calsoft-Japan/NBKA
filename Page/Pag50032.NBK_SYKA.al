//FDD306 page to show the NBKAPI SYKA.
page 50032 "NBK_SYKA"
{
    ApplicationArea = All;
    Caption = 'NBK_SYKA';
    PageType = List;
    SourceTable = "NBKAPITBL_SYKA";
    UsageCategory = Administration;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created datetime"; Rec."Created datetime")
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
                    Editable = false;
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
}
