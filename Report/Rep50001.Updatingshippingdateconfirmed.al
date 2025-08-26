namespace NBKA.NBKA;

using Microsoft.Sales.Document;
using System.Utilities;

report 50001 "Update Shipping Date Confirmed"
{
    Caption = 'Update Shipping Date Confirmed';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = tasks;

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            var
                SalesLine: Record "Sales Line";
                AllFilled: Boolean;
                salesheader: Record "Sales Header";
            begin
                salesheader.reset;
                if salesheader.FindSet then
                    repeat

                        AllFilled := true;

                        SalesLine.SetRange("Document Type", salesheader."Document Type");
                        SalesLine.SetRange("Document No.", salesheader."No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        if SalesLine.FindSet() then begin
                            repeat
                                if SalesLine."Shipping Date" = 0D then begin
                                    AllFilled := false;
                                end;
                            until (SalesLine.Next() = 0) or (not AllFilled);
                        end else
                            AllFilled := false;
                        SalesHeader.Validate("Shipping Date Confirmed", AllFilled);
                        if salesheader."No." <> '' then
                            SalesHeader.Modify();
                    until salesheader.Next() = 0;

            end;

        }
    }

}
