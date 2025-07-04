// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Sales.History;

using Microsoft.Assembly.History;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Segment;
using Microsoft.Inventory.Item;
using Microsoft.CRM.Team;
using Microsoft.Finance.SalesTax;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Shipping;
using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Location;
using Microsoft.Sales.Comment;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Utilities;
using System.Globalization;
using System.Utilities;

report 50104 "Sales Shipment"
{
    RDLCLayout = './ReportLayout/SalesShipmentNew.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Sales Shipment(Report) - NBK';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Shipment';
            column(No_SalesShptHeader; "No.")
            {
            }

            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = field("Document No."), "Document Line No." = field("Line No.");
                    DataItemTableView = sorting("Document Type", "No.", "Document Line No.", "Line No.") where("Document Type" = const(Shipment), "Print On Shipment" = const(true));

                    trigger OnAfterGetRecord()
                    begin
                        InsertTempLine(Comment, 10);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine := "Sales Shipment Line";
                    TempSalesShipmentLine.Insert();
                    TempSalesShipmentLineAsm := "Sales Shipment Line";
                    TempSalesShipmentLineAsm.Insert();
                    HighestLineNo := "Line No.";
                    Clear(ItemRec);
                    if ItemRec.Get("Sales Shipment Line"."No.") then;
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesShipmentLine.Reset();
                    TempSalesShipmentLine.DeleteAll();
                    TempSalesShipmentLineAsm.Reset();
                    TempSalesShipmentLineAsm.DeleteAll();
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Document Type", "No.", "Document Line No.", "Line No.") where("Document Type" = const(Shipment), "Print On Shipment" = const(true), "Document Line No." = const(0));

                trigger OnAfterGetRecord()
                begin
                    InsertTempLine(Comment, 1000);
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesShipmentLine.Init();
                    TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                    TempSalesShipmentLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesShipmentLine."Line No.";
                    TempSalesShipmentLine.Insert();
                end;
            }

            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyAddress1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress1; BillToAddress[1])
                    {
                    }
                    column(BillToAddress2; BillToAddress[2])
                    {
                    }
                    column(BillToAddress3; BillToAddress[3])
                    {
                    }
                    column(BillToAddress4; BillToAddress[4])
                    {
                    }
                    column(BillToAddress5; BillToAddress[5])
                    {
                    }
                    column(BillToAddress6; BillToAddress[6])
                    {
                    }
                    column(BillToAddress7; BillToAddress[7])
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                    {
                    }
                    column(ExtDocNo_SalesShptHeader; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ShptDate_SalesShptHeader; "Sales Shipment Header"."Shipment Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
                    {
                    }

                    column(OrderDate_SalesShptHeader; "Sales Shipment Header"."Order Date")
                    {
                    }
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(PackageTrackingNoText; PackageTrackingNoText)
                    {
                    }
                    column(ShippingAgentCodeText; ShippingAgentCodeText)
                    {
                    }
                    column(ShippingAgentCodeLabel; ShippingAgentCodeLabel)
                    {
                    }
                    column(PackageTrackingNoLabel; PackageTrackingNoLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(PageLoopNumber; Number)
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(ShipmentNumberCaption; ShipmentNumberCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(OurOrderNoCaption; OurOrderNoCaptionLbl)
                    {
                    }
                    column(packingsliplbl; packingsliplbl)
                    {
                    }
                    column(YourPurchaseOrderNolbl; YourPurchaseOrderNolbl)
                    {
                    }
                    column(ShptMethodDescLbl; ShptMethodDescLbl)
                    {
                    }
                    column(ShippingAgentLbl; ShippingAgentLbl)
                    {
                    }
                    column(ShippingAgentServiceLbl; ShippingAgentServiceLbl)
                    {
                    }
                    column(ShippingAgent_Name; ShippingAgent.Name)
                    {
                    }
                    column(ShippingAgentService_Description; ShippingAgentService.Description)
                    {
                    }
                    column(PackageTrackingNoLbl; PackageTrackingNoLbl)
                    {
                    }
                    column(Countryoforiginlbl; Countryoforiginlbl)
                    {
                    }
                    column(RemarlLbl; RemarlLbl)
                    {
                    }
                    column(ShipToAddress_Lbl; ShiptoAddrLbl)
                    {
                    }
                    column(ShipmentNolbl; ShipmentNolbl)
                    {
                    }
                    column(Shipmentdate_salesspmtheader; "Sales Shipment Header"."Shipment Date")
                    {
                    }
                    column(PkgTrackingNo_salesspmtheader; "Sales Shipment Header"."Package Tracking No.")
                    {
                    }
                    column(WorkDes_salesspmtheader; GetWorkDescription())
                    {
                    }
                    column(CompanyPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
                    {
                    }
                    column(CompanyEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(EMail_Lbl; EMailLbl)
                    {
                    }
                    dataitem(SalesShptLine; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(SalesShptLineNumber; Number)
                        {
                        }
                        column(TempSalesShptLineNo; TempSalesShipmentLine."Line No.")
                        {
                        }
                        column(TempSalesShptLineUOM; TempSalesShipmentLine."Unit of Measure")
                        {
                        }
                        column(TempSalesShptLineQy; TempSalesShipmentLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(BackOrderedQuantity; BackOrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesShptLineDesc; TempSalesShipmentLine.Description + ' ' + TempSalesShipmentLine."Description 2")
                        {
                        }
                        column(PackageTrackingText; PackageTrackingText)
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(ShippedCaption; ShippedCaptionLbl)
                        {
                        }
                        column(OrderedCaption; OrderedCaptionLbl)
                        {
                        }
                        column(BackOrderedCaption; BackOrderedCaptionLbl)
                        {
                        }
                        column(NBKProductNolbl; NBKProductNolbl)
                        {
                        }
                        column(CustomerProductNolbl; CustomerProductNolbl)
                        {
                        }
                        column(HtsCodelbl; HtsCodelbl)
                        {
                        }
                        column(ShippedQtylbl; ShippedQtylbl)
                        {
                        }
                        column(UnitWeightlbl; UnitWeightlbl)
                        {
                        }
                        column(Grossweightlbl; Grossweightlbl)
                        {
                        }
                        column(Description_ShptLine; "Sales Shipment Line".Description)
                        {
                        }
                        column(Item_PN; ItemRec."P/N")
                        {
                        }
                        column(ItemRefNo_ShptLine; "Sales Shipment Line"."Item Reference No.")
                        {
                        }
                        column(Item_Netweight; ItemRec."Net Weight")
                        {
                        }
                        column(Item_TarrifNo; ItemRec."Tariff No.")
                        {
                        }

                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = sorting(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent() + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent() + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    PostedAsmLine.FindSet()
                                else
                                    PostedAsmLine.Next();
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not DisplayAssemblyInformation then
                                    CurrReport.Break();
                                if not AsmHeaderExists then
                                    CurrReport.Break();
                                if not TempSalesShipmentLineAsm.Get(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.") then
                                    CurrReport.Break();
                                PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                                SetRange(Number, 1, PostedAsmLine.Count);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            SalesShipmentLine: Record "Sales Shipment Line";
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            if OnLineNumber = 1 then
                                TempSalesShipmentLine.Find('-')
                            else
                                TempSalesShipmentLine.Next();

                            OrderedQuantity := 0;
                            BackOrderedQuantity := 0;
                            if TempSalesShipmentLine."Order No." = '' then
                                OrderedQuantity := TempSalesShipmentLine.Quantity
                            else
                                if OrderLine.Get(1, TempSalesShipmentLine."Order No.", TempSalesShipmentLine."Order Line No.") then begin
                                    OrderedQuantity := OrderLine.Quantity;
                                    BackOrderedQuantity := OrderLine."Outstanding Quantity";
                                end else begin
                                    ReceiptLine.SetCurrentKey("Order No.", "Order Line No.");
                                    ReceiptLine.SetRange("Order No.", TempSalesShipmentLine."Order No.");
                                    ReceiptLine.SetRange("Order Line No.", TempSalesShipmentLine."Order Line No.");
                                    ReceiptLine.Find('-');
                                    repeat
                                        OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                                    until 0 = ReceiptLine.Next();
                                end;

                            if TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::" " then begin
                                OrderedQuantity := 0;
                                BackOrderedQuantity := 0;
                                TempSalesShipmentLine."No." := '';
                                TempSalesShipmentLine."Unit of Measure" := '';
                                TempSalesShipmentLine.Quantity := 0;
                            end else
                                if TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::"G/L Account" then
                                    TempSalesShipmentLine."No." := '';

                            PackageTrackingText := '';
                            if (TempSalesShipmentLine."Package Tracking No." <> "Sales Shipment Header"."Package Tracking No.") and
                               (TempSalesShipmentLine."Package Tracking No." <> '') and PrintPackageTrackingNos
                            then
                                PackageTrackingText := Text002 + ' ' + TempSalesShipmentLine."Package Tracking No.";

                            if DisplayAssemblyInformation then
                                if TempSalesShipmentLineAsm.Get(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.") then begin
                                    SalesShipmentLine.Get(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.");
                                    AsmHeaderExists := SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader);
                                end;

                            if OnLineNumber = NumberOfLines then
                                PrintFooter := true;
                        end;

                        trigger OnPreDataItem()
                        begin
                            NumberOfLines := TempSalesShipmentLine.Count();
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then
                            SalesShipmentPrinted.Run("Sales Shipment Header");
                        CurrReport.Break();
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if PrintCompany then
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault("Format Region");
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");

                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");

                if "Sell-to Customer No." = '' then begin
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                if not Cust.Get("Sell-to Customer No.") then
                    Clear(Cust);
                FormatAddress.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddress);
                FormatAddress.SalesShptBillTo(BillToAddress, BillToAddress, "Sales Shipment Header");
                FormatAddress.SalesShptShipTo(ShipToAddress, "Sales Shipment Header");

                ShippingAgentCodeLabel := '';
                ShippingAgentCodeText := '';
                PackageTrackingNoLabel := '';
                PackageTrackingNoText := '';
                if PrintPackageTrackingNos then begin
                    ShippingAgentCodeLabel := Text003;
                    ShippingAgentCodeText := "Sales Shipment Header"."Shipping Agent Code";
                    PackageTrackingNoLabel := Text001;
                    PackageTrackingNoText := "Sales Shipment Header"."Package Tracking No.";
                end;
                if LogInteraction then
                    if not CurrReport.Preview then
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.",
                          "Salesperson Code", "Campaign No.", "Posting Description", '');
                TaxRegNo := '';
                TaxRegLabel := '';
                if ShippingAgent.Get("Sales Shipment Header"."Shipping Agent Code") then;
                if ShippingAgentService.Get("Sales Shipment Header"."Shipping Agent Code", "Sales Shipment Header"."Shipping Agent Service Code") then;
                if "Tax Area Code" <> '' then begin
                    TaxArea.Get("Tax Area Code");
                    case TaxArea."Country/Region" of
                        TaxArea."Country/Region"::US:
                            ;
                        TaxArea."Country/Region"::CA:
                            begin
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FieldCaption("VAT Registration No.");
                            end;
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Number of Copies';
                        ToolTip = 'Specifies the number of copies of each document (in addition to the original) that you want to print.';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Company Address';
                        ToolTip = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.';
                    }
                    field(PrintPackageTrackingNos; PrintPackageTrackingNos)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Package Tracking Nos.';
                        ToolTip = 'Specifies if you want the individual package tracking numbers to be printed on each line.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies that you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        SalesSetup.Get();

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.Get();
                    CompanyInfo3.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get();
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get();
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then
            InitLogInteraction();

        CompanyInformation.Get();
        SalesSetup.Get();

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                CompanyInformation.CalcFields(Picture);
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get();
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get();
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;

        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
    end;

    var
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        ShipmentMethod: Record "Shipment Method";
        ReceiptLine: Record "Sales Shipment Line";
        OrderLine: Record "Sales Line";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesShipmentLine: Record "Sales Shipment Line" temporary;
        TempSalesShipmentLineAsm: Record "Sales Shipment Line" temporary;
        RespCenter: Record "Responsibility Center";
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        LanguageMgt: Codeunit Language;
        SalesShipmentPrinted: Codeunit "Sales Shpt.-Printed";
        FormatAddress: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        CompanyAddress: array[8] of Text[100];
        BillToAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        CopyTxt: Text;
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        PackageTrackingText: Text;
        PrintPackageTrackingNos: Boolean;
        PackageTrackingNoText: Text;
        PackageTrackingNoLabel: Text;
        ShippingAgentCodeText: Text;
        ShippingAgentCodeLabel: Text;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text001: Label 'Tracking No.';
        Text002: Label 'Specific Tracking No.';
        Text003: Label 'Shipping Agent';
        TaxRegNo: Text;
        TaxRegLabel: Text;
        Text009: Label 'VOID SHIPMENT';
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        BillCaptionLbl: Label 'Bill';
        ToCaptionLbl: Label 'To:';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        ShipmentCaptionLbl: Label 'SHIPMENT';
        ShipmentNumberCaptionLbl: Label 'Shipment No:';
        ShipmentDateCaptionLbl: Label 'Shipment Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        ShippedCaptionLbl: Label 'Shipped';
        OrderedCaptionLbl: Label 'Ordered';
        BackOrderedCaptionLbl: Label 'Back Ordered';
        packingsliplbl: Label 'Packing Slip';
        EMailLbl: Label 'Email';

        YourPurchaseOrderNolbl: Label 'Your Purchase Order No.:';
        ShptMethodDescLbl: Label 'Shipment Method:';
        ShippingAgentLbl: Label 'Shipping Agent:';
        ShippingAgentServiceLbl: Label 'Shipping Agent Service:';
        PackageTrackingNoLbl: Label 'Package Tracking No.:';
        Countryoforiginlbl: Label 'Country of Origin:';
        RemarlLbl: Label 'Remark:';
        NBKProductNolbl: Label 'NBK Product No.';
        CustomerProductNolbl: Label 'Customer Product No.';
        HtsCodelbl: Label 'HTS Code';
        ShippedQtylbl: Label 'Shipped Quantity';
        UnitWeightlbl: Label 'Unit weight (lbs)';
        Grossweightlbl: Label 'Gross weight (lbs)';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShipmentNolbl: Label 'Shipment No.';
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentService: Record "Shipping Agent Services";
        ItemRec: Record Item;
        CompanyInfoPhoneNoLbl: Label 'Phone No.:';
        WorkDes: Text;
        InStr: InStream;
        WorkDescriptionLine: Text;
        WorkDescriptionInstream: InStream;

    protected var
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Shpt. Note") <> '';
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PadStr('', 2, ' '));
    end;

    local procedure InsertTempLine(Comment: Text[80]; IncrNo: Integer)
    begin
        TempSalesShipmentLine.Init();
        TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
        TempSalesShipmentLine."Line No." := HighestLineNo + IncrNo;
        HighestLineNo := TempSalesShipmentLine."Line No.";
        FormatDocument.ParseComment(Comment, TempSalesShipmentLine.Description, TempSalesShipmentLine."Description 2");
        TempSalesShipmentLine.Insert();
    end;

    procedure GetWorkDescription() WorkDescription: Text
    var
        InStreamL: InStream;
    begin
        Clear(WorkDescription);
        "Sales Shipment Header".Calcfields("Sales Shipment Header"."Work Description");
        If "Sales Shipment Header"."Work Description".HasValue() then begin
            "Sales Shipment Header"."Work Description".CreateInStream(InStreamL);
            InStreamL.Read(WorkDescription);
        end;
    end;
}

