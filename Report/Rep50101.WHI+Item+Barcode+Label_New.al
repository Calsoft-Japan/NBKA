// ************************
// Copyright Notice
// This objects content is copyright of Insight Works 2011.  All rights reserved.
// Any redistribution or reproduction of part or all of the contents in any form is prohibited.
// ************************

/// <summary>
/// Report WHI Item Barcode Label (ID 23044900).
/// </summary>
report 50101 "WHI Item Barcode Label New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/WHIItemBarcodeLabelNew.rdl';

    ApplicationArea = All;
    Caption = 'Warehouse Insight Item Barcode Label';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(diItem; Item)
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(diItem_No_; "No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                trecItems := diItem;
#pragma warning disable AA0217
                trecItems."No." := StrSubstNo('t_%1', iCount);    // unique counter
#pragma warning restore AA0217
                trecItems."No. 2" := diItem."No.";
                trecItems."Lot No. Filter" := codTrackingNumber;    // lot or serial number
                trecItems."Last Date Modified" := dtExpiryDate;

                if (dQuantity = 0) then begin
                    bIncludeQty := false;
                    trecItems."Unit Price" := 0;    // label quantity
                    trecItems."Base Unit of Measure" := ''; // label quantity uom
                end else begin
                    bIncludeQty := true;
                    trecItems."Unit Price" := dQuantity;    // label quantity
                    trecItems."Base Unit of Measure" := codUOM; // label quantity uom
                end;

                trecItems.Insert();
                iCount := iCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                if diItemLedgerEntry.GetFilters() <> '' then
                    CurrReport.Break();
            end;
        }
        dataitem(diItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Lot No.", "Serial No.") ORDER(Ascending) WHERE(Open = CONST(true));
            RequestFilterFields = "Item No.", "Serial No.", "Lot No.";

            trigger OnAfterGetRecord()
            var
                lrecItem: Record Item;
            begin
                lrecItem.Get("Item No.");
                trecItems.Init();
                trecItems := lrecItem;
#pragma warning disable AA0217
                trecItems."No." := StrSubstNo('t_%1', iCount); // unique counter
#pragma warning restore AA0217
                trecItems."No. 2" := lrecItem."No.";
                trecItems."Lot No. Filter" := '';  // clear the lot/serial number
                trecItems."Unit Price" := 0;    // label quantity
                trecItems."Base Unit of Measure" := ''; // label quantity uom
                trecItems."Last Date Modified" := "Expiration Date";

                if ("Serial No." <> '') then
                    trecItems."Lot No. Filter" := "Serial No."
                else
                    if ("Lot No." <> '') then
                        trecItems."Lot No. Filter" := "Lot No.";

                if (bIncludeQty) then begin
                    trecItems."Unit Price" := "Remaining Quantity";
                    trecItems."Base Unit of Measure" := "Unit of Measure Code";
                end;

                trecItems.Insert();
                iCount := iCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                if GetFilters() = '' then
                    CurrReport.Break();
            end;
        }
        dataitem(diLabels; "Integer")
        {
            DataItemTableView = SORTING(Number);
            dataitem(diNumCopies; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(trecItems_No; trecItems."No. 2")
                {
                }
                column(trecItems_Description; trecItems.Description + ' ' + trecItems."Description 2")
                {
                }
                column(trecItems_Routing; trecItems."Lot No. Filter")
                {
                }
                column(fldBarcode; trecBarcode.Picture)
                {
                }
                column(fldLotSerialBarcode; trecLotSerialBarcode.Picture)
                {
                }
                column(diNumCopies_Number; Number)
                {
                }
                column(fldQuantity; trecItems."Unit Price")
                {
                }
                column(fldUnitOfMeasure; trecItems."Base Unit of Measure")
                {
                }
                column(fldIncludeQty; bIncludeQty)
                {
                }
                column(fldExpiryDate; sExpiryDate)
                {
                }


                trigger OnAfterGetRecord()
                var

                begin
                    Clear(trecBarcode);
                    Clear(trecLotSerialBarcode);

                    cuWHICommon.Create2DBarcode(trecBarcode, trecItems."No. 2", recWHISetup."Barcode Dot Size", recWHISetup."Barcode Margin Size", recWHISetup."Barcode Image Size");

                    sExpiryDate := '';
                    if trecItems."Last Date Modified" <> 0D then
                        sExpiryDate := Format(trecItems."Last Date Modified");

                    if (trecItems."Lot No. Filter" <> '') then
                        cuWHICommon.Create2DBarcode(trecLotSerialBarcode, trecItems."Lot No. Filter", recWHISetup."Barcode Dot Size", recWHISetup."Barcode Margin Size", recWHISetup."Barcode Image Size");
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, iNumCopies);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Number <> 1 then
                    trecItems.Next();
            end;

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, trecItems.Count());
                if trecItems.Find('-') then;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(fldNumCopies; iNumCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Number of Copies';
                        ToolTip = 'The number of copies of the label to print';
                    }
                    field(fldIncludeQty; bIncludeQty)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Quantity';
                        ToolTip = 'Specifies if the item label will display a quantity value. This setting only applies when using the Item Ledger Entry filter, and will display the "Remaining Quantity" from the ledger entry.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        lblQuantity = 'Quantity';
        lblTrackingNumber = 'Tracking Number:';
        lblExpiratonDate = 'Expiration Date';
    }

    trigger OnInitReport()
    begin
        iNumCopies := 1;
        iCount := 0;
        dQuantity := 0;
        codTrackingNumber := '';
        dtExpiryDate := 0D;

        recWHISetup.Get();


        // Item Format //
        // No. = Unique identifier (t_0, t_1, etc)
        // No. 2 = Item number
        // Lot No. Filter = Lot / Serial number
        // Unit Price = Quantity
        // Base Unit of Measure = Quantity Unit of Measure
        // Last Date Modified = Expiration Date
    end;

    trigger OnPreReport()
    begin
        if (diItem.GetFilters() <> '') and (diItemLedgerEntry.GetFilters() <> '') then
            Error(tcOnlyOneFilterErr);

        if not GuiAllowed() then begin
            // get quantity from receiving
            bIncludeQty := cuSessionHelper.GetValueAsBool('label_include_qty');
            dQuantity := cuSessionHelper.GetValueAsDecimal('label_quantity');
            iNumCopies := cuSessionHelper.GetValueAsInt('label_numcopies');
            if iNumCopies < 1 then
                iNumCopies := 1;
            codUOM := CopyStr(cuSessionHelper.GetExtendedValue('label_uom'), 1, MaxStrLen(codUOM));
            codTrackingNumber := CopyStr(cuSessionHelper.GetExtendedValue('label_tracking_number'), 1, MaxStrLen(codTrackingNumber));
            dtExpiryDate := cuSessionHelper.GetValueAsDate('label_expiry_date');

            // for reference or extension needs
            //codVariantCode := cuSessionHelper.GetExtendedValue('label_variant_code');
            //codItemNumber := cuSessionHelper.GetExtendedValue('label_item_number');
            //liEntryNo := cuSessionHelper.GetExtendedValue('label_ledger_entry_number');
        end;

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    /// <summary>
    /// Allow setting of report variables prior to report execution.
    /// </summary>
    /// <param name="pbIncludeQty"></param>
    /// <param name="piNumCopies"></param>
    /// <param name="pdQuantity"></param>
    /// <param name="pcodUOM"></param>
    /// <param name="pcodTrackingNumber"></param>
    /// <param name="pdtExpiryDate"></param>
    procedure initReport(pbIncludeQty: Boolean; piNumCopies: Integer; pdQuantity: Decimal; pcodUOM: Code[10]; pcodTrackingNumber: Code[50]; pdtExpiryDate: Date)
    begin
        bIncludeQty := pbIncludeQty;
        iNumCopies := piNumCopies;
        dQuantity := pdQuantity;
        codUOM := pcodUOM;
        codTrackingNumber := pcodTrackingNumber;
        dtExpiryDate := pdtExpiryDate;
    end;

    var
        CompanyInfo: Record "Company Information";
        trecItems: Record Item temporary;
        recWHISetup: Record "WHI Setup";
        trecBarcode: Record "Company Information" temporary;
        trecLotSerialBarcode: Record "Company Information" temporary;
        cuWHICommon: Codeunit "WHI Common Functions";
        cuSessionHelper: Codeunit "WHI Session Helper";
        iNumCopies: Integer;
        iCount: Integer;
#if V22_OR_LOWER
        [InDataSet]
#endif
        bIncludeQty: Boolean;
        tcOnlyOneFilterErr: Label 'You can only specify one report filter.';
        dQuantity: Decimal;
        codUOM: Code[10];
        codTrackingNumber: Code[50];
        dtExpiryDate: Date;
        sExpiryDate: Text;



}

