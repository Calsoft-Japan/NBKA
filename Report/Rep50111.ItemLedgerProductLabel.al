namespace NBKA.NBKA;

using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.Company;

report 50112 ItemLedgerProductLabel
{
    ApplicationArea = All;
    Caption = 'ItemLedgerProductLabel';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/ItemLedgerProductLabelNew.rdl';
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(ItemNo; "Item No.")
            {
            }
            column(Item_Description; "Item Description")
            {
            }
            column(Item_RemainingQuantity; "Remaining Quantity")
            {
            }
            column(Item_Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(CompanyInfo_pic; CompanyInfo.Picture)
            {
            }
            column(fldBarcode; trecBarcode.Picture)
            {
            }
            column(BarcodeTxt; BarcodeTxt)
            {
            }
            column(Entry_No_; "Entry No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Item Description");
                Clear(trecBarcode);
                Clear(BarcodeTxt);
                BarcodeTxt := "Item No." + '_' + Format("Remaining Quantity");

                cuWHICommon.Create2DBarcode(trecBarcode, BarcodeTxt, recWHISetup."Barcode Dot Size", recWHISetup."Barcode Margin Size", recWHISetup."Barcode Image Size");
            end;

            trigger OnPreDataItem()
            begin
                if EntryNoFilter <> '' then begin
                    ItemLedgerEntry.SetFilter("Entry No.", EntryNoFilter);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(EntryNoFilter; EntryNoFilter)
                    {
                        ApplicationArea = all;
                        Caption = 'Entry No.';
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
    end;

    trigger OnInitReport()
    Begin
        recWHISetup.Get();
    End;

    procedure setfilters(Entryno: Text)
    begin
        EntryNoFilter := Entryno;
    end;

    var
        CompanyInfo: Record "Company Information";
        trecBarcode: Record "Company Information" temporary;
        cuWHICommon: Codeunit "WHI Common Functions";
        BarcodeTxt: Text;
        recWHISetup: Record "WHI Setup";
        EntryNoFilter: Text;
}
