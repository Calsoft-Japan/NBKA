//FDD301 page for the NBKAPI INS LINE.
page 50038 "NBK_INS_LINE"
{
    ApplicationArea = All;
    Caption = 'NBK_INS_LINE';
    PageType = List;
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_INS_LINE";
    //UsageCategory = Administration;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

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
                field(CART2; Rec.CART2)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(JUCH2; Rec.JUCH2)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(SEHNCD; Rec.SEHNCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(QTY; Rec.QTY)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(UNITPRICE; Rec.UNITPRICE)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(REQUESTDATE; Rec.REQUESTDATE)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
