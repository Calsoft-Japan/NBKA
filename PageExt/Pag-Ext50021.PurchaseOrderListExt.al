//FDD310 Page Ext for Purchase Order List
pageextension 50021 "Purchase Order List Ext" extends "Purchase Order List"
{
    layout
    {
        addafter(Status)
        {
            field("EDI Order Completed"; Rec."EDI Order Completed")
            {
                ApplicationArea = All;
            }
            field("EDI Order Completed Date-Time"; Rec."EDI Order Completed Date-Time")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Co&mments")
        {
            action("Import Invoices")
            {
                ApplicationArea = All;
                Caption = 'Import Invoices';
                Image = ImportExcel;

                trigger OnAction()
                begin
                    ImportInvoicesExcel();
                end;
            }
        }
        addafter(Receipts_Promoted)
        {
            actionref("Import Invoices_Promoted"; "Import Invoices")
            {
            }
        }
    }

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        SheetName: Text[250];
        TotalColumns: Integer;
        TotalRows: Integer;
        RecImportLogEntries: Record "Import Log Entries";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        PurPost: Codeunit "Purch.-Post";

    procedure ImportInvoicesExcel()
    var
        PathFileName: Text;
        FileInStream: InStream;
        X: Integer;
        CellText: Text;
        PurchaseOrderHeaderNo: CODE[20];
        PurchaseOrderLineNo: Integer;
        PurchaseOrderNo: Text;
        NextPurchaseOrderHeaderNo: CODE[20];
        NextPurchaseOrderLineNo: Integer;
        NextPurchaseOrderNo: Text;
        ShipmenmtDate: Text;
        PostingDate: Date;
        InvoiceNo: Text;
        Quantity: Text;
        QuantityValue: Decimal;
        DCost: Text;
        DUnitCost: Decimal;
        ErrorMsg: Text;
        ReOpened: Boolean;
        CurrentPOHasError: Boolean;
        WholeFileHasError: Boolean;
        RecPurchaseHeader: Record "Purchase Header";
        RecPurchaseLine: Record "Purchase Line";
        CreatedDateTime: DateTime;
        CurrentDocumentSeq: Integer;
        NextDocumentSeq: Integer;
        c_LineSeparator: Text[2];
    begin
        if UploadIntoStream('Import Excel File', 'C:\TEMP', ' Excel file|*.xlsx', PathFileName, FileInStream) then begin
            sheetName := ExcelBuf.SelectSheetsNameStream(FileInStream);
            if SheetName = '' then begin
                exit;
            end;
            ExcelBuf.LOCKTABLE;
            ExcelBuf.DELETEALL;
            ExcelBuf.OpenBookStream(FileInStream, SheetName);
            ExcelBuf.SetReadDateTimeInUtcDate(true);
            ExcelBuf.ReadSheet;
        end
        else begin
            exit;
        end;

        if ExcelBuf.IsEmpty then Error('Nothing to Import. Plesae check the import file.');

        GetLastRowandColumn();
        CurrentPOHasError := false;
        WholeFileHasError := false;
        NextPurchaseOrderHeaderNo := '';
        NextPurchaseOrderLineNo := 0;
        CreatedDateTime := CurrentDateTime();
        CurrentDocumentSeq := 1;
        FOR X := 2 TO TotalRows DO begin
            Clear(ErrorMsg);
            PurchaseOrderHeaderNo := '';
            PurchaseOrderLineNo := 0;
            if (x = 2) then begin
                CellText := GetValueAtCell(X, 2, 0);
                PurchaseOrderNo := CellText;
                SplitPurchaseOrderNo(PurchaseOrderNo, PurchaseOrderHeaderNo, PurchaseOrderLineNo);
                GetNextDocumentSeq(PurchaseOrderHeaderNo, CreatedDateTime, CurrentDocumentSeq);
            end
            else begin
                PurchaseOrderHeaderNo := NextPurchaseOrderHeaderNo;
                PurchaseOrderLineNo := NextPurchaseOrderLineNo;
                CurrentDocumentSeq := NextDocumentSeq;
            end;
            if (not CurrentPOHasError) then begin
                if (PurchaseOrderHeaderNo <> '') and (PurchaseOrderLineNo > 0) and (not CurrentPOHasError) then begin
                    if RecPurchaseHeader.Get(RecPurchaseHeader."Document Type"::Order, PurchaseOrderHeaderNo) then begin
                        ReOpened := false;
                        if RecPurchaseHeader.Status <> RecPurchaseHeader.Status::Open then begin
                            ReleasePurchDoc.PerformManualReopen(RecPurchaseHeader);
                            ReOpened := true;
                        end;
                        CellText := GetValueAtCell(X, 11, 0);
                        ShipmenmtDate := CellText.Trim().Substring(5, 2) + '/' + CellText.Trim().Substring(7, 2) + '/' + CellText.Trim().Substring(1, 4);
                        if Evaluate(PostingDate, ShipmenmtDate.Trim()) then begin
                            RecPurchaseHeader.Validate("Posting Date", PostingDate);
                            CellText := GetValueAtCell(X, 3, 0);
                            InvoiceNo := CellText.Trim();
                            if InvoiceNo <> '' then begin
                                RecPurchaseHeader.Validate("Vendor Invoice No.", InvoiceNo);
                                if RecPurchaseLine.Get(RecPurchaseLine."Document Type"::Order, PurchaseOrderHeaderNo, PurchaseOrderLineNo) then begin
                                    CellText := GetValueAtCell(X, 6, 0);
                                    Quantity := CellText;
                                    if Evaluate(QuantityValue, Quantity.Trim()) then begin
                                        RecPurchaseLine.Validate("Qty. to Invoice", QuantityValue);
                                        CellText := GetValueAtCell(X, 9, 0);
                                        DCost := CellText;
                                        if Evaluate(DUnitCost, DCost.Trim()) then begin
                                            RecPurchaseLine.Validate("Direct Unit Cost", DUnitCost);
                                            RecPurchaseLine.Modify();
                                            RecPurchaseHeader.Modify();
                                            if ReOpened then begin
                                                ReleasePurchDoc.PerformManualRelease(RecPurchaseHeader);
                                            end;
                                            ErrorMsg := '';
                                            SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, true, ErrorMsg, CurrentDocumentSeq);
                                        end else begin
                                            CurrentPOHasError := true;
                                            WholeFileHasError := true;
                                            ErrorMsg := StrSubstNo('The value [%1] for Cloumn [Unit Price] in File Line [%2] is not a valid Decimal.', DCost, X);
                                            SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
                                        end;
                                    end else begin
                                        CurrentPOHasError := true;
                                        WholeFileHasError := true;
                                        ErrorMsg := StrSubstNo('The value [%1] for Cloumn [Quantity] in File Line [%2] is not a valid Decimal.', Quantity, X);
                                        SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
                                    end;
                                end
                                else begin
                                    CurrentPOHasError := true;
                                    WholeFileHasError := true;
                                    ErrorMsg := StrSubstNo('The value [%1] for Cloumn [ShipmentDate] in File Line [%2] is not a valid Date.', CellText, X);
                                    SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
                                end;
                            end else begin
                                CurrentPOHasError := true;
                                WholeFileHasError := true;
                                ErrorMsg := StrSubstNo('The value [%1] for Cloumn [Invoice_Number] in File Line [%2] is not valid.', InvoiceNo, X);
                                SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
                            end;
                        end else begin
                            CurrentPOHasError := true;
                            WholeFileHasError := true;
                            ErrorMsg := StrSubstNo('The value [%1] for Cloumn [ShipmentDate] in File Line [%2] is not a valid Date.', CellText, X);
                            SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
                        end;
                    end else begin
                        CurrentPOHasError := true;
                        WholeFileHasError := true;
                        ErrorMsg := StrSubstNo('The value [%1] for [Purchase Order No] Colunn in File Line [%2] has no match records.', PurchaseOrderHeaderNo, X);
                        SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
                    end;
                end else begin
                    ErrorMsg := StrSubstNo('There is import error occured at other lines for PO [%1] in [Purchase Order No] Colunn in File Line [%2].', PurchaseOrderHeaderNo, X);
                    SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
                end;
            end
            else begin
                ErrorMsg := StrSubstNo('The [Purchase Order No] Colunn in File Line [%1] is empty or invalid.', X);
                SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
            end;
            if (x < TotalRows) then begin
                NextDocumentSeq := CurrentDocumentSeq;
                CellText := GetValueAtCell(X + 1, 2, 0);
                NextPurchaseOrderNo := CellText;
                SplitPurchaseOrderNo(NextPurchaseOrderNo, NextPurchaseOrderHeaderNo, NextPurchaseOrderLineNo);
            end;
            if (x = TotalRows) or ((NextPurchaseOrderHeaderNo <> '') and (PurchaseOrderHeaderNo <> NextPurchaseOrderHeaderNo)) then begin
                if RecPurchaseHeader.Get(RecPurchaseHeader."Document Type"::Order, PurchaseOrderHeaderNo) and (not CurrentPOHasError) then begin
                    RecPurchaseHeader.Receive := false;
                    RecPurchaseHeader.Invoice := true;
                    RecPurchaseHeader.Modify();
                    Commit();
                    if not PurPost.RUN(RecPurchaseHeader) then begin
                        CurrentPOHasError := true;
                        WholeFileHasError := true;
                        ErrorMsg := StrSubstNo('Post to invoice failured for PO [%1], the detailed error message is [%2].', PurchaseOrderHeaderNo, GetLastErrorText());
                    end;
                end
                else begin
                    CurrentPOHasError := true;
                    WholeFileHasError := true;
                    ErrorMsg := StrSubstNo('The value [%1] for [Purchase Order No] Colunn in Line [%2] has no match records.', PurchaseOrderHeaderNo, X);
                end;
                if (CurrentPOHasError) then begin
                    SaveLogMessage(PurchaseOrderHeaderNo, 0, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq);
                end;
                CurrentPOHasError := false;
                GetNextDocumentSeq(NextPurchaseOrderHeaderNo, CreatedDateTime, NextDocumentSeq);
            end;
        end;
        if (WholeFileHasError) then begin
            c_LineSeparator[1] := 13;
            c_LineSeparator[2] := 10;
            Message('Data import failed.' + c_LineSeparator + 'Please refer to the Import Log Entries for details.');
        end
        else begin
            Message('Data import finished.');
        end;
    end;

    procedure SplitPurchaseOrderNo(PurchaseOrderNo: Text; var PurchaseOrderHeaderNo: Code[20]; var PurchaseOrderLinNo: Integer)
    var
        PurchaseNoList: List of [Text];
        TempValue: Text;
        TempInteger: Integer;
    begin
        if (PurchaseOrderNo.Contains('-')) then begin
            PurchaseNoList := PurchaseOrderNo.Split('-');
            PurchaseNoList.Get(1, TempValue);
            PurchaseOrderHeaderNo := TempValue.Trim();
            PurchaseNoList.Get(2, TempValue);
            if Evaluate(TempInteger, TempValue) then begin
                PurchaseOrderLinNo := TempInteger;
            end;
        end
        else begin
            PurchaseOrderHeaderNo := '';
            PurchaseOrderLinNo := 0;
        end;
    end;

    procedure GetNextDocumentSeq(DocumentNo: Code[20]; CreatedDateTime: DateTime; var DocumentSeq: Integer)
    begin
        RecImportLogEntries.GetNextDocumentSeq(RecImportLogEntries."Entry Type"::"Purchase Invoice", DocumentNo, CreatedDateTime, DocumentSeq);
    end;

    procedure SaveLogMessage(DocumentNo: Code[20]; LineNo: Integer; CreatedDateTime: DateTime; Status: Boolean; ErrorMsg: Text; DocumentSeq: Integer)
    begin
        if (Status) then begin
            RecImportLogEntries.SaveLogEntry(RecImportLogEntries."Entry Type"::"Purchase Invoice", DocumentNo, LineNo, CreatedDateTime, RecImportLogEntries.Status::Success, ErrorMsg, DocumentSeq);
        end
        else begin
            RecImportLogEntries.SaveLogEntry(RecImportLogEntries."Entry Type"::"Purchase Invoice", DocumentNo, LineNo, CreatedDateTime, RecImportLogEntries.Status::Error, ErrorMsg, DocumentSeq);
        end;
    end;

    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer; length: Integer): Text;
    var
        ExcelBuf1: Record "Excel Buffer" temporary;
    begin
        IF ExcelBuf.GET(RowNo, ColNo) THEN BEGIN
            IF length = 0 THEN BEGIN
                EXIT(ExcelBuf."Cell Value as Text");
            END
            ELSE BEGIN
                EXIT(COPYSTR(ExcelBuf."Cell Value as Text", 1, length))
            END;
        END
        ELSE BEGIN
            EXIT('');
        END;
    end;

    procedure GetLastRowandColumn();
    begin
        ExcelBuf.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuf.COUNT;

        ExcelBuf.RESET;
        IF ExcelBuf.FINDLAST THEN begin
            TotalRows := ExcelBuf."Row No.";
        end;
    end;
}
