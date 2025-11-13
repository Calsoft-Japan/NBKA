report 50109 "CertificateofConformanceReport"
{
    Caption = 'Certificate of Conformance Report NBK';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/CertificateofConformanceReport.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            PrintOnlyIfDetail = true;

            column(PostingDate; "Posting Date")
            {
            }
            column(SellToCustomerName; "Sell-to Customer Name")
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where(Type = const(Item), "Certificate of Conformance" = const(true));

                column(ItemDescription; Description)
                {
                }
                column(QuantityWithUOM; Format(Quantity) + ' ' + "Unit of Measure")
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(LineNo; "Line No.")
                {
                }
                column(CompanyAddressLbl; AddressLbl)
                {
                }
                column(CompanyAddress1; AddressVal1)
                {
                }
                column(CompanyAddress2; AddressVal2)
                {
                }
                column(CompanyPhoneLbl; PhoneLbl)
                {
                }
                column(CompanyPhone; PhoneVal)
                {
                }
                column(CompanyEmailLbl; EmailLbl)
                {
                }
                column(CompanyEmail; EmailVal)
                {
                }
                column(CertificateTitleLbl; CertificateTitle)
                {
                }
                column(CertificateText; CertificateBody)
                {
                }
                column(CustomerNameLbl; CustomerNameLbl)
                {
                }
                column(CustomerPOLbl; CustomerPOLbl)
                {
                }
                column(CustomerPartLbl; CustomerPartLbl)
                {
                }
                column(ItemReferenceNo; "Item Reference No.")
                {
                }
                column(NBKPartLbl; NBKPartLbl)
                {
                }
                column(QuantityLbl; QuantityLbl)
                {
                }
                column(Colan; Colan)
                {
                }
                column(ShiptoPONo; "Ship-to PO No.")
                {
                }
                // Custom Fields from Company Information
                column(COCSignerName; CompanyInfo."COC Signer Name")
                {
                }
                column(COCSignerTitle; CompanyInfo."COC Signer Title")
                {
                }
                column(COCSignerDept; CompanyInfo."COC Signer Dept.")
                {
                }
                column(COCSignerCompany; CompanyInfo."COC Signer Company")
                {
                }
                column(COCSignerSignature; CompanyInfo."COC Signer Signature")
                {
                }
                trigger OnPreDataItem()
                begin
                    if LineNo <> '' then
                        "Sales Shipment Line".SetFilter("Line No.", LineNo);
                    "Sales Shipment Line".SetFilter(Quantity, '<>%1', 0);

                end;
            }
            trigger OnPreDataItem()
            begin
                if SalesShipmentNo <> '' then
                    "Sales Shipment Header".SetFilter("No.", SalesShipmentNo);
            end;
        }
    }
    requestpage
    {
        // SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(SalesShipmentNo; SalesShipmentNo)
                    {
                        Caption = 'Shipment No.';
                        ApplicationArea = all;
                    }
                    field(LineNo; LineNo)
                    {
                        Caption = 'Line No.';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        AddressLbl: Label 'Address:';
        AddressVal1: Label '1, Toko-Taichi, Seki City,';
        AddressVal2: Label 'Gifu 501-3939, Japan';
        PhoneLbl: Label 'Phone:';
        PhoneVal: Label '+81-575-23-1121';
        EmailLbl: Label 'E-mail:';
        EmailVal: Label 'info@nbk1560.com';
        CertificateTitle: Label 'Certificate of Conformance';
        CertificateBody: Label 'We hereby certify that the parts mentioned below have been manufactured by Nabeya Bi-tech Kaisha (NBK) in conformance with our engineering and quality standards .These parts are also in accordance with the requesting customer''s purchase order number and part number.';
        CustomerNameLbl: Label 'Customer Name ';
        CustomerPOLbl: Label 'Customer PO# ';
        NBKPartLbl: Label 'NBK Part# ';
        QuantityLbl: Label 'Quantity ';
        Colan: Label ':';
        SalesShipmentNo: Code[20];
        LineNo: Text;
        CustomerPartLbl: Label 'Customer Part#';

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields("COC Signer Signature")
    end;

    procedure SetFilters(No: code[20]; lineNovar: Text)
    begin
        SalesShipmentNo := No;
        LineNo := lineNovar;
    end;
}
