//FDD301 page for the NBKAPI INS.
page 50028 "NBK_INS"
{
    ApplicationArea = All;
    Caption = 'NBK_INS';
    PageType = List;
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_INS";
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
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    var
                        PagNBK_INS_LINE: Page "NBK_INS_LINE";
                        RecNBKAPITBL_INS_LINE: Record "NBKAPITBL_INS_LINE";
                    begin
                        if Rec.IsEmpty() = false then begin
                            RecNBKAPITBL_INS_LINE.Reset();
                            RecNBKAPITBL_INS_LINE.SetRange("Header Entry No.", Rec."Entry No.");
                            if RecNBKAPITBL_INS_LINE.FindFirst() then begin
                                PagNBK_INS_LINE.SetTableView(RecNBKAPITBL_INS_LINE);
                                PagNBK_INS_LINE.SetRecord(RecNBKAPITBL_INS_LINE);
                                PagNBK_INS_LINE.RunModal();
                            end
                        end;
                    end;
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
                field(TOKUCD; Rec.TOKUCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NONYCD; Rec.NONYCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(HIKIKB; '1')
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(UNSOCD; Rec.SHIPAGENT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(CART1; Rec.CART1)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(JUCH1; Rec.JUCH1)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(FREIGHT; Rec.FREIGHT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AMOUNT; Rec.AMOUNT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(SHIPAGENT; Rec.SHIPAGENT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(PAYMENT; Rec.PAYMENT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ORDERDATE; Rec.ORDERDATE)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TNAME; Rec.TNAME)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TPOSTCODE; Rec.TPOSTCODE)
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
                field(TTELNO; Rec.TTELNO)
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
                field(TCONTACT; Rec.TCONTACT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(UPSACCOUNT; Rec.UPSACCOUNT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(FDXACCOUNT; Rec.FDXACCOUNT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(RESELLER; Rec.RESELLER)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NNAME; Rec.NNAME)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NADDRESS; Rec.NADDRESS)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NADDRESS2; Rec.NADDRESS2)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NPOSTCODE; Rec.NPOSTCODE)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NTELNO; Rec.NTELNO)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NCOUNTRY; Rec.NCOUNTRY)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NCITY; Rec.NCITY)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NSTATE; Rec.NSTATE)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NCONTACT; Rec.NCONTACT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
