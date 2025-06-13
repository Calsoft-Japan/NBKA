//FDD301 page for the NBKAPI INSTOKUCD.
page 50025 "NBK_INSTOKUCD"
{
    ApplicationArea = All;
    Caption = 'NBK_INSTOKUCD';
    PageType = List;
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_INSTOKUCD";
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
                field(USERCD; Rec.USERCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(CustomerNo; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TNAME; Rec.TNAME)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TADDRESS; Rec.TADDRESS)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TADDRESS2; Rec.TADDRESS2)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TCOUNTRY; Rec.TCOUNTRY)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TCITY; Rec.TCITY)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TSTATE; Rec.TSTATE)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TPOSTCODE; Rec.TPOSTCODE)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TTELNO; Rec.TTELNO)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(EMAIL; Rec.EMAIL)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TCONTACT; Rec.TCONTACT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RESELLER; Rec.RESELLER)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
