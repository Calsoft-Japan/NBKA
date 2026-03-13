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

    procedure ImportInvoicesExcel()
    var
        PathFileName: Text;
        FileInStream: InStream;
        currentRow: Integer;
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
        CurrentPOHasHeader: Boolean;
        CurrentRowError: Boolean;
        WholeFileHasError: Boolean;
        RecPurchaseHeader: Record "Purchase Header";
        RecPurchaseLine: Record "Purchase Line";
        CreatedDateTime: DateTime;
        CurrentDocumentSeq: Integer;
        NextDocumentSeq: Integer;
        CurPOToBePostedLinesCount: Integer;
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
        CurrentPOHasHeader := false;
        WholeFileHasError := false;
        CurPOToBePostedLinesCount := 0;
        PurchaseOrderHeaderNo := '';
        PurchaseOrderLineNo := 0;
        NextPurchaseOrderHeaderNo := '';
        NextPurchaseOrderLineNo := 0;
        CreatedDateTime := CurrentDateTime();
        CurrentDocumentSeq := 1;
        NextDocumentSeq := 1;
        CurPOToBePostedLinesCount := 0;
        FOR currentRow := 2 TO TotalRows DO begin
            Clear(ErrorMsg);
            CurrentRowError := false;
            if (currentRow = 2) then begin
                CellText := GetValueAtCell(currentRow, 2, 0);
                NextPurchaseOrderNo := CellText;
                SplitPurchaseOrderNo(NextPurchaseOrderNo, NextPurchaseOrderHeaderNo, NextPurchaseOrderLineNo);
                GetNextDocumentSeq(NextPurchaseOrderHeaderNo, CreatedDateTime, NextDocumentSeq);
            end;
            if ((NextPurchaseOrderHeaderNo = '') or (NextPurchaseOrderLineNo = 0))
            then begin
                CurrentRowError := true;
                WholeFileHasError := true;
                ErrorMsg := StrSubstNo('The value [%1] for [Purchase Order No] Colunn in File Line [%2] has no match records.', NextPurchaseOrderNo, currentRow);
                SaveLogMessage(NextPurchaseOrderHeaderNo, NextPurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                CurrentPOHasHeader := false;
                CurPOToBePostedLinesCount := 0;
                PurchaseOrderNo := NextPurchaseOrderNo;
                PurchaseOrderHeaderNo := '';
                PurchaseOrderLineNo := 0;
            end
            else if (PurchaseOrderHeaderNo <> NextPurchaseOrderHeaderNo) then begin
                PurchaseOrderNo := NextPurchaseOrderNo;
                PurchaseOrderHeaderNo := NextPurchaseOrderHeaderNo;
                PurchaseOrderLineNo := NextPurchaseOrderLineNo;
                CurrentDocumentSeq := NextDocumentSeq;
                //end;
                RecPurchaseHeader.Reset();
                if RecPurchaseHeader.Get(RecPurchaseHeader."Document Type"::Order, PurchaseOrderHeaderNo) then begin
                    CurrentPOHasHeader := true;
                    CurPOToBePostedLinesCount := 0;
                    ReOpened := false;
                    if RecPurchaseHeader.Status <> RecPurchaseHeader.Status::Open then begin
                        ReleasePurchDoc.PerformManualReopen(RecPurchaseHeader);
                        ReOpened := true;
                    end;
                    RecPurchaseLine.Reset();
                    RecPurchaseLine.SetRange("Document Type", RecPurchaseHeader."Document Type");
                    RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
                    RecPurchaseLine.SetFilter("Quantity Received", '>%1', 0);
                    //RecPurchaseLine.SetFilter("Qty. to Invoice", '>%1', 0);
                    if not RecPurchaseLine.IsEmpty() then begin
                        RecPurchaseLine.FindSet();
                        repeat
                            RecPurchaseLine."Qty. Invoiced (Base)" := RecPurchaseLine."Quantity Invoiced" * RecPurchaseLine."Qty. per Unit of Measure";
                            RecPurchaseLine."Qty. to Invoice" := 0;
                            RecPurchaseLine."Qty. to Invoice (Base)" := 0;
                            RecPurchaseLine.Modify(true);
                        until RecPurchaseLine.Next() = 0;
                    end;
                end
                else begin
                    CurrentRowError := true;
                    WholeFileHasError := true;
                    ErrorMsg := StrSubstNo('The value [%1] for [Purchase Order No] Colunn in File Line [%2] has no match records.', PurchaseOrderNo, currentRow);
                    SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                    CurrentPOHasHeader := false;
                    CurPOToBePostedLinesCount := 0;
                    PurchaseOrderHeaderNo := '';
                    PurchaseOrderLineNo := 0;
                end;
            end
            else begin
                PurchaseOrderNo := NextPurchaseOrderNo;
                PurchaseOrderLineNo := NextPurchaseOrderLineNo;
            end;
            if (not CurrentRowError) then begin
                if (PurchaseOrderLineNo > 0) then begin
                    CellText := GetValueAtCell(currentRow, 11, 0);
                    ShipmenmtDate := CellText.Trim().Substring(5, 2) + '/' + CellText.Trim().Substring(7, 2) + '/' + CellText.Trim().Substring(1, 4);
                    if Evaluate(PostingDate, ShipmenmtDate.Trim()) then begin
                        RecPurchaseHeader.Validate("Posting Date", PostingDate);
                        CellText := GetValueAtCell(currentRow, 3, 0);
                        InvoiceNo := CellText.Trim();
                        if InvoiceNo <> '' then begin
                            //RecPurchaseHeader.Validate("Vendor Invoice No.", InvoiceNo + '-' + Format(x - 1));
                            RecPurchaseHeader.Validate("Vendor Invoice No.", GetNextSubInvoiceNo(RecPurchaseHeader."Buy-from Vendor No.", InvoiceNo));
                            RecPurchaseHeader.Validate("Your Reference", InvoiceNo);
                            if RecPurchaseLine.Get(RecPurchaseLine."Document Type"::Order, PurchaseOrderHeaderNo, PurchaseOrderLineNo) then begin
                                CellText := GetValueAtCell(currentRow, 6, 0);
                                Quantity := CellText;
                                if Evaluate(QuantityValue, Quantity.Trim()) then begin
                                    if RecPurchaseLine."Quantity Received" - RecPurchaseLine."Quantity Invoiced" >= QuantityValue then begin
                                        RecPurchaseLine.Validate("Qty. to Invoice", QuantityValue);
                                        CellText := GetValueAtCell(currentRow, 9, 0);
                                        DCost := CellText;
                                        if Evaluate(DUnitCost, DCost.Trim()) then begin
                                            RecPurchaseLine.Validate("Direct Unit Cost", DUnitCost);
                                            /* The codes are use to fix data issue for posting error with error message 'The binding of codeunit 90 was unsuccessful. The codeunit has already been bound.'
                                               Keep them temporary for a while until there are no POs that can't be posted.
                                            RecPurchaseLine."Quantity Received" := 0;
                                            RecPurchaseLine."Qty. Received (Base)" := 0;
                                            RecPurchaseLine."Outstanding Quantity" := RecPurchaseLine.Quantity;
                                            RecPurchaseLine."Outstanding Qty. (Base)" := RecPurchaseLine."Quantity (Base)";
                                            RecPurchaseLine."Qty. Rcd. Not Invoiced" := 0;
                                            RecPurchaseLine."Qty. Rcd. Not Invoiced (Base)" := 0;*/
                                            CurPOToBePostedLinesCount += 1;
                                            RecPurchaseLine.Modify();
                                            RecPurchaseHeader.Modify();
                                            ErrorMsg := '';
                                            SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, true, ErrorMsg, CurrentDocumentSeq, currentRow);
                                        end
                                        else begin
                                            CurrentRowError := true;
                                            WholeFileHasError := true;
                                            ErrorMsg := StrSubstNo('The value [%1] for Cloumn [Unit Price] in File Line [%2] is not a valid Decimal.', DCost, currentRow);
                                            SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                                        end;
                                    end
                                    else begin
                                        CurrentRowError := true;
                                        WholeFileHasError := true;
                                        ErrorMsg := StrSubstNo('The Quantity [%1] for in File Line [%2] is larger than the value that can be invoiced.', QuantityValue, currentRow);
                                        SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                                    end;
                                end
                                else begin
                                    CurrentRowError := true;
                                    WholeFileHasError := true;
                                    ErrorMsg := StrSubstNo('The value [%1] for Cloumn [Quantity] in File Line [%2] is not a valid Decimal.', Quantity, currentRow);
                                    SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                                end;
                            end
                            else begin
                                CurrentRowError := true;
                                WholeFileHasError := true;
                                ErrorMsg := StrSubstNo('The value [%1] for Cloumn [ShipmentDate] in File Line [%2] is not a valid Date.', CellText, currentRow);
                                SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                            end;
                        end
                        else begin
                            CurrentRowError := true;
                            WholeFileHasError := true;
                            ErrorMsg := StrSubstNo('The value [%1] for Cloumn [Invoice_Number] in File Line [%2] is not valid.', InvoiceNo, currentRow);
                            SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                        end;
                    end
                    else begin
                        CurrentRowError := true;
                        WholeFileHasError := true;
                        ErrorMsg := StrSubstNo('The value [%1] for Cloumn [ShipmentDate] in File Line [%2] is not a valid Date.', CellText, currentRow);
                        SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                    end;
                end
                else begin
                    ErrorMsg := StrSubstNo('There is import error occured at other lines for PO [%1] in [Purchase Order No] Colunn in File Line [%2].', PurchaseOrderHeaderNo, currentRow);
                    SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                end;
            end
            else begin
                ErrorMsg := StrSubstNo('The value [%1] from Cloumn [Purchase Order No] in File Line [%2] is empty or invalid.', PurchaseOrderNo, currentRow);
                SaveLogMessage(PurchaseOrderHeaderNo, PurchaseOrderLineNo, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
            end;
            if (currentRow < TotalRows) then begin
                NextDocumentSeq := CurrentDocumentSeq;
                CellText := GetValueAtCell(currentRow + 1, 2, 0);
                NextPurchaseOrderNo := CellText;
                SplitPurchaseOrderNo(NextPurchaseOrderNo, NextPurchaseOrderHeaderNo, NextPurchaseOrderLineNo);
            end
            else begin
                NextPurchaseOrderHeaderNo := '';
                NextPurchaseOrderLineNo := 0;
            end;
            if (CurrentPOHasHeader = true) and (CurPOToBePostedLinesCount > 0) and ((currentRow = TotalRows) or (PurchaseOrderHeaderNo <> NextPurchaseOrderHeaderNo)) then begin
                RecPurchaseHeader.Receive := false;
                RecPurchaseHeader.Invoice := true;
                RecPurchaseHeader.Modify();
                if ReOpened then begin
                    ReleasePurchDoc.PerformManualRelease(RecPurchaseHeader);
                end;
                Commit();
                //if not PurPost.RUN(RecPurchaseHeader) then begin
                if not PostPurchaseHeader(RecPurchaseHeader) then begin
                    CurrentRowError := true;
                    WholeFileHasError := true;
                    ErrorMsg := StrSubstNo('Post to invoice failured for PO [%1], the detailed error message is [%2].', PurchaseOrderHeaderNo, GetLastErrorText());
                end;
                if (CurrentRowError) then begin
                    SaveLogMessage(PurchaseOrderHeaderNo, 0, CreatedDateTime, false, ErrorMsg, CurrentDocumentSeq, currentRow);
                end;
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

    procedure PostPurchaseHeader(var RecPurchaseHeader: Record "Purchase Header"): Boolean
    var
        PurchPost: Codeunit "Purch.-Post";
        PostResult: Boolean;
    begin
        PostResult := false;
        //if PurchPost.RUN(RecPurchaseHeader) then begin
        //Commit();
        if CODEUNIT.Run(CODEUNIT::"Purch.-Post", RecPurchaseHeader) then begin
            PostResult := true;
        end;
        //Commit();
        exit(PostResult);
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

    procedure SaveLogMessage(DocumentNo: Code[20]; LineNo: Integer; CreatedDateTime: DateTime; Status: Boolean; ErrorMsg: Text; DocumentSeq: Integer; CurrentRow: Integer)
    var
        savingLineNo: Integer;
    begin
        if (DocumentNo = '') and (LineNo = 0) and (CurrentRow > 0) then begin
            savingLineNo := CurrentRow;
        end
        else begin
            savingLineNo := LineNo;
        end;
        if (Status) then begin
            RecImportLogEntries.SaveLogEntry(RecImportLogEntries."Entry Type"::"Purchase Invoice", DocumentNo, savingLineNo, CreatedDateTime, RecImportLogEntries.Status::Success, ErrorMsg, DocumentSeq);
        end
        else begin
            RecImportLogEntries.SaveLogEntry(RecImportLogEntries."Entry Type"::"Purchase Invoice", DocumentNo, savingLineNo, CreatedDateTime, RecImportLogEntries.Status::Error, ErrorMsg, DocumentSeq);
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

    procedure GetNextSubInvoiceNo(VendorNo: Code[20]; VendorInvoiceNo: Text): Code[35]
    var
        NextSubNo: Integer;
        NextSubInvoiceNo: Code[35];
        CurrentSubNo: Integer;
        CurrentSubNoStr: Text;
        CurrentSubNoList: list of [Text];
        RecPurInvHeader: Record "Purch. Inv. Header";
    begin
        NextSubNo := 0;
        RecPurInvHeader.Reset();
        RecPurInvHeader.SetRange("Buy-from Vendor No.", VendorNo);
        RecPurInvHeader.SetFilter("Vendor Invoice No.", VendorInvoiceNo + '*');
        if not RecPurInvHeader.IsEmpty then begin
            RecPurInvHeader.FindSet();
            repeat
                Clear(CurrentSubNoList);
                CurrentSubNoStr := RecPurInvHeader."Vendor Invoice No.";
                CurrentSubNoList := CurrentSubNoStr.Split('-');
                if CurrentSubNoList.Count > 1 then begin
                    if Evaluate(CurrentSubNo, CurrentSubNoList.Get(2)) then begin
                        if NextSubNo < CurrentSubNo then begin
                            NextSubNo := CurrentSubNo;
                        end;
                    end;
                end;
            until RecPurInvHeader.Next() = 0;
        end;
        NextSubNo += 1;
        NextSubInvoiceNo := VendorInvoiceNo + '-' + Format(NextSubNo);
        exit(NextSubInvoiceNo);
    end;
}
