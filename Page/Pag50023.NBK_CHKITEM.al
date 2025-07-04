//FDD308 page to show the NBKAPI CHKITEM.
page 50023 "NBK_CHKITEM"
{
    ApplicationArea = All;
    Caption = 'NBK_CHKITEM';
    PageType = List;
    SourceTable = "NBKAPITBL_CHKITEM";
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
                field(SEHNCD; Rec."SEHNCD")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
