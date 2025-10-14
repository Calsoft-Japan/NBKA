namespace NBKA.NBKA;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Setup;

tableextension 50007 shiptoAddressExt extends "Ship-to Address"
{
    fields
    {
        modify(Code)
        {
            trigger OnAfterValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "No. Series";
            begin
                if "Code" <> xRec."Code" then begin
                    SalesSetup.Get();
                    SalesSetup.TestField("Ship-to address No.");
                    NoSeriesMgt.TestManual(SalesSetup."Ship-to address No.");
                    "No. Series" := '';
                end;
            end;


        }
        field(50000; "No. Series"; Code[20])
        {

        }
    }
    fieldgroups
    {
        addlast(DropDown; "Shipping Agent Code", "Shipping Agent Service Code")
        {

        }

    }
    trigger OnInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if Code = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Ship-to address No.");
            "No. Series" := SalesSetup."Ship-to address No.";
            if NoSeries.AreRelated(SalesSetup."Ship-to address No.", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            Rec.Code := NoSeries.GetNextNo("No. Series");
        end;
    end;

    procedure AssistEdit(Oldshiptoaddressrec: Record "Ship-to Address"): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        shiptoaddressrec: Record "Ship-to Address";
    begin
        shiptoaddressrec := Rec;
        SalesSetup.Get();
        SalesSetup.TestField("Ship-to address No.");
        if NoSeries.LookupRelatedNoSeries(SalesSetup."Ship-to address No.", Oldshiptoaddressrec."No. Series", shiptoaddressrec."No. Series") then begin
            shiptoaddressrec.Code := NoSeries.GetNextNo(shiptoaddressrec."No. Series");
            Rec := shiptoaddressrec;
            exit(true);
        end;
    end;

}
