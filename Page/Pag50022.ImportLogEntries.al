//FDD310 To FDD312 common page to show the import log.
page 50022 "Import Log Entries"
{
    ApplicationArea = All;
    Caption = 'Import Log Entries';
    PageType = List;
    SourceTable = "Import Log Entries";
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
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Datetime"; Rec."Created Datetime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Sequence"; Rec."Document Sequence")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
