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
            column(DocumentNo; "No.")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = CONST(Item));

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
                column(NBKPartLbl; NBKPartLbl)
                {
                }
                column(QuantityLbl; QuantityLbl)
                {
                }
                column(Colan; Colan)
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
                trigger OnAfterGetRecord()
                var
                    SalesLine: Record "Sales Line";
                begin
                    if SalesLine.Get(SalesLine."Document Type"::Order, "Sales Shipment Line"."Order No.", "Sales Shipment Line"."Order Line No.") and
                    not SalesLine."Certificate of Conformance" then
                        CurrReport.Skip();
                end;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields("COC Signer Signature")
    end;
}
