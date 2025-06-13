//FDD305 page to show the NBKAPI ANNOKI.
page 50030 "NBK_ANNOKI"
{
    ApplicationArea = All;
    Caption = 'NBK_ANNOKI';
    PageType = List;
    SourceTable = "NBKAPITBL_ANNOKI";
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
                field(ANNOKI; Rec.ANNOKI)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
