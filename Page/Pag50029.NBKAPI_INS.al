//FDD303 page for the NBKAPI INS.
page 50029 "NBKAPI_INS"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_INS';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_INS';
    EntitySetName = 'NBKAPI_INS';
    EntityCaption = 'NBKAPI_INS';
    EntityName = 'NBKAPI_INS';
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_INS";
    UsageCategory = Administration;
    Extensible = false;
    DelayedInsert = true;
    DeleteAllowed = false;
    ModifyAllowed = false;

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
                field(TOKUCD; Rec.TOKUCD)
                {
                    ApplicationArea = All;
                }
                field(NONYCD; Rec.NONYCD)
                {
                    ApplicationArea = All;
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
                }
                field(JUCH1; Rec.JUCH1)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(FREIGHT; Rec.FREIGHT)
                {
                    ApplicationArea = All;
                }
                field(AMOUNT; Rec.AMOUNT)
                {
                    ApplicationArea = All;
                }
                field(SHIPAGENT; Rec.SHIPAGENT)
                {
                    ApplicationArea = All;
                }

                //CR: FDD303/add new field
                field(SHIPSERVICE; Rec.SHIPSERVICE)
                {
                    ApplicationArea = All;
                }
                //End CR: FDD303/add new field

                field(PAYMENT; Rec.PAYMENT)
                {
                    ApplicationArea = All;
                }
                field(ORDERDATE; Rec.ORDERDATE)
                {
                    ApplicationArea = All;
                }
                field(TNAME; Rec.TNAME)
                {
                    ApplicationArea = All;
                }
                field(TPOSTCODE; Rec.TPOSTCODE)
                {
                    ApplicationArea = All;
                }
                field(TADDRESS; Rec.TADDRESS)
                {
                    ApplicationArea = All;
                }
                field(TADDRESS2; Rec.TADDRESS2)
                {
                    ApplicationArea = All;
                }
                field(TTELNO; Rec.TTELNO)
                {
                    ApplicationArea = All;
                }
                field(TCOUNTRY; Rec.TCOUNTRY)
                {
                    ApplicationArea = All;
                }
                field(TCITY; Rec.TCITY)
                {
                    ApplicationArea = All;
                }
                field(TSTATE; Rec.TSTATE)
                {
                    ApplicationArea = All;
                }
                field(TCONTACT; Rec.TCONTACT)
                {
                    ApplicationArea = All;
                }
                field(UPSACCOUNT; Rec.UPSACCOUNT)
                {
                    ApplicationArea = All;
                }
                field(FDXACCOUNT; Rec.FDXACCOUNT)
                {
                    ApplicationArea = All;
                }
                field(RESELLER; Rec.RESELLER)
                {
                    ApplicationArea = All;
                }
                field(NNAME; Rec.NNAME)
                {
                    ApplicationArea = All;
                }
                field(NADDRESS; Rec.NADDRESS)
                {
                    ApplicationArea = All;
                }
                field(NADDRESS2; Rec.NADDRESS2)
                {
                    ApplicationArea = All;
                }
                field(NPOSTCODE; Rec.NPOSTCODE)
                {
                    ApplicationArea = All;
                }
                field(NTELNO; Rec.NTELNO)
                {
                    ApplicationArea = All;
                }
                field(NCOUNTRY; Rec.NCOUNTRY)
                {
                    ApplicationArea = All;
                }
                field(NCITY; Rec.NCITY)
                {
                    ApplicationArea = All;
                }
                field(NSTATE; Rec.NSTATE)
                {
                    ApplicationArea = All;
                }
                field(NCONTACT; Rec.NCONTACT)
                {
                    ApplicationArea = All;
                }
            }
            part(salesLine; "NBKAPI_INS_LINE")
            {
                ApplicationArea = All;
                Caption = 'MTNA IF POLines';
                EntityName = 'NBKAPI_INS_LINE';
                EntitySetName = 'salesLine';
                SubPageLink = "Header Entry No." = field("Entry No.");
            }
        }
    }

    var
        RecTmpNBKAPITBL_INS: Record NBKAPITBL_INS temporary;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        HasError: Boolean;
        ErrMsg: Text;
    begin
        HasError := false;
        ErrMsg := '';
        Rec."Created datetime" := CurrentDateTime;
        if Rec.TOKUCD = '' then begin
            HasError := true;
            ErrMsg += 'TOKUCD must not be blank.';
        end;
        if HasError then begin
            Rec.P_RTCD := '99';
            Rec.P_ERRCD := 'NBKAPI_INS';
            Rec.P_ERRMSG := ErrMsg;
        end;
        if Rec.Insert(true) then begin
            if (not HasError) then begin
                RecTmpNBKAPITBL_INS.Init();
                RecTmpNBKAPITBL_INS.TransferFields(Rec);
                RecTmpNBKAPITBL_INS.Insert();
            end;
            exit(false);
        end
        else begin
            exit(false);
        end;
    end;

    trigger OnAfterGetRecord()
    var
        RecNBKAPITBL_INS_LINE: Record NBKAPITBL_INS_LINE;
        RecCustomer: Record Customer;
        RecSalesHeader: Record "Sales Header";
        RecSalesLine: Record "Sales Line";
        HasError: Boolean;
        ErrMsg: Text;
    begin
        RecTmpNBKAPITBL_INS.SetRange("Entry No.", Rec."Entry No.");
        if RecTmpNBKAPITBL_INS.FindFirst() then begin
            HasError := false;
            ErrMsg := '';
            if Rec.P_RTCD = '' then begin
                RecNBKAPITBL_INS_LINE.Reset();
                RecNBKAPITBL_INS_LINE.SetRange("Header Entry No.", Rec."Entry No.");
                if RecNBKAPITBL_INS_LINE.IsEmpty() then begin
                    exit;
                    HasError := true;
                    ErrMsg := 'There is no valid input line data.';
                end;
            end
            else begin
                HasError := true;
            end;
            RecTmpNBKAPITBL_INS.Delete();
            if not HasError then begin
                RecCustomer.Reset();
                if RecCustomer.Get(Rec.TOKUCD) then begin
                    RecCustomer.Validate("Name", Rec.TNAME);
                    RecCustomer.Validate("Address", Rec.TADDRESS);
                    RecCustomer.Validate("Address 2", Rec.TADDRESS2);
                    RecCustomer.Validate("Country/Region Code", Rec.TCOUNTRY);
                    RecCustomer.Validate("City", Rec.TCITY);
                    RecCustomer.Validate("County", Rec.TSTATE);
                    RecCustomer.Validate("Post Code", Rec.TPOSTCODE);
                    RecCustomer.Validate("Phone No.", Rec.TTELNO);
                    RecCustomer.Validate("Contact", Rec.TCONTACT);
                    RecCustomer.Modify(true);
                    RecSalesHeader.Reset();
                    if InsertSalesOrder(RecNBKAPITBL_INS_LINE, RecSalesHeader, ErrMsg) then begin
                        Commit();
                        RecSalesLine.Reset();
                        RecSalesLine.SetRange("Document No.", RecSalesHeader."No.");
                        if RecSalesLine.FindFirst() then begin
                            Rec.JUCH1 := RecSalesHeader."No.";
                            Rec.P_RTCD := '00';
                            Rec.P_ERRCD := '';
                            Rec.P_ERRMSG := '';
                            Rec.Modify(true);
                        end else begin
                            Rec.P_RTCD := '99';
                            Rec.P_ERRCD := 'NBKAPI_INS';
                            Rec.P_ERRMSG := 'Can''t find insertted Sales Line';
                            Rec.Modify(true);
                        end;
                    end
                    else begin
                        Rec.P_RTCD := '99';
                        Rec.P_ERRCD := 'NBKAPI_INS';
                        Rec.P_ERRMSG := 'Can''t insert the Sales Order, the detailed error information is: ' + GetLastErrorText();
                        Rec.Modify(true);
                    end;
                end else begin
                    Rec.P_RTCD := '99';
                    Rec.P_ERRCD := 'NBKAPI_INS';
                    Rec.P_ERRMSG := 'Customer [' + Rec.TOKUCD + '] does not exist.';
                    Rec.Modify(true);
                end;
            end
            else begin
                Rec.P_RTCD := '99';
                Rec.P_ERRCD := 'NBKAPI_INS';
                if (Rec.P_ERRMSG = '') and (ErrMsg <> '') then begin
                    Rec.P_ERRMSG := ErrMsg;
                end;
                Rec.Modify(true);
            end;
        end;
    end;

    [TryFunction]
    local procedure InsertSalesOrder(var RecNBKAPITBL_INS_LINE: Record NBKAPITBL_INS_LINE; var RecSalesHeader: Record "Sales Header"; var errorMsg: Text)
    var
        RecItem: Record Item;
        RecSalesLine: Record "Sales Line";
        RecDSPkgOpt: Record "DSHIP Package Options";
        RecCompanyInfo: Record "Company Information";
        PayAccNo: Text;
        LineNo: Integer;
    begin
        RecSalesHeader.Init();
        RecSalesHeader.Validate("Document Type", RecSalesHeader."Document Type"::Order);
        RecSalesHeader.Validate("Sell-to Customer No.", Rec.TOKUCD);
        RecSalesHeader.Insert(true);

        RecSalesHeader.Validate("Sell-to Customer Name", Rec.TNAME);
        RecSalesHeader.Validate("Sell-to Address", Rec.TADDRESS);
        RecSalesHeader.Validate("Sell-to Address 2", Rec.TADDRESS2);
        RecSalesHeader.Validate("Sell-to Country/Region Code", Rec.TCOUNTRY);
        RecSalesHeader.Validate("Sell-to City", Rec.TCITY);
        RecSalesHeader.Validate("Sell-to County", Rec.TSTATE);
        RecSalesHeader.Validate("Sell-to Post Code", Rec.TPOSTCODE);
        RecSalesHeader.Validate("Sell-to Phone No.", Rec.TTELNO);
        RecSalesHeader.Validate("Sell-to Contact", Rec.TCONTACT);
        RecSalesHeader.Validate("Order Date", Rec.ORDERDATE);
        //RecSalesHeader.Validate("External Document No.", Rec.TKHAC);
        RecSalesHeader.Validate("Your Reference", Rec.CART1);
        RecSalesHeader.Validate("EC Order", true);
        RecSalesHeader.Validate("Payment Method Code", Rec.PAYMENT);
        RecCompanyInfo.Get();
        if (Rec.RESELLER = '') and (Rec.TSTATE = RecCompanyInfo.County) then begin
            RecSalesHeader.Validate("Tax Liable", true);
        end;
        //RecSalesHeader.Validate("Ship-to Code", Rec.NONYCD);
        RecSalesHeader.Validate("Ship-to Name", Rec.NNAME);
        RecSalesHeader.Validate("Ship-to Address", Rec.NADDRESS);
        RecSalesHeader.Validate("Ship-to Address 2", Rec.NADDRESS2);
        RecSalesHeader.Validate("Ship-to Country/Region Code", Rec.NCOUNTRY);
        RecSalesHeader.Validate("Ship-to City", Rec.NCITY);
        RecSalesHeader.Validate("Ship-to County", Rec.NSTATE);
        RecSalesHeader.Validate("Ship-to Post Code", Rec.NPOSTCODE);
        RecSalesHeader.Validate("Ship-to Phone No.", Rec.NTELNO);
        RecSalesHeader.Validate("Ship-to Contact", Rec.NCONTACT);
        RecSalesHeader.Validate("Shipping Agent Code", Rec.SHIPAGENT);
        RecSalesHeader.Validate("Shipping Agent Service Code", Rec.SHIPSERVICE);
        RecSalesHeader.Validate("Shipping Advice", RecSalesHeader."Shipping Advice"::Complete);
        RecSalesHeader.Modify(true);

        LineNo := 0;
        RecNBKAPITBL_INS_LINE.FindSet();
        repeat
            RecItem.Reset();
            RecItem.SetRange("P/N", RecNBKAPITBL_INS_LINE.SEHNCD);
            RecItem.FindFirst();
            RecSalesLine.Init();
            LineNo := RecNBKAPITBL_INS_LINE.JUCH2;
            RecSalesLine.Validate("Document Type", RecSalesLine."Document Type"::Order);
            RecSalesLine.Validate("Document No.", RecSalesHeader."No.");
            RecSalesLine.Validate("Line No.", LineNo);
            RecSalesLine.Validate(Type, RecSalesLine.Type::Item);
            RecSalesLine.Validate("No.", RecItem."No.");
            RecSalesLine.Validate("P/N", RecItem."P/N");
            RecSalesLine.Validate(Quantity, RecNBKAPITBL_INS_LINE.QTY);
            RecSalesLine.Validate("Unit Price", RecNBKAPITBL_INS_LINE.UNITPRICE);
            RecSalesLine.Validate("Requested Delivery Date", RecNBKAPITBL_INS_LINE.REQUESTDATE);
            RecSalesLine.Validate("Ship-to PO No.", RecNBKAPITBL_INS_LINE.TKHAC);
            RecSalesLine.Insert(True);
        until RecNBKAPITBL_INS_LINE.Next() = 0;
        if Rec.FREIGHT > 0 then begin
            LineNo += 10000;
            RecSalesLine.Init();
            RecSalesLine.Validate("Document No.", RecSalesHeader."No.");
            RecSalesLine.Validate("Document Type", RecSalesLine."Document Type"::Order);
            RecSalesLine.Validate("Line No.", LineNo);
            RecSalesLine.Validate(Type, RecSalesLine.Type::Resource);
            RecSalesLine.Validate("No.", 'SHIPPING');
            RecSalesLine.Validate(Quantity, 1);
            RecSalesLine.Validate("Unit Price", Rec.FREIGHT);
            RecSalesLine.Validate("Amount Including VAT", Rec.FREIGHT);
            RecSalesLine.Insert(True);
        end;
        PayAccNo := '';
        if Rec.SHIPAGENT = 'UPS' then begin
            PayAccNo := Rec.UPSACCOUNT;
        end
        else if Rec.SHIPAGENT = 'FEDEX' then begin
            PayAccNo := Rec.FDXACCOUNT;
        end;
        if PayAccNo <> '' then begin
            RecDSPkgOpt.Reset();
            RecDSPkgOpt.RetrievePackageOptions("DSHIP Document Type"::"Sales Order", RecSalesHeader."No.", RecSalesHeader."No.");
            if not RecDSPkgOpt.IsEmpty() then begin
                RecDSPkgOpt."Payment Account No." := PayAccNo;
                RecDSPkgOpt.Modify(true);
            end;
        end;
    end;

}
