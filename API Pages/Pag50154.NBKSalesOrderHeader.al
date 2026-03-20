namespace NBKA.NBKA;

using Microsoft.Sales.Document;

page 50154 NBK_SalesOrderHeader
{
    APIGroup = 'powerbipages';
    APIPublisher = 'nbk_calsoft';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'nbkSalesOrderHeader';
    DelayedInsert = true;
    EntityName = 'nbk_salesheader';
    EntitySetName = 'nbk_salesheader';
    PageType = API;
    SourceTable = "Sales Header";
    ODataKeyFields = "No.";
    SourceTableView = where("Document Type" = filter("Sales Document Type"::Order));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                }
                field(billToName; Rec."Bill-to Name")
                {
                    Caption = 'Bill-to Name';
                }
                field(billToName2; Rec."Bill-to Name 2")
                {
                    Caption = 'Bill-to Name 2';
                }
                field(billToAddress; Rec."Bill-to Address")
                {
                    Caption = 'Bill-to Address';
                }
                field(billToAddress2; Rec."Bill-to Address 2")
                {
                    Caption = 'Bill-to Address 2';
                }
                field(billToCity; Rec."Bill-to City")
                {
                    Caption = 'Bill-to City';
                }
                field(billToContact; Rec."Bill-to Contact")
                {
                    Caption = 'Bill-to Contact';
                }
                field(billToContactNo; Rec."Bill-to Contact No.")
                {
                    Caption = 'Bill-to Contact No.';
                }
                field(billToCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                    Caption = 'Bill-to Country/Region Code';
                }
                field(billToCounty; Rec."Bill-to County")
                {
                    Caption = 'Bill-to County';
                }
                field(billToCustomerTemplCode; Rec."Bill-to Customer Templ. Code")
                {
                    Caption = 'Bill-to Customer Template Code';
                }
                field(billToICPartnerCode; Rec."Bill-to IC Partner Code")
                {
                    Caption = 'Bill-to IC Partner Code';
                }
                field(billToPostCode; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.';
                }
                field(altGenBusPostingGroup; Rec."Alt. Gen. Bus Posting Group")
                {
                    Caption = 'Alternative Gen. Bus. Posting Group';
                }
                field(altVATBusPostingGroup; Rec."Alt. VAT Bus Posting Group")
                {
                    Caption = 'Alternative VAT Bus. Posting Group';
                }
                field(altVATRegistrationNo; Rec."Alt. VAT Registration No.")
                {
                    Caption = 'Alternative VAT Registration No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(amtShipNotInvLCY; Rec."Amt. Ship. Not Inv. (LCY)")
                {
                    Caption = 'Amount Shipped Not Invoiced (LCY) Incl. VAT';
                }
                field(amtShipNotInvLCYBase; Rec."Amt. Ship. Not Inv. (LCY) Base")
                {
                    Caption = 'Amount Shipped Not Invoiced (LCY)';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                }
                field(appliesToID; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                }
                field(approvalUser; Rec."Approval User")
                {
                    Caption = 'Approval User';
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                    Caption = 'Assigned User ID';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(cdoEmailsSent; Rec."CDO Emails Sent")
                {
                    Caption = 'No. of emails sent';
                }
                field(cdoHandled; Rec."CDO Handled")
                {
                    Caption = 'Handled (DO)';
                }
                field(cdoHandledTime; Rec."CDO Handled Time")
                {
                    Caption = 'Handled Time (DO)';
                }
                field(cdoNoPrinted; Rec."CDO No. Printed")
                {
                    Caption = 'No. printed (DO)';
                }
                field(cdoSendCode; Rec."CDO Send Code")
                {
                    Caption = 'Output Profile';
                }
                field(cfdiCertificateOfOriginNo; Rec."CFDI Certificate of Origin No.")
                {
                    Caption = 'CFDI Certificate of Origin No.';
                }
                field(cfdiExportCode; Rec."CFDI Export Code")
                {
                    Caption = 'CFDI Export Code';
                }
                field(cfdiPeriod; Rec."CFDI Period")
                {
                    Caption = 'CFDI Period';
                }
                field(cfdiPurpose; Rec."CFDI Purpose")
                {
                    Caption = 'CFDI Purpose';
                }
                field(cfdiRelation; Rec."CFDI Relation")
                {
                    Caption = 'CFDI Relation';
                }
                field(campaignNo; Rec."Campaign No.")
                {
                    Caption = 'Campaign No.';
                }
                field(combineShipments; Rec."Combine Shipments")
                {
                    Caption = 'Combine Shipments';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(companyBankAccountCode; Rec."Company Bank Account Code")
                {
                    Caption = 'Company Bank Account Code';
                }
                field(completelyShipped; Rec."Completely Shipped")
                {
                    Caption = 'Completely Shipped';
                }
                field(compressPrepayment; Rec."Compress Prepayment")
                {
                    Caption = 'Compress Prepayment';
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction';
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                    Caption = 'Coupled to Dynamics 365 Sales';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor';
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group';
                }
                field(customerPostingGroup; Rec."Customer Posting Group")
                {
                    Caption = 'Customer Posting Group';
                }
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(directDebitMandateID; Rec."Direct Debit Mandate ID")
                {
                    Caption = 'Direct Debit Mandate ID';
                }
                field(discountRateUpdated; Rec."Discount Rate Updated")
                {
                    Caption = 'Discount Rate Updated';
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
                {
                    Caption = 'Doc. No. Occurrence';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(ecOrder; Rec."EC Order")
                {
                    Caption = 'EC Order';
                }
                field(eu3PartyTrade; Rec."EU 3-Party Trade")
                {
                    Caption = 'EU 3-Party Trade';
                }
                field(estimatorRole; Rec."Estimator Role")
                {
                    Caption = 'Estimator Role';
                }
                field(exchangeRateUSD; Rec."Exchange Rate USD")
                {
                    Caption = 'Exchange Rate USD';
                }
                field(exitPoint; Rec."Exit Point")
                {
                    Caption = 'Exit Point';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(foreignTrade; Rec."Foreign Trade")
                {
                    Caption = 'Foreign Trade';
                }
                field(formatRegion; Rec."Format Region")
                {
                    Caption = 'Format Region';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(getShipmentUsed; Rec."Get Shipment Used")
                {
                    Caption = 'Get Shipment Used';
                }
                field(grossProfitRateUpdated; Rec."Gross Profit Rate Updated")
                {
                    Caption = 'Gross Profit Rate Updated';
                }
                field(grossProfitRateBelow60; Rec."Gross Profit Rate below 60")
                {
                    Caption = 'Gross Profit Rate < 60%';
                }
                field(icDirection; Rec."IC Direction")
                {
                    Caption = 'IC Direction';
                }
                field(icReferenceDocumentNo; Rec."IC Reference Document No.")
                {
                    Caption = 'IC Reference Document No.';
                }
                field(icStatus; Rec."IC Status")
                {
                    Caption = 'IC Status';
                }
                field(incomingDocumentEntryNo; Rec."Incoming Document Entry No.")
                {
                    Caption = 'Incoming Document Entry No.';
                }
                field(insurerName; Rec."Insurer Name")
                {
                    Caption = 'Insurer Name';
                }
                field(insurerPolicyNumber; Rec."Insurer Policy Number")
                {
                    Caption = 'Insurer Policy Number';
                }
                field(invoice; Rec.Invoice)
                {
                    Caption = 'Invoice';
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    Caption = 'Invoice Disc. Code';
                }
                field(invoiceDiscountAmount; Rec."Invoice Discount Amount")
                {
                    Caption = 'Invoice Discount Amount';
                }
                field(invoiceDiscountCalculation; Rec."Invoice Discount Calculation")
                {
                    Caption = 'Invoice Discount Calculation';
                }
                field(invoiceDiscountValue; Rec."Invoice Discount Value")
                {
                    Caption = 'Invoice Discount Value';
                }
                field(invoiceEmail; Rec."Invoice Email")
                {
                    Caption = 'Invoice Email';
                }
                field(isTest; Rec.IsTest)
                {
                    Caption = 'IsTest';
                }
                field(jobQueueEntryID; Rec."Job Queue Entry ID")
                {
                    Caption = 'Job Queue Entry ID';
                }
                field(jobQueueStatus; Rec."Job Queue Status")
                {
                    Caption = 'Job Queue Status';
                }
                field(journalTemplName; Rec."Journal Templ. Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(lastEmailSentMessageId; Rec."Last Email Sent Message Id")
                {
                    Caption = 'Last Email Sent Message Id';
                }
                field(lastEmailSentTime; Rec."Last Email Sent Time")
                {
                    Caption = 'Last Email Sent Time';
                }
                field(lastPostingNo; Rec."Last Posting No.")
                {
                    Caption = 'Last Posting No.';
                }
                field(lastPrepaymentNo; Rec."Last Prepayment No.")
                {
                    Caption = 'Last Prepayment No.';
                }
                field(lastPrepmtCrMemoNo; Rec."Last Prepmt. Cr. Memo No.")
                {
                    Caption = 'Last Prepmt. Cr. Memo No.';
                }
                field(lastReturnReceiptNo; Rec."Last Return Receipt No.")
                {
                    Caption = 'Last Return Receipt No.';
                }
                field(lastShipmentDate; Rec."Last Shipment Date")
                {
                    Caption = 'Last Shipment Date';
                }
                field(lastShippingNo; Rec."Last Shipping No.")
                {
                    Caption = 'Last Shipping No.';
                }
                field(lateOrderShipping; Rec."Late Order Shipping")
                {
                    Caption = 'Late Order Shipping';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(medicalInsPolicyNumber; Rec."Medical Ins. Policy Number")
                {
                    Caption = 'Medical Ins. Policy Number';
                }
                field(medicalInsurerName; Rec."Medical Insurer Name")
                {
                    Caption = 'Medical Insurer Name';
                }
                field(noPrinted; Rec."No. Printed")
                {
                    Caption = 'No. Printed';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(noOfArchivedVersions; Rec."No. of Archived Versions")
                {
                    Caption = 'No. of Archived Versions';
                }
                field(onHold; Rec."On Hold")
                {
                    Caption = 'On Hold';
                }
                field(opportunityNo; Rec."Opportunity No.")
                {
                    Caption = 'Opportunity No.';
                }
                field(orderClass; Rec."Order Class")
                {
                    Caption = 'Order Class';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(outboundWhseHandlingTime; Rec."Outbound Whse. Handling Time")
                {
                    Caption = 'Outbound Whse. Handling Time';
                }
                field(outstandingAmount; Rec."Outstanding Amount ($)")
                {
                    Caption = 'Outstanding Amount ($)';
                }
                field(packageTrackingNo; Rec."Package Tracking No.")
                {
                    Caption = 'Package Tracking No.';
                }
                field(paymentDiscount; Rec."Payment Discount %")
                {
                    Caption = 'Payment Discount %';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(paymentServiceSetID; Rec."Payment Service Set ID")
                {
                    Caption = 'Payment Service Set ID';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(postingDescription; Rec."Posting Description")
                {
                    Caption = 'Posting Description';
                }
                field(postingNo; Rec."Posting No.")
                {
                    Caption = 'Posting No.';
                }
                field(postingNoSeries; Rec."Posting No. Series")
                {
                    Caption = 'Posting No. Series';
                }
                field(postingFromWhseRef; Rec."Posting from Whse. Ref.")
                {
                    Caption = 'Posting from Whse. Ref.';
                }
                field(prepayment; Rec."Prepayment %")
                {
                    Caption = 'Prepayment %';
                }
                field(prepaymentDueDate; Rec."Prepayment Due Date")
                {
                    Caption = 'Prepayment Due Date';
                }
                field(prepaymentNo; Rec."Prepayment No.")
                {
                    Caption = 'Prepayment No.';
                }
                field(prepaymentNoSeries; Rec."Prepayment No. Series")
                {
                    Caption = 'Prepayment No. Series';
                }
                field(prepmtCrMemoNo; Rec."Prepmt. Cr. Memo No.")
                {
                    Caption = 'Prepmt. Cr. Memo No.';
                }
                field(prepmtCrMemoNoSeries; Rec."Prepmt. Cr. Memo No. Series")
                {
                    Caption = 'Prepmt. Cr. Memo No. Series';
                }
                field(prepmtIncludeTax; Rec."Prepmt. Include Tax")
                {
                    Caption = 'Prepmt. Include Tax';
                }
                field(prepmtPaymentDiscount; Rec."Prepmt. Payment Discount %")
                {
                    Caption = 'Prepmt. Payment Discount %';
                }
                field(prepmtPaymentTermsCode; Rec."Prepmt. Payment Terms Code")
                {
                    Caption = 'Prepmt. Payment Terms Code';
                }
                field(prepmtPmtDiscountDate; Rec."Prepmt. Pmt. Discount Date")
                {
                    Caption = 'Prepmt. Pmt. Discount Date';
                }
                field(prepmtPostingDescription; Rec."Prepmt. Posting Description")
                {
                    Caption = 'Prepmt. Posting Description';
                }
                field(prepmtSalesTaxRoundingAmt; Rec."Prepmt. Sales Tax Rounding Amt")
                {
                    Caption = 'Prepayment Sales Tax Rounding Amount';
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                    Caption = 'Prices Including VAT';
                }
                field(printPostedDocuments; Rec."Print Posted Documents")
                {
                    Caption = 'Print Posted Documents';
                }
                field(promisedDeliveryDate; Rec."Promised Delivery Date")
                {
                    Caption = 'Promised Delivery Date';
                }
                field(quoteAccepted; Rec."Quote Accepted")
                {
                    Caption = 'Quote Accepted';
                }
                field(quoteAcceptedDate; Rec."Quote Accepted Date")
                {
                    Caption = 'Quote Accepted Date';
                }
                field(quoteNo; Rec."Quote No.")
                {
                    Caption = 'Quote No.';
                }
                field(quoteSentToCustomer; Rec."Quote Sent to Customer")
                {
                    Caption = 'Quote Sent to Customer';
                }
                field(quoteValidUntilDate; Rec."Quote Valid Until Date")
                {
                    Caption = 'Quote Valid To Date';
                }
                field(rcvdFromCountRegionCode; Rec."Rcvd.-from Count./Region Code")
                {
                    Caption = 'Received-from Country/Region Code';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(recalculateInvoiceDisc; Rec."Recalculate Invoice Disc.")
                {
                    Caption = 'Recalculate Invoice Disc.';
                }
                field(receive; Rec.Receive)
                {
                    Caption = 'Receive';
                }
                field(registrationNumber; Rec."Registration Number")
                {
                    Caption = 'Registration No.';
                }
                field(requestedDeliveryDate; Rec."Requested Delivery Date")
                {
                    Caption = 'Requested Delivery Date';
                }
                field(reserve; Rec.Reserve)
                {
                    Caption = 'Reserve';
                }
                field(returnReceiptNo; Rec."Return Receipt No.")
                {
                    Caption = 'Return Receipt No.';
                }
                field(returnReceiptNoSeries; Rec."Return Receipt No. Series")
                {
                    Caption = 'Return Receipt No. Series';
                }
                field(satAddressID; Rec."SAT Address ID")
                {
                    Caption = 'SAT Address ID';
                }
                field(satCustomsRegime; Rec."SAT Customs Regime")
                {
                    Caption = 'SAT Customs Regime';
                }
                field(satInternationalTradeTerm; Rec."SAT International Trade Term")
                {
                    Caption = 'SAT International Trade Term';
                }
                field(satTransferReason; Rec."SAT Transfer Reason")
                {
                    Caption = 'SAT Transfer Reason';
                }
                field(satWeightUnitOfMeasure; Rec."SAT Weight Unit Of Measure")
                {
                    Caption = 'SAT Weight Unit Of Measure';
                }
                field(steTransactionID; Rec."STE Transaction ID")
                {
                    Caption = 'STE Transaction ID';
                }
                field(salesTaxAmountRounding; Rec."Sales Tax Amount Rounding")
                {
                    Caption = 'Sales Tax Amount Rounding';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(sellToAddress; Rec."Sell-to Address")
                {
                    Caption = 'Sell-to Address';
                }
                field(sellToAddress2; Rec."Sell-to Address 2")
                {
                    Caption = 'Sell-to Address 2';
                }
                field(sellToCity; Rec."Sell-to City")
                {
                    Caption = 'Sell-to City';
                }
                field(sellToContact; Rec."Sell-to Contact")
                {
                    Caption = 'Sell-to Contact';
                }
                field(sellToContactNo; Rec."Sell-to Contact No.")
                {
                    Caption = 'Sell-to Contact No.';
                }
                field(sellToCountryRegionCode; Rec."Sell-to Country/Region Code")
                {
                    Caption = 'Sell-to Country/Region Code';
                }
                field(sellToCounty; Rec."Sell-to County")
                {
                    Caption = 'Sell-to County';
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }
                field(sellToCustomerName2; Rec."Sell-to Customer Name 2")
                {
                    Caption = 'Sell-to Customer Name 2';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(sellToCustomerTemplCode; Rec."Sell-to Customer Templ. Code")
                {
                    Caption = 'Sell-to Customer Template Code';
                }
                field(sellToEMail; Rec."Sell-to E-Mail")
                {
                    Caption = 'Email';
                }
                field(sellToICPartnerCode; Rec."Sell-to IC Partner Code")
                {
                    Caption = 'Sell-to IC Partner Code';
                }
                field(sellToPhoneNo; Rec."Sell-to Phone No.")
                {
                    Caption = 'Sell-to Phone No.';
                }
                field(sellToPostCode; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code';
                }
                field(sendICDocument; Rec."Send IC Document")
                {
                    Caption = 'Send IC Document';
                }
                field(ship; Rec.Ship)
                {
                    Caption = 'Ship';
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address';
                }
                field(shipToAddress2; Rec."Ship-to Address 2")
                {
                    Caption = 'Ship-to Address 2';
                }
                field(shipToCity; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City';
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    Caption = 'Ship-to Country/Region Code';
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                    Caption = 'Ship-to County';
                }
                field(shipToName; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                }
                field(shipToName2; Rec."Ship-to Name 2")
                {
                    Caption = 'Ship-to Name 2';
                }
                field(shipToPhoneNo; Rec."Ship-to Phone No.")
                {
                    Caption = 'Ship-to Phone No.';
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                }
                field(shipToUPSZone; Rec."Ship-to UPS Zone")
                {
                    Caption = 'Ship-to UPS Zone';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(shipped; Rec.Shipped)
                {
                    Caption = 'Shipped';
                }
                field(shippedNotInvoiced; Rec."Shipped Not Invoiced")
                {
                    Caption = 'Shipped Not Invoiced';
                }
                field(shippingAdvice; Rec."Shipping Advice")
                {
                    Caption = 'Shipping Advice';
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code';
                }
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                    Caption = 'Shipping Agent Service Code';
                }
                field(shippingDateConfirmed; Rec."Shipping Date Confirmed")
                {
                    Caption = 'Shipping Date Confirmed';
                }
                field(shippingNo; Rec."Shipping No.")
                {
                    Caption = 'Shipping No.';
                }
                field(shippingNoSeries; Rec."Shipping No. Series")
                {
                    Caption = 'Shipping No. Series';
                }
                field(shippingTime; Rec."Shipping Time")
                {
                    Caption = 'Shipping Time';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(specialOrderWork; Rec."Special Order Work")
                {
                    Caption = 'Special Order Work';
                }
                field(specialOrderWorkCompleted; Rec."Special Order Work Completed")
                {
                    Caption = 'Special Order Work Completed';
                }
                field(specialShippingCompleted; Rec."Special Shipping Completed")
                {
                    Caption = 'Special Shipping Completed';
                }
                field(specialShippingWork; Rec."Special Shipping Work")
                {
                    Caption = 'Special Shipping Work';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(taxExemptionNo; Rec."Tax Exemption No.")
                {
                    Caption = 'Tax Exemption No.';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(trailer1; Rec."Trailer 1")
                {
                    Caption = 'Trailer 1';
                }
                field(trailer2; Rec."Trailer 2")
                {
                    Caption = 'Trailer 2';
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field(transitDistance; Rec."Transit Distance")
                {
                    Caption = 'Transit Distance';
                }
                field(transitHours; Rec."Transit Hours")
                {
                    Caption = 'Transit Hours';
                }
                field(transitFromDateTime; Rec."Transit-from Date/Time")
                {
                    Caption = 'Transit-from Date/Time';
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method';
                }
                field(transportOperators; Rec."Transport Operators")
                {
                    Caption = 'Transport Operators';
                }
                field(vatBaseDiscount; Rec."VAT Base Discount %")
                {
                    Caption = 'VAT Base Discount %';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatCountryRegionCode; Rec."VAT Country/Region Code")
                {
                    Caption = 'VAT Country/Region Code';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                    Caption = 'VAT Date';
                }
                field(vehicleCode; Rec."Vehicle Code")
                {
                    Caption = 'Vehicle Code';
                }
                field(wmdmPOS; Rec."WMDM POS")
                {
                    Caption = 'Warehouse Insight POS';
                }
                field(workDescription; Rec."Work Description")
                {
                    Caption = 'Work Description';
                }
                field(yourReference; Rec."Your Reference")
                {
                    Caption = 'Your Reference';
                }
                part(lines; NBK_SalesOrderLines)
                {
                    EntityName = 'nbk_saleslines';
                    EntitySetName = 'nbk_saleslines';
                    ApplicationArea = all;
                    Visible = true;
                    Caption = 'lines';
                    SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                }
            }
        }
    }
}
