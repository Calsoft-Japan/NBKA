//FDD311 Code Unit for Export PO To Vendor
codeunit 50020 "Export PO To Vendor"
{
    trigger OnRun()
    begin
        if ExportPOtoVendor() then begin
        end;
    end;

    procedure ExportPOtoVendor(): Boolean
    var
        RecPurchaseHeader: Record "Purchase Header";
        TmpRecVendor: Record Vendor temporary;
        RecVendor: Record Vendor;
        LastVendorNo: Code[20];
    begin
        RecVendor.Reset();
        RecVendor.SetRange("EDI Target", true);
        RecVendor.SetFilter("E-Mail", '<>%1', '');
        if RecVendor.IsEmpty then begin
            exit(false);
        end;
        RecVendor.FindSet();
        repeat
            TmpRecVendor.Init();
            TmpRecVendor.TransferFields(RecVendor);
            TmpRecVendor.Insert();
        until RecVendor.Next() = 0;
        if TmpRecVendor.IsEmpty then begin
            exit(false);
        end
        else begin
            if not ExportPOtoVendor(TmpRecVendor) then begin
                exit(false);
            end;
        end;
        exit(true);
    end;

    procedure ExportPOtoVendor(var TmpRecVendor: Record vendor temporary): Boolean
    var
        BigTxtEdiContents: BigText;
        RecPurchaseHeader: Record "Purchase Header";
        RecPurchaseLine: Record "Purchase Line";
        RecSalesHeader: Record "Sales Header";
        TmpRecSalesHeader: Record "Sales Header" temporary;
        RecItem: Record Item;
        TmpRecItem: Record Item temporary;
        RecDSHIPPO: Record "DSHIP Package Options";
        TmpRecDSHIPPO: Record "DSHIP Package Options" temporary;
        c_LineSeparator: Text[2];
        c_FieldSeparator: Char;
        HasRecord: Boolean;
        EmailSubject: Text;
    begin
        c_LineSeparator[1] := 13;
        c_LineSeparator[2] := 10;
        c_FieldSeparator := ',';
        TmpRecVendor.FindSet();
        repeat
            HasRecord := false;
            Clear(BigTxtEdiContents);
            BigTxtEdiContents.AddText('"PurchaseOrderNo","Line","PO-LINE","P/N","ProductNo","Supplier","Quantity","UnitPrice","AmountPrice","OrderDate","DeliveryDate",'
                + '"DropShipFlg","ShippingAgent","ShippingAccount","CustomerPurchaseOrderNo","CustomerCode","CustomerName","CustomerPhoneNo","CustomerPostCode",'
                + '"CustomerCountry","CustomerState","CustomerCity","CustomerAddress1","CustomerAddress2","ShipToCode","ShipToName","ShipToPhoneNo","ShipToPostCode",'
                + '"ShipToCountry","ShipToState","ShipToCity","ShipToAddress1","ShipToAddress2"' + c_LineSeparator);
            RecPurchaseHeader.Reset();
            RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
            RecPurchaseHeader.SetRange(Status, RecPurchaseHeader.Status::Released);
            RecPurchaseHeader.SetRange("Buy-from Vendor No.", TmpRecVendor."No.");
            RecPurchaseHeader.SetRange("EDI Order Completed", false);
            if (not RecPurchaseHeader.IsEmpty) then begin
                RecPurchaseHeader.FindSet();
                repeat
                    RecPurchaseLine.Reset();
                    RecPurchaseLine.SetRange("Document Type", RecPurchaseLine."Document Type"::Order);
                    RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
                    if not RecPurchaseLine.IsEmpty() then begin
                        HasRecord := true;
                        RecPurchaseLine.FindSet();
                        repeat
                            TmpRecSalesHeader.Reset();
                            TmpRecSalesHeader.Init();
                            Clear(TmpRecSalesHeader);
                            TmpRecDSHIPPO.Reset();
                            TmpRecDSHIPPO.Init();
                            clear(TmpRecDSHIPPO);
                            RecSalesHeader.Reset();
                            if RecPurchaseLine."Drop Shipment" then begin
                                if RecSalesHeader.Get(RecSalesHeader."Document Type"::Order, RecPurchaseLine."Sales Order No.") then begin
                                    TmpRecSalesHeader.TransferFields(RecSalesHeader);
                                    RecDSHIPPO.Reset();
                                    RecDSHIPPO.SetRange("Document Type", RecDSHIPPO."Document Type"::"Sales Order");
                                    RecDSHIPPO.SetRange("Document No.", RecSalesHeader."No.");
                                    if RecDSHIPPO.FindFirst() then begin
                                        TmpRecDSHIPPO.TransferFields(RecDSHIPPO);
                                    end;
                                end;
                            end;
                            TmpRecItem.Reset();
                            TmpRecItem.Init();
                            Clear(TmpRecItem);
                            RecItem.Reset();
                            if ((RecPurchaseLine.Type = RecPurchaseLine.Type::Item) and RecItem.Get(RecPurchaseLine."No.")) then begin
                                TmpRecItem.TransferFields(RecItem);
                            end;
                            BigTxtEdiContents.AddText(StrSubstNo('%3%1%4%1%5%1%6%1%7%1%8%1%9%1%10%1%11%1%12'
                            + '%1%13%1%14%1%15%1%16%1%17%1%18%1%19%1%20%1%21%1%22'
                            + '%1%23%1%24%1%25%1%26%1%27%1%28%1%29%1%30%1%31%1%32'
                            + '%1%33%1%34%1%35%2', c_FieldSeparator, c_LineSeparator,
                            EscapeCSVValue(RecPurchaseLine."Document No."),
                            RecPurchaseLine."Line No.",
                            EscapeCSVValue(StrSubstNo('%1-%2', RecPurchaseLine."Document No.", RecPurchaseLine."Line No.")),
                            EscapeCSVValue(TmpRecItem."P/N"),
                            EscapeCSVValue(TmpRecItem.Description),
                            EscapeCSVValue(RecPurchaseHeader."Buy-from Vendor Name"),
                            Format(RecPurchaseLine.Quantity, 0, '<Sign><Integer><Decimals>'),
                            Format(RecPurchaseLine."Direct Unit Cost", 0, '<Sign><Integer><Decimals>'),
                            Format(RecPurchaseLine."Line Amount", 0, '<Sign><Integer><Decimals>'),
                            Format(RecPurchaseHeader."Order Date", 0, '<Year4><Month,2><Day,2>'),
                            Format(RecPurchaseLine."Expected Receipt Date", 0, '<Year4><Month,2><Day,2>'),
                            FormatBooleanAsText(RecPurchaseLine."Drop Shipment"),
                            EscapeCSVValue(TmpRecSalesHeader."Shipping Agent Code"),
                            EscapeCSVValue(RecDSHIPPO."Payment Account No."),
                            EscapeCSVValue(TmpRecSalesHeader."External Document No."),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to Customer No."),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to Customer Name"),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to Phone No."),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to Post Code"),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to Country/Region Code"),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to County"),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to City"),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to Address"),
                            EscapeCSVValue(TmpRecSalesHeader."Sell-to Address 2"),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to Contact"),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to Name"),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to Phone No."),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to Post Code"),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to Country/Region Code"),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to County"),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to City"),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to Address"),
                            EscapeCSVValue(TmpRecSalesHeader."Ship-to Address 2")));
                        until RecPurchaseLine.Next() = 0;
                    end;
                until RecPurchaseHeader.Next() = 0;
            end;
            if HasRecord then begin
                EmailSubject := StrSubstNo('NBKA PO_%1', FORMAT(CurrentDateTime(), 0, '<Year4><Month,2><Day,2>-<Hour,2><Minute,2>'));
                if SendEmailWithCSV(TmpRecVendor.Name, TmpRecVendor."E-Mail", '', EmailSubject, BigTxtEdiContents) then begin
                    RecPurchaseHeader.Reset();
                    RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
                    RecPurchaseHeader.SetRange(Status, RecPurchaseHeader.Status::Released);
                    RecPurchaseHeader.SetRange("Buy-from Vendor No.", TmpRecVendor."No.");
                    RecPurchaseHeader.SetRange("EDI Order Completed", false);
                    if (not RecPurchaseHeader.IsEmpty) then begin
                        RecPurchaseHeader.FindSet();
                        repeat
                            RecPurchaseLine.Reset();
                            RecPurchaseLine.SetRange("Document Type", RecPurchaseLine."Document Type"::Order);
                            RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
                            if not RecPurchaseLine.IsEmpty() then begin
                                RecPurchaseHeader.Validate("EDI Order Completed", true);
                                RecPurchaseHeader.Validate("EDI Order Completed Date-Time", CurrentDateTime);
                                RecPurchaseHeader.Modify();
                            end;
                        until RecPurchaseHeader.Next() = 0;
                    end;
                end;
            end;
        until TmpRecVendor.Next() = 0;
    end;

    local procedure FormatBooleanAsText(Value: Boolean): Text
    var
        ResultText: Text;
    begin
        if Value then
            ResultText := '1'
        else
            ResultText := '0';
        exit(ResultText);
    end;

    // Helper function to escape values (e.g., if they contain commas or quotes)
    local procedure EscapeCSVValue(Value: Text): Text
    begin
        if (StrPos(Value, ',') > 0) or (StrPos(Value, '"') > 0) then
            exit('"' + Value.Replace('"', '""') + '"')
        else
            exit(Value);
    end;

    procedure SendEmailWithCSV(EmailToName: Text; EmailTo: Text; EmailCC: Text; EmailSubject: Text; BigTxtEdiContents: BigText): Boolean
    var
        EmailBody: text;
        FileName: Text;
        isSent: boolean;
    begin
        isSent := false;
        EmailBody := '<p>Dear Valued Supplier,</p>';
        EmailBody += '<p>Please kindly confirm the attached purchase order.</p>';
        EmailBody += '<p>Thank you in advance for your cooperation.</p>';
        EmailBody += '<p><br></p>';
        EmailBody += '<p>Best regards,</p>';
        EmailBody += '<p>NBK America</p>';
        FileName := EmailSubject + '.csv';
        isSent := SeendEmailWithAttachment(EmailTo, EmailCC, EmailSubject, EmailBody, FileName, BigTxtEdiContents);
        exit(isSent);
    end;

    procedure SeendEmailWithAttachment(EmailTo: Text; EmailCC: Text; EmailSubject: Text; EmailBody: Text; FileName: Text; BigTxtEdiContents: BigText): Boolean
    var
        EmailToList: List of [Text];
        EmailCCList: List of [Text];
        EmailBCCList: List of [Text];
        CuEmailMessage: codeunit "Email Message";
        CuEmailAccount: Codeunit "Email Account";
        ema: Record "Email Attachments";
        CuEmail: codeunit Email;
        TempCuEmailAccount: record "Email Account" temporary;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        isSent: boolean;
    begin
        if EmailCC <> '' then begin
            CuEmailMessage.Create(EmailTo, EmailSubject, EmailBody, true);
        end
        else begin
            EmailToList := EmailTo.Split(';');
            EmailCCList := EmailCC.Split(';');
            // Create an OutStream on a Temp Blob and write your text data.
            TempBlob.CreateOutStream(OutStream);
            BigTxtEdiContents.Write(OutStream);
            // Now create an InStream from the Temp Blob
            TempBlob.CreateInStream(InStream);
            CuEmailMessage.Create(EmailToList, EmailSubject, EmailBody, true, EmailCCList, EmailBCCList);
            CuEmailMessage.AddAttachment(FileName, 'text/plain', InStream);
        end;
        CuEmailAccount.GetAllAccounts(TempCuEmailAccount);
        TempCuEmailAccount.Reset;
        TempCuEmailAccount.SetRange(Name, 'DefaultSMTP');
        isSent := false;
        if TempCuEmailAccount.FindFirst() then
            isSent := CuEmail.Send(CuEmailMessage, TempCuEmailAccount."Account Id", TempCuEmailAccount.Connector)
        else
            isSent := CuEmail.Send(CuEmailMessage);
        exit(isSent);
    end;

}
