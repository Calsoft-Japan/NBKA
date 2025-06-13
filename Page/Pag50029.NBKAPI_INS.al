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
                field(CART2; Rec.CART2)
                {
                    ApplicationArea = All;
                }
                field(JUCH1; Rec.JUCH1)
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
                }
                field(TKHAC; Rec.TKHAC)
                {
                    ApplicationArea = All;
                }
                field(QTY; Rec.QTY)
                {
                    ApplicationArea = All;
                }
                field(UNITPRICE; Rec.UNITPRICE)
                {
                    ApplicationArea = All;
                }
                field(FREIGHT; Rec.FREIGHT)
                {
                    ApplicationArea = All;
                }
                field(AMOUNT; Rec.AMOUNT)
                {
                    ApplicationArea = All;
                }
                field(REQUESTDATE; Rec.REQUESTDATE)
                {
                    ApplicationArea = All;
                }
                field(SHIPAGENT; Rec.SHIPAGENT)
                {
                    ApplicationArea = All;
                }
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
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RecCustomer: Record Customer;
        RecItem: Record Item;
        RecSalesHeader: Record "Sales Header";
        RecSalesLine: Record "Sales Line";
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
        if Rec.SEHNCD = '' then begin
            HasError := true;
            ErrMsg += 'SEHNCD must not be blank.';
        end;
        if not HasError then begin
            RecCustomer.Reset();
            if RecCustomer.Get(Rec.TOKUCD) then begin
                RecItem.Reset();
                RecItem.SetRange("P/N", Rec.SEHNCD);
                if RecItem.FindFirst() then begin
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
                    if InsertSalesOrderHeader(Rec, RecItem, RecSalesHeader, ErrMsg) then begin
                        Commit();
                        RecSalesLine.Reset();
                        RecSalesLine.SetRange("Document No.", RecSalesHeader."No.");
                        if RecSalesLine.FindFirst() then begin
                            Rec.JUCH1 := RecSalesHeader."No.";
                            Rec.JUCH2 := RecSalesLine."Line No.";
                            Rec.P_RTCD := '00';
                            Rec.P_ERRCD := '';
                            Rec.P_ERRMSG := '';
                        end else begin
                            Rec.P_RTCD := '99';
                            Rec.P_ERRCD := 'NBKAPI_INS';
                            Rec.P_ERRMSG := 'Can''t find insertted Sales Line';
                        end;
                    end
                    else begin
                        Rec.P_RTCD := '99';
                        Rec.P_ERRCD := 'NBKAPI_INS';
                        Rec.P_ERRMSG := 'Can''t insert the Sales Order, the detailed error information is: ' + GetLastErrorText();
                    end;
                end else begin
                    Rec.P_RTCD := '99';
                    Rec.P_ERRCD := 'NBKAPI_INS';
                    Rec.P_ERRMSG := 'Item with this P/N [' + Rec.SEHNCD + '] does  not exist.';
                end;
            end else begin
                Rec.P_RTCD := '99';
                Rec.P_ERRCD := 'NBKAPI_INS';
                Rec.P_ERRMSG := 'Customer [' + Rec.TOKUCD + '] does not exist.';
            end;
        end
        else begin
            Rec.P_RTCD := '99';
            Rec.P_ERRCD := 'NBKAPI_INS';
            Rec.P_ERRMSG := ErrMsg;
        end;
        if Rec.Insert(true) then begin
            exit(false);
        end
        else begin
            exit(false);
        end;
    end;

    [TryFunction]
    local procedure InsertSalesOrderHeader(RecINS: Record NBKAPITBL_INS; RecItem: Record Item; var RecSalesHeader: Record "Sales Header"; var errorMsg: Text)
    var
        RecSalesLine: Record "Sales Line";
        RecDSPkgOpt: Record "DSHIP Package Options";
        PayAccNo: Text;
        LineNo: Integer;
    begin
        RecSalesHeader.Init();
        RecSalesHeader.Validate("Document Type", RecSalesHeader."Document Type"::Order);
        RecSalesHeader.Validate("Sell-to Customer No.", RecINS.TOKUCD);
        RecSalesHeader.Validate("Sell-to Customer Name", RecINS.TNAME);
        RecSalesHeader.Validate("Sell-to Address", RecINS.TADDRESS);
        RecSalesHeader.Validate("Sell-to Address 2", RecINS.TADDRESS2);
        RecSalesHeader.Validate("Sell-to Country/Region Code", RecINS.TCOUNTRY);
        RecSalesHeader.Validate("Sell-to City", RecINS.TCITY);
        RecSalesHeader.Validate("Sell-to County", RecINS.TSTATE);
        RecSalesHeader.Validate("Sell-to Post Code", RecINS.TPOSTCODE);
        RecSalesHeader.Validate("Sell-to Phone No.", RecINS.TTELNO);
        RecSalesHeader.Validate("Sell-to Contact", RecINS.TCONTACT);
        RecSalesHeader.Validate("Order Date", RecINS.ORDERDATE);
        RecSalesHeader.Validate("Requested Delivery Date", RecINS.REQUESTDATE);
        RecSalesHeader.Validate("External Document No.", RecINS.TKHAC);
        RecSalesHeader.Validate("Your Reference", RecINS.CART1);
        RecSalesHeader.Validate("EC Order", true);
        RecSalesHeader.Validate("Payment Method Code", RecINS.PAYMENT);
        RecSalesHeader.Validate("Tax Liable", true);
        RecSalesHeader.Validate("Ship-to Code", RecINS.NONYCD);
        RecSalesHeader.Validate("Ship-to Name", RecINS.NNAME);
        RecSalesHeader.Validate("Ship-to Address", RecINS.NADDRESS);
        RecSalesHeader.Validate("Ship-to Address 2", RecINS.NADDRESS2);
        RecSalesHeader.Validate("Ship-to Country/Region Code", RecINS.NCOUNTRY);
        RecSalesHeader.Validate("Ship-to City", RecINS.NCITY);
        RecSalesHeader.Validate("Ship-to County", RecINS.NSTATE);
        RecSalesHeader.Validate("Ship-to Post Code", RecINS.NPOSTCODE);
        RecSalesHeader.Validate("Ship-to Phone No.", RecINS.NTELNO);
        RecSalesHeader.Validate("Ship-to Contact", RecINS.NCONTACT);
        RecSalesHeader.Validate("Shipping Agent Code", RecINS.SHIPAGENT);
        RecSalesHeader.Insert(true);
        RecSalesLine.Init();
        LineNo := 0;
        LineNo += 10000;
        RecSalesLine.Validate("Document Type", RecSalesLine."Document Type"::Order);
        RecSalesLine.Validate("Document No.", RecSalesHeader."No.");
        RecSalesLine.Validate("Line No.", LineNo);
        RecSalesLine.Validate(Type, RecSalesLine.Type::Item);
        RecSalesLine.Validate("No.", RecItem."No.");
        RecSalesLine.Validate("P/N", RecItem."P/N");
        RecSalesLine.Validate(Quantity, RecINS.QTY);
        RecSalesLine.Validate("Unit Price", RecINS.UNITPRICE);
        RecSalesLine.Validate("Amount Including VAT", RecINS.AMOUNT);
        RecSalesLine.Validate("Requested Delivery Date", RecINS.REQUESTDATE);
        RecSalesLine.Insert(True);
        if RecINS.FREIGHT > 0 then begin
            LineNo += 10000;
            RecSalesLine.Init();
            RecSalesLine.Validate("Document No.", RecSalesHeader."No.");
            RecSalesLine.Validate("Document Type", RecSalesLine."Document Type"::Order);
            RecSalesLine.Validate("Line No.", LineNo);
            RecSalesLine.Validate(Type, RecSalesLine.Type::"Charge (Item)");
            RecSalesLine.Validate("No.", 'JB-FREIGHT');
            RecSalesLine.Validate(Quantity, 1);
            RecSalesLine.Validate("Unit Price", RecINS.FREIGHT);
            RecSalesLine.Validate("Amount Including VAT", RecINS.FREIGHT);
            RecSalesLine.Insert(True);
        end;
        PayAccNo := '';
        if RecINS.SHIPAGENT = 'UPS' then begin
            PayAccNo := 'UPSACCT';
        end
        else if RecINS.SHIPAGENT = 'FEDEX' then begin
            PayAccNo := 'FEDEXACCT';
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
