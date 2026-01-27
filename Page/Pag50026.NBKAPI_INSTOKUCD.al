//FDD301 page for the NBKAPI INSTOKUCD.
page 50026 "NBKAPI_INSTOKUCD"
{
    ApplicationArea = All;
    Caption = 'NBKAPI_INSTOKUCD';
    PageType = API;
    APIPublisher = 'CalsoftSystems';
    APIGroup = 'NBKAPI';
    APIVersion = 'v2.0';
    EntitySetCaption = 'NBKAPI_INSTOKUCD';
    EntitySetName = 'NBKAPI_INSTOKUCD';
    EntityCaption = 'NBKAPI_INSTOKUCD';
    EntityName = 'NBKAPI_INSTOKUCD';
    ODataKeyFields = "Entry No.";
    SourceTable = "NBKAPITBL_INSTOKUCD";
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
                field(TNAME; Rec.TNAME)
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
                field(TPOSTCODE; Rec.TPOSTCODE)
                {
                    ApplicationArea = All;
                }
                field(TTELNO; Rec.TTELNO)
                {
                    ApplicationArea = All;
                }
                field(EMAIL; Rec.EMAIL)
                {
                    ApplicationArea = All;
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                }
                field(TCONTACT; Rec.TCONTACT)
                {
                    ApplicationArea = All;
                }
                field(RESELLER; Rec.RESELLER)
                {
                    ApplicationArea = All;
                }
                field(USERCD; Rec.USERCD)
                {
                    ApplicationArea = All;
                }
                field(CustomerNo; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RecCustomer: Record Customer;
    begin
        Rec."Created datetime" := CurrentDateTime;
        if Rec."TNAME".Trim() <> '' then begin
            /*RecCustomer.Reset();
            RecCustomer.SetRange(Name, Rec.TNAME);
            if RecCustomer.IsEmpty then begin*/
            if InsertCustomer(Rec, RecCustomer) then begin
                Commit();
                RecCustomer.Reset();
                RecCustomer.SetRange(Name, Rec.TNAME);
                //if RecCustomer.FindFirst() then begin
                Rec."Customer No." := RecCustomer."No.";
                Rec.P_RTCD := '00';
                Rec.P_ERRCD := '';
                Rec.P_ERRMSG := '';
                //end
                /*else begin
                    Rec.P_RTCD := '99';
                    Rec.P_ERRCD := '04';
                    Rec.P_ERRMSG := 'Can''t find the insertted Customer.';
                end;*/
            end
            else begin
                Rec.P_RTCD := '99';
                Rec.P_ERRCD := 'NBKAPI_INSTOKUCD';
                Rec.P_ERRMSG := 'Insert Customer failed with error message: ' + GetLastErrorText();
            end;
            /*end
            else begin
                Rec.P_RTCD := '99';
                Rec.P_ERRCD := '02';
                Rec.P_ERRMSG := 'The customer with the same name is existed.';
            end;*/
        end else begin
            Rec.P_RTCD := '99';
            Rec.P_ERRCD := 'NBKAPI_INSTOKUCD';
            Rec.P_ERRMSG := 'TNAME must not be blank.';
        end;
        if Rec.Insert(true) then begin
            exit(false);
        end
        else begin
            exit(false);
        end;
    end;

    [TryFunction]
    local procedure InsertCustomer(var RecINSTOKUCD: Record NBKAPITBL_INSTOKUCD; var RecCustomer: Record Customer)
    var
        errorMsg: Text;
        RecCompanyInfo: Record "Company Information";
        RecTaxArea: Record "Tax Area";
        NoSeries: Codeunit "No. Series";
    begin
        RecCustomer.Init();
        RecCustomer.Validate("No.", NoSeries.GetNextNo('CUST-EC', Today));
        RecCustomer.Insert(true);

        RecCustomer.Validate(Name, RecINSTOKUCD.TNAME);
        RecCustomer.Validate(Address, RecINSTOKUCD.TADDRESS);
        RecCustomer.Validate("Address 2", RecINSTOKUCD.TADDRESS2);
        RecCustomer.Validate("Country/Region Code", RecINSTOKUCD.TCOUNTRY);
        RecCustomer.Validate(City, RecINSTOKUCD.TCITY);
        RecCustomer.Validate(County, RecINSTOKUCD.TSTATE);
        RecCustomer.Validate("Post Code", RecINSTOKUCD.TPOSTCODE);
        RecCustomer.Validate("Phone No.", RecINSTOKUCD.TTELNO);
        RecCustomer.Validate("E-Mail", RecINSTOKUCD.EMAIL);
        RecCustomer.Validate("Home Page", RecINSTOKUCD.URL);
        RecCustomer.Validate(Contact, RecINSTOKUCD.TCONTACT);
        RecCustomer.Validate("Payment Terms Code", 'ADVANCE');
        RecCustomer.Validate("Gen. Bus. Posting Group", 'DEFAULT');
        RecCustomer.Validate("Customer Posting Group", 'DEFAULT');
        RecCustomer.Validate("Location Code", 'NBKAM');
        RecCustomer.Validate("CDO Send Code", 'EMAIL');
        /*1/26/2015 Channing.Zhou Added based on FDD V1.4 Start*/
        RecCustomer.Validate("Customer Disc. Group", 'B2C');
        /*1/26/2015 Channing.Zhou Added based on FDD V1.4 End*/
        /*1/26/2015 Channing.Zhou Added based on FDD V1.5 Start*/
        RecCustomer.Validate("Combine Shipments", true);
        RecTaxArea.Reset();
        if RecTaxArea.Get(RecINSTOKUCD.TPOSTCODE) then begin
            RecCustomer.Validate("Tax Area Code", RecINSTOKUCD.TPOSTCODE);
        end;
        /*1/26/2015 Channing.Zhou Added based on FDD V1.5 End*/
        if (RecINSTOKUCD.TSTATE <> '') and (RecINSTOKUCD.RESELLER = '') and (RecCompanyInfo.FindFirst()) and (RecCompanyInfo.County = RecINSTOKUCD.TSTATE) then begin
            RecCustomer."Tax Liable" := true;
        end
        else begin
            RecCustomer."Tax Liable" := false;
        end;
        RecCustomer.Modify(true);
    end;
}
