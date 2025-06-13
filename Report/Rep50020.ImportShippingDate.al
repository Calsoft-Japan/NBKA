//FDD312 Report for Import Shipment Date
report 50021 "Import Shipping Date"
{
    Caption = 'Import Shipping Date';
    UsageCategory = Tasks;
    ApplicationArea = all;
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }
        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
    end;

    trigger OnPreReport()
    var
        PurchaseLine: Record "Purchase Line";
        CalendarMgmt: Codeunit "Calendar Management";
        DateRec: Record Date;

        X: Integer;
        PathFileName: Text;
        FileInStream: InStream;
        PurchaseLineInfo: Text;
        SplitValues: List of [Text];
        Position: Integer;
        LineNo: Integer;

        ErrorMsg: Text;
        ReceiptDate: Date;
        InitialDate: Date;
        CreatedDateTime: DateTime;
        CurrentDocumentSeq: Integer;
    begin
        Clear(FileInStream);
        ErrorsStatus := 0;
        CSVFileSeperator := ',';
        CSVFileFieldSeperator := '"';
        if UploadIntoStream('Import txt file:', 'C:\TEMP', ' TXT file|*.TXT', PathFileName, FileInStream) then begin
            CSVBuf.LOCKTABLE;
            CSVBuf.DELETEALL;
            CSVBuf.LoadDataFromStream(FileInStream, CSVFileSeperator, CSVFileFieldSeperator);
        end
        else
            exit;

        GetLastRowandColumn();
        FOR X := 2 TO TotalRows DO begin
            Clear(ErrorMsg);
            PurchaseLineInfo := GetValueAtCell(X, 1, 0);
            Position := StrPos(PurchaseLineInfo, '-');
            ReceiptDate := ManualConversion(GetValueAtCell(X, 2, 0));

            CreatedDateTime := CurrentDateTime();
            CurrentDocumentSeq := 1;

            if Position > 0 then begin
                SplitValues := PurchaseLineInfo.Split('-');

                if Evaluate(LineNo, SplitValues.Get(2)) then begin
                    GetNextDocumentSeq(SplitValues.Get(1), LineNo, CreatedDateTime, CurrentDocumentSeq);

                    if ReceiptDate = 0D THEN begin
                        AddLogMessage(SplitValues.Get(1), LineNo, false, 'Import error by Import Shipping Date in [Invalid Receipt Date]', CreatedDateTime, CurrentDocumentSeq);
                    end
                    else begin
                        InitialDate := ReceiptDate + 2;
                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document No.", SplitValues.Get(1));
                        PurchaseLine.SetRange("Line No.", LineNo);
                        if PurchaseLine.FindFirst() then begin
                            PurchaseLine."Promised Receipt Date" := ReceiptDate;
                            PurchaseLine.Modify();

                            while not IsWorkingDay(InitialDate) DO begin
                                InitialDate := InitialDate + 1;
                            end;

                            if PurchaseLine."Drop Shipment" then begin
                                if SetShippingDate(PurchaseLine."Sales Order No.", PurchaseLine."Sales Order Line No.", InitialDate) then begin
                                    AddLogMessage(SplitValues.Get(1), LineNo, true, '', CreatedDateTime, CurrentDocumentSeq);
                                end
                                else begin
                                    AddLogMessage(SplitValues.Get(1), LineNo, false, 'Import error by Import Shipping Date in [Sales Lines not found]', CreatedDateTime, CurrentDocumentSeq);
                                end;
                            end
                            else begin
                                if SetShippingDate(PurchaseLine."Special Order Sales No.", PurchaseLine."Special Order Sales Line No.", InitialDate) then begin
                                    AddLogMessage(SplitValues.Get(1), LineNo, true, '', CreatedDateTime, CurrentDocumentSeq);
                                end else begin
                                    AddLogMessage(SplitValues.Get(1), LineNo, false, 'Import error by Import Shipping Date in [Sales Lines not found]', CreatedDateTime, CurrentDocumentSeq);
                                end;
                            end;
                        end else begin
                            AddLogMessage(SplitValues.Get(1), LineNo, false, 'Import error by Import Shipping Date in [Purchase Lines not found]', CreatedDateTime, CurrentDocumentSeq);
                        end;
                    end;
                end;
            end;
        end;
        if ErrorsStatus <> 0 then
            Message('Data import finished with errors. Please refer to the Import Log Entries for details.')
        else
            Message('Data import finished.');

    end;

    var
        RecImportLogEntries: Record "Import Log Entries";
        CSVBuf: Record "CSV Buffer" temporary;
        PurchaseLine: Record "Purchase Line";
        CSVFileSeperator: Text[1];
        CSVFileFieldSeperator: Text[1];
        TotalColumns: Integer;
        TotalRows: Integer;
        CurrCalendarChange: Record "Customized Calendar Change";
        ErrorsStatus: Integer;

    procedure GetLastRowandColumn();
    begin
        CSVBuf.SETRANGE("Line No.", 1);
        TotalColumns := CSVBuf.COUNT;

        CSVBuf.RESET;
        IF CSVBuf.FINDLAST THEN
            TotalRows := CSVBuf."Line No.";
    end;

    procedure ManualConversion(DateString: Text) ResultDate: Date;
    var
        Year: Integer;
        Month: Integer;
        Day: Integer;

    begin

        Evaluate(Year, CopyStr(DateString, 1, 4));
        Evaluate(Month, CopyStr(DateString, 5, 2));
        Evaluate(Day, CopyStr(DateString, 7, 2));

        if (Month < 1) or (Month > 12) then begin
            ResultDate := 0D;
            exit;
        end;

        if (Day < 1) or (Day > 31) then begin
            ResultDate := 0D;
            exit;
        end;

        ResultDate := DMY2Date(Day, Month, Year);
    end;

    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer; length: Integer): Text;
    begin
        IF CSVBuf.GET(RowNo, ColNo) THEN BEGIN
            IF length = 0 THEN
                EXIT(CSVBuf.Value)
            ELSE
                EXIT(COPYSTR(CSVBuf.Value, 1, length))

        END
        ELSE
            EXIT('');
    end;

    procedure SetShippingDate(OrderNo: Code[20]; LineNo: Integer; InitialDate: Date): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", OrderNo);
        SalesLine.SetRange("Line No.", LineNo);
        if SalesLine.FindFirst() then begin

            if InitialDate > SalesLine."Requested Delivery Date" then
                SalesLine."Shipping Date" := InitialDate
            else
                SalesLine."Shipping Date" := SalesLine."Requested Delivery Date";
            SalesLine.Modify();
            exit(true);
        end else begin
            exit(false);
        end;

    end;

    local procedure IsWorkingDay(DateToCheck: Date): Boolean
    var
        CalManagement: Codeunit "Calendar Management";
        RecBaseCal: Record "Base Calendar";
        CustCalChange: Record "Customized Calendar Change";
        IsWorkDay: Boolean;
    begin
        IsWorkDay := true;
        if RecBaseCal.FindFirst() then begin
            // Use the Company as the calendar source.
            // (You can change the Calendar Source Type if you have a different base calendar set up.)
            CustCalChange.SetSource(Enum::"Calendar Source Type"::Company, '', '', RecBaseCal.Code);

            // Check if DateToCheck is a non‐working day based on the base calendar, set it as not to change to is working day.
            IsWorkDay := not CalManagement.IsNonworkingDay(DateToCheck, CustCalChange);
        end;
        exit(IsWorkDay);
    end;

    procedure AddLogMessage(DocumentNo: Code[20]; LineNo: Integer; Status: Boolean; ErrorMsg: Text; CreatedDatetime: DateTime; var DocumentSeq: Integer)
    begin
        if (Status) then begin
            RecImportLogEntries.SaveLogEntry(RecImportLogEntries."Entry Type"::"Shipping Date", DocumentNo, LineNo, CreatedDateTime, RecImportLogEntries.Status::Success, ErrorMsg, DocumentSeq);
        end
        else begin
            RecImportLogEntries.SaveLogEntry(RecImportLogEntries."Entry Type"::"Shipping Date", DocumentNo, LineNo, CreatedDateTime, RecImportLogEntries.Status::Error, ErrorMsg, DocumentSeq);
            ErrorsStatus := 1;
        end;
    end;

    procedure GetNextDocumentSeq(DocumentNo: Code[20]; LineNo: Integer; CreatedDatetime: DateTime; var DocumentSeq: Integer)
    var
        RecImpLogEnt: Record "Import Log Entries";
        CreatedDate: Date;
    begin
        CreatedDate := DT2Date(CreatedDatetime);
        DocumentSeq := 1;

        RecImpLogEnt.Reset();
        RecImpLogEnt.SetCurrentKey("Entry No.", "Entry Type", "Document No.", "Line No.", "Document Sequence");
        RecImpLogEnt.SetRange("Entry Type", RecImpLogEnt."Entry Type"::"Shipping Date");
        RecImpLogEnt.SetRange("Document No.", DocumentNo);
        RecImpLogEnt.SetRange("Line No.", LineNo);
        RecImpLogEnt.SetRange("Created Datetime", CreateDateTime(CreatedDate, 000000T), CreateDateTime(CreatedDate, 235959T));
        if RecImpLogEnt.FindLast() then begin
            DocumentSeq := RecImpLogEnt."Document Sequence" + 1;
        end;
    end;
}

