//FDD310 To FDD312 common table to save the import log.
table 50022 "Import Log Entries"
{
    Caption = 'Import Log Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Editable = false;
            OptionMembers = "Purchase Invoice","Shipping Date";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Success,Error;
        }
        field(6; "Created Datetime"; DateTime)
        {
            Caption = 'Created Datetime';
            Editable = false;
        }
        field(7; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            Editable = false;
        }
        field(8; "Document Sequence"; Integer)
        {
            Caption = 'Document Sequence';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure GetNextDocumentSeq(EntryType: Option "Purchase Invoice","Shipping Date"; DocumentNo: Code[20]; CreatedDatetime: DateTime; var DocumentSeq: Integer)
    var
        //RecImpLogEnt: Record "Import Log Entries";
        CreatedDate: Date;
    begin
        CreatedDate := DT2Date(CreatedDatetime);
        DocumentSeq := 1;
        /*RecImpLogEnt.Reset();
        RecImpLogEnt.SetCurrentKey("Entry No.", "Entry Type", "Document No.", "Document Sequence");
        RecImpLogEnt.SetRange("Entry Type", EntryType);
        RecImpLogEnt.SetRange("Document No.", DocumentNo);
        RecImpLogEnt.SetRange("Created Datetime", CreateDateTime(CreatedDate, 000000T), CreateDateTime(CreatedDate, 235959T));
        if RecImpLogEnt.FindLast() then begin
            DocumentSeq := RecImpLogEnt."Document Sequence" + 1;
        end;*/
        Rec.Reset();
        Rec.SetCurrentKey("Entry No.", "Entry Type", "Document No.", "Document Sequence");
        Rec.SetRange("Entry Type", EntryType);
        Rec.SetRange("Document No.", DocumentNo);
        Rec.SetRange("Created Datetime", CreateDateTime(CreatedDate, 000000T), CreateDateTime(CreatedDate, 235959T));
        if Rec.FindLast() then begin
            DocumentSeq := Rec."Document Sequence" + 1;
        end;
    end;

    procedure SaveLogEntry(EntryType: Option "Purchase Invoice","Shipping Date"; DocumentNo: Code[20]; LineNo: Integer; CreatedDatetime: DateTime; Status: Option Success,Error; ErrorMsg: Text; DocumentSeq: Integer)
    var
        //RecImpLogEnt: Record "Import Log Entries";
        CreatedDate: Date;
    begin
        CreatedDate := DT2Date(CreatedDatetime);
        /*RecImpLogEnt.Reset();
        RecImpLogEnt.SetCurrentKey("Entry No.", "Entry Type", "Document No.", "Document Sequence");
        RecImpLogEnt.SetRange("Entry Type", EntryType);
        RecImpLogEnt.SetRange("Document No.", DocumentNo);
        if LineNo > 0 then begin
            RecImpLogEnt.SetRange("Line No.", LineNo);
        end;
        RecImpLogEnt.SetRange("Created Datetime", CreateDateTime(CreatedDate, 000000T), CreateDateTime(CreatedDate, 235959T));
        RecImpLogEnt.SetRange("Document Sequence", DocumentSeq);
        if not RecImpLogEnt.IsEmpty() then begin
            RecImpLogEnt.FindSet();
            repeat
                RecImpLogEnt.Status := Status;
                RecImpLogEnt."Error Message" := ErrorMsg;
                RecImpLogEnt.Modify();
            until RecImpLogEnt.Next() = 0;
        end*/
        Rec.Reset();
        if (DocumentNo <> '') or (LineNo <> 0) then begin
            Rec.SetCurrentKey("Entry No.", "Entry Type", "Document No.", "Document Sequence");
            Rec.SetRange("Entry Type", EntryType);
            Rec.SetRange("Document No.", DocumentNo);
            if LineNo > 0 then begin
                Rec.SetRange("Line No.", LineNo);
            end;
            Rec.SetRange("Created Datetime", CreateDateTime(CreatedDate, 000000T), CreateDateTime(CreatedDate, 235959T));
            Rec.SetRange("Document Sequence", DocumentSeq);
            if not Rec.IsEmpty() then begin
                Rec.FindSet();
                repeat
                    Rec.Status := Status;
                    Rec."Error Message" := ErrorMsg;
                    Rec.Modify();
                until Rec.Next() = 0;
                exit;
            end;
        end;
        CreateNewLogEntry(EntryType, DocumentNo, LineNo, CreatedDatetime, Status, ErrorMsg, DocumentSeq);
    end;

    local procedure CreateNewLogEntry(EntryType: Option "Purchase Invoice","Shipping Date"; DocumentNo: Code[20]; LineNo: Integer; CreatedDatetime: DateTime; Status: Option Success,Error; ErrorMsg: Text; DocumentSeq: Integer)
    var
    //RecImpLogEnt: Record "Import Log Entries";
    begin
        /*RecImpLogEnt.Reset();
        RecImpLogEnt.Init();
        RecImpLogEnt."Entry No." := 0;
        RecImpLogEnt."Entry Type" := EntryType;
        RecImpLogEnt."Document No." := DocumentNo;
        RecImpLogEnt."Line No." := LineNo;
        RecImpLogEnt."Created Datetime" := CreatedDatetime;
        RecImpLogEnt.Status := Status;
        RecImpLogEnt."Error Message" := ErrorMsg;
        RecImpLogEnt."Document Sequence" := DocumentSeq;
        RecImpLogEnt.Insert();*/
        Rec.Reset();
        Rec.Init();
        Rec."Entry No." := 0;
        Rec."Entry Type" := EntryType;
        Rec."Document No." := DocumentNo;
        Rec."Line No." := LineNo;
        Rec."Created Datetime" := CreatedDatetime;
        Rec.Status := Status;
        Rec."Error Message" := ErrorMsg;
        Rec."Document Sequence" := DocumentSeq;
        Rec.Insert();
    end;
}
