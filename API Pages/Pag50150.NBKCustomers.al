page 50150 NBK_Customers
{
    APIGroup = 'powerbipages';
    APIPublisher = 'nbk_calsoft';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'nbkCustomers';
    DelayedInsert = true;
    EntityName = 'nbk_customers';
    EntitySetName = 'nbk_customers';
    PageType = API;
    SourceTable = Customer;
    ODataKeyFields = "No.";

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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(cfdiCustomerName; Rec."CFDI Customer Name")
                {
                    Caption = 'CFDI Customer Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.';
                }
                field(allowMultiplePostingGroups; Rec."Allow Multiple Posting Groups")
                {
                    Caption = 'Allow Multiple Posting Groups';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(applicationMethod; Rec."Application Method")
                {
                    Caption = 'Application Method';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(balanceLCY; Rec."Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                }
                field(balanceDue; Rec."Balance Due")
                {
                    Caption = 'Balance Due';
                }
                field(balanceDueLCY; Rec."Balance Due (LCY)")
                {
                    Caption = 'Balance Due (LCY)';
                }
                field(balanceOnDate; Rec."Balance on Date")
                {
                    Caption = 'Balance on Date';
                }
                field(balanceOnDateLCY; Rec."Balance on Date (LCY)")
                {
                    Caption = 'Balance on Date (LCY)';
                }
                field(bankCommunication; Rec."Bank Communication")
                {
                    Caption = 'Bank Communication';
                }
                field(baseCalendarCode; Rec."Base Calendar Code")
                {
                    Caption = 'Base Calendar Code';
                }
                field(billToNoOfBlanketOrders; Rec."Bill-To No. of Blanket Orders")
                {
                    Caption = 'Bill-To No. of Blanket Orders';
                }
                field(billToNoOfCreditMemos; Rec."Bill-To No. of Credit Memos")
                {
                    Caption = 'Bill-To No. of Credit Memos';
                }
                field(billToNoOfInvoices; Rec."Bill-To No. of Invoices")
                {
                    Caption = 'Bill-To No. of Invoices';
                }
                field(billToNoOfOrders; Rec."Bill-To No. of Orders")
                {
                    Caption = 'Bill-To No. of Orders';
                }
                field(billToNoOfPstdCrMemos; Rec."Bill-To No. of Pstd. Cr. Memos")
                {
                    Caption = 'Bill-To No. of Pstd. Cr. Memos';
                }
                field(billToNoOfPstdInvoices; Rec."Bill-To No. of Pstd. Invoices")
                {
                    Caption = 'Bill-To No. of Pstd. Invoices';
                }
                field(billToNoOfPstdReturnR; Rec."Bill-To No. of Pstd. Return R.")
                {
                    Caption = 'Bill-To No. of Pstd. Return R.';
                }
                field(billToNoOfPstdShipments; Rec."Bill-To No. of Pstd. Shipments")
                {
                    Caption = 'Bill-To No. of Pstd. Shipments';
                }
                field(billToNoOfQuotes; Rec."Bill-To No. of Quotes")
                {
                    Caption = 'Bill-To No. of Quotes';
                }
                field(billToNoOfReturnOrders; Rec."Bill-To No. of Return Orders")
                {
                    Caption = 'Bill-To No. of Return Orders';
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                }
                field(billToNoOfArchivedDoc; Rec."Bill-to No. Of Archived Doc.")
                {
                    Caption = 'Bill-to No. Of Sales Archived Doc.';
                }
                field(blockPaymentTolerance; Rec."Block Payment Tolerance")
                {
                    Caption = 'Block Payment Tolerance';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(budgetedAmount; Rec."Budgeted Amount")
                {
                    Caption = 'Budgeted Amount';
                }
                field(cdoAutomaticDocuments; Rec."CDO Automatic Documents")
                {
                    Caption = 'Automatic Documents';
                }
                field(cdoAutomaticStatement; Rec."CDO Automatic statement")
                {
                    Caption = 'Automatic statement';
                }
                field(cdoEMailRecipients; Rec."CDO EMail Recipients")
                {
                    Caption = 'Email Recipients';
                }
                field(cdoFirstStatementStartDate; Rec."CDO First statement start date")
                {
                    Caption = 'First statement start date';
                }
                field(cdoLastAutomaticDate; Rec."CDO Last Automatic Date")
                {
                    Caption = 'Last Automatic Date';
                }
                field(cdoLastBalDueStatemEndd; Rec."CDO Last bal.due statem. endd.")
                {
                    Caption = 'Last balance due statem. (End Date)';
                }
                field(cdoLastBalDueStatemStD; Rec."CDO Last bal.due statem.st.d.")
                {
                    Caption = 'Last balance due statem. (Start Date)';
                }
                field(cdoLastPerStatementEndD; Rec."CDO Last per.statement end d.")
                {
                    Caption = 'Last period statement (End Date)';
                }
                field(cdoLastPerStatementStartd; Rec."CDO Last per.statement startd.")
                {
                    Caption = 'Last period statement (Start Date)';
                }
                field(cdoLastUserStatementDate; Rec."CDO Last user statement date")
                {
                    Caption = 'Last user statement date';
                }
                field(cdoLastUserStatementUserID; Rec."CDO Last user statement userID")
                {
                    Caption = 'Last user statement user ID';
                }
                field(cdoLogLines; Rec."CDO Log Lines")
                {
                    Caption = 'Log';
                }
                field(cdoOnEMailSMTP; Rec."CDO On E-Mail (SMTP)")
                {
                    Caption = 'On Email (SMTP)';
                }
                field(cdoPDFPassword; Rec."CDO PDF Password")
                {
                    Caption = 'PDF Password';
                }
                field(cdoSealPDFDocuments; Rec."CDO Seal PDF Documents")
                {
                    Caption = 'Seal PDF Documents';
                }
                field(cdoSendCode; Rec."CDO Send Code")
                {
                    Caption = 'Output Profile';
                }
                field(cdoSendStatementCode; Rec."CDO Send Statement Code")
                {
                    Caption = 'Send Statement Code';
                }
                field(cdoTemplateSetup; Rec."CDO Template Setup")
                {
                    Caption = 'Template Setup';
                }
                field(cfdiExportCode; Rec."CFDI Export Code")
                {
                    Caption = 'CFDI Export Code';
                }
                field(cfdiGeneralPublic; Rec."CFDI General Public")
                {
                    Caption = 'CFDI General Public';
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
                field(curpNo; Rec."CURP No.")
                {
                    Caption = 'CURP No.';
                }
                field(cashFlowPaymentTermsCode; Rec."Cash Flow Payment Terms Code")
                {
                    Caption = 'Cash Flow Payment Terms Code';
                }
                field(certificateOfConformance; Rec."Certificate of Conformance")
                {
                    Caption = 'Certificate of Conformance';
                }
                field(chainName; Rec."Chain Name")
                {
                    Caption = 'Chain Name';
                }
                field(checkDateFormat; Rec."Check Date Format")
                {
                    Caption = 'Check Date Format';
                }
                field(checkDateSeparator; Rec."Check Date Separator")
                {
                    Caption = 'Check Date Separator';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(collectionMethod; Rec."Collection Method")
                {
                    Caption = 'Collection Method';
                }
                field(combineServiceShipments; Rec."Combine Service Shipments")
                {
                    Caption = 'Combine Service Shipments';
                }
                field(combineShipments; Rec."Combine Shipments")
                {
                    Caption = 'Combine Sales Shipments';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
                field(contactGraphId; Rec."Contact Graph Id")
                {
                    Caption = 'Contact Graph Id';
                }
                field(contactID; Rec."Contact ID")
                {
                    Caption = 'Contact ID';
                }
                field(contactType; Rec."Contact Type")
                {
                    Caption = 'Contact Type';
                }
                field(contractGainLossAmount; Rec."Contract Gain/Loss Amount")
                {
                    Caption = 'Contract Gain/Loss Amount';
                }
                field(copySellToAddrToQteFrom; Rec."Copy Sell-to Addr. to Qte From")
                {
                    Caption = 'Copy Sell-to Addr. to Qte From';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                    Caption = 'Coupled to Dataverse';
                }
                field(crMemoAmounts; Rec."Cr. Memo Amounts")
                {
                    Caption = 'Cr. Memo Amounts';
                }
                field(crMemoAmountsLCY; Rec."Cr. Memo Amounts (LCY)")
                {
                    Caption = 'Cr. Memo Amounts (LCY)';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(creditAmountLCY; Rec."Credit Amount (LCY)")
                {
                    Caption = 'Credit Amount (LCY)';
                }
                field(creditLimitLCY; Rec."Credit Limit (LCY)")
                {
                    Caption = 'Credit Limit (LCY)';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(currencyId; Rec."Currency Id")
                {
                    Caption = 'Currency Id';
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
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(debitAmountLCY; Rec."Debit Amount (LCY)")
                {
                    Caption = 'Debit Amount (LCY)';
                }
                field(disableSearchByName; Rec."Disable Search by Name")
                {
                    Caption = 'Disable Search by Name';
                }
                field(documentSendingProfile; Rec."Document Sending Profile")
                {
                    Caption = 'Document Sending Profile';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(eoriNumber; Rec."EORI Number")
                {
                    Caption = 'EORI Number';
                }
                field(excludeFromPmtPractices; Rec."Exclude from Pmt. Practices")
                {
                    Caption = 'Exclude from Payment Practices';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(finChargeMemoAmountsLCY; Rec."Fin. Charge Memo Amounts (LCY)")
                {
                    Caption = 'Fin. Charge Memo Amounts (LCY)';
                }
                field(finChargeTermsCode; Rec."Fin. Charge Terms Code")
                {
                    Caption = 'Fin. Charge Terms Code';
                }
                field(financeChargeMemoAmounts; Rec."Finance Charge Memo Amounts")
                {
                    Caption = 'Finance Charge Memo Amounts';
                }
                field(firstTransactionDate; Rec."First Transaction Date")
                {
                    Caption = 'Customer Since';
                }
                field(formatRegion; Rec."Format Region")
                {
                    Caption = 'Format Region';
                }
                field(gln; Rec.GLN)
                {
                    Caption = 'GLN';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code';
                }
                field(image; Rec.Image)
                {
                    Caption = 'Image';
                }
                field(intrastatPartnerType; Rec."Intrastat Partner Type")
                {
                    Caption = 'Intrastat Partner Type';
                }
                field(invAmountsLCY; Rec."Inv. Amounts (LCY)")
                {
                    Caption = 'Inv. Amounts (LCY)';
                }
                field(invDiscountsLCY; Rec."Inv. Discounts (LCY)")
                {
                    Caption = 'Inv. Discounts (LCY)';
                }
                field(invoiceAmounts; Rec."Invoice Amounts")
                {
                    Caption = 'Invoice Amounts';
                }
                field(invoiceCopies; Rec."Invoice Copies")
                {
                    Caption = 'Invoice Copies';
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    Caption = 'Invoice Disc. Code';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(lastStatementNo; Rec."Last Statement No.")
                {
                    Caption = 'Last Statement No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                }
                field(netChange; Rec."Net Change")
                {
                    Caption = 'Net Change';
                }
                field(netChangeLCY; Rec."Net Change (LCY)")
                {
                    Caption = 'Net Change (LCY)';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(noOfBlanketOrders; Rec."No. of Blanket Orders")
                {
                    Caption = 'No. of Blanket Orders';
                }
                field(noOfCreditMemos; Rec."No. of Credit Memos")
                {
                    Caption = 'No. of Credit Memos';
                }
                field(noOfInvoices; Rec."No. of Invoices")
                {
                    Caption = 'No. of Invoices';
                }
                field(noOfOrders; Rec."No. of Orders")
                {
                    Caption = 'No. of Orders';
                }
                field(noOfPstdCreditMemos; Rec."No. of Pstd. Credit Memos")
                {
                    Caption = 'No. of Pstd. Credit Memos';
                }
                field(noOfPstdInvoices; Rec."No. of Pstd. Invoices")
                {
                    Caption = 'No. of Pstd. Invoices';
                }
                field(noOfPstdReturnReceipts; Rec."No. of Pstd. Return Receipts")
                {
                    Caption = 'No. of Pstd. Return Receipts';
                }
                field(noOfPstdShipments; Rec."No. of Pstd. Shipments")
                {
                    Caption = 'No. of Pstd. Shipments';
                }
                field(noOfQuotes; Rec."No. of Quotes")
                {
                    Caption = 'No. of Quotes';
                }
                field(noOfReturnOrders; Rec."No. of Return Orders")
                {
                    Caption = 'No. of Return Orders';
                }
                field(noOfShipToAddresses; Rec."No. of Ship-to Addresses")
                {
                    Caption = 'No. of Ship-to Addresses';
                }
                field(otherAmounts; Rec."Other Amounts")
                {
                    Caption = 'Other Amounts';
                }
                field(otherAmountsLCY; Rec."Other Amounts (LCY)")
                {
                    Caption = 'Other Amounts (LCY)';
                }
                field(ourAccountNo; Rec."Our Account No.")
                {
                    Caption = 'Our Account No.';
                }
                field(outstandingInvoices; Rec."Outstanding Invoices")
                {
                    Caption = 'Outstanding Invoices';
                }
                field(outstandingInvoicesLCY; Rec."Outstanding Invoices (LCY)")
                {
                    Caption = 'Outstanding Invoices (LCY)';
                }
                field(outstandingOrders; Rec."Outstanding Orders")
                {
                    Caption = 'Outstanding Orders';
                }
                field(outstandingOrdersLCY; Rec."Outstanding Orders (LCY)")
                {
                    Caption = 'Outstanding Orders (LCY)';
                }
                field(outstandingServOrdersLCY; Rec."Outstanding Serv. Orders (LCY)")
                {
                    Caption = 'Outstanding Serv. Orders (LCY)';
                }
                field(outstandingServInvoicesLCY; Rec."Outstanding Serv.Invoices(LCY)")
                {
                    Caption = 'Outstanding Serv.Invoices(LCY)';
                }
                field(partnerType; Rec."Partner Type")
                {
                    Caption = 'Partner Type';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(paymentMethodId; Rec."Payment Method Id")
                {
                    Caption = 'Payment Method Id';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(paymentTermsId; Rec."Payment Terms Id")
                {
                    Caption = 'Payment Terms Id';
                }
                field(payments; Rec.Payments)
                {
                    Caption = 'Payments';
                }
                field(paymentsLCY; Rec."Payments (LCY)")
                {
                    Caption = 'Payments (LCY)';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(placeOfExport; Rec."Place of Export")
                {
                    Caption = 'Place of Export';
                }
                field(pmtDiscToleranceLCY; Rec."Pmt. Disc. Tolerance (LCY)")
                {
                    Caption = 'Pmt. Disc. Tolerance (LCY)';
                }
                field(pmtDiscountsLCY; Rec."Pmt. Discounts (LCY)")
                {
                    Caption = 'Pmt. Discounts (LCY)';
                }
                field(pmtToleranceLCY; Rec."Pmt. Tolerance (LCY)")
                {
                    Caption = 'Pmt. Tolerance (LCY)';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(preferredBankAccountCode; Rec."Preferred Bank Account Code")
                {
                    Caption = 'Preferred Bank Account Code';
                }
                field(prepayment; Rec."Prepayment %")
                {
                    Caption = 'Prepayment %';
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                    Caption = 'Prices Including VAT';
                }
                field(primaryContactNo; Rec."Primary Contact No.")
                {
                    Caption = 'Primary Contact No.';
                }
                field(printStatements; Rec."Print Statements")
                {
                    Caption = 'Print Statements';
                }
                field(priority; Rec.Priority)
                {
                    Caption = 'Priority';
                }
                field(privacyBlocked; Rec."Privacy Blocked")
                {
                    Caption = 'Privacy Blocked';
                }
                field(profitLCY; Rec."Profit (LCY)")
                {
                    Caption = 'Profit (LCY)';
                }
                field(rfcNo; Rec."RFC No.")
                {
                    Caption = 'RFC No.';
                }
                field(refunds; Rec.Refunds)
                {
                    Caption = 'Refunds';
                }
                field(refundsLCY; Rec."Refunds (LCY)")
                {
                    Caption = 'Refunds (LCY)';
                }
                field(registrationNumber; Rec."Registration Number")
                {
                    Caption = 'Registration No.';
                }
                field(reminderAmounts; Rec."Reminder Amounts")
                {
                    Caption = 'Reminder Amounts';
                }
                field(reminderAmountsLCY; Rec."Reminder Amounts (LCY)")
                {
                    Caption = 'Reminder Amounts (LCY)';
                }
                field(reminderTermsCode; Rec."Reminder Terms Code")
                {
                    Caption = 'Reminder Terms Code';
                }
                field(reserve; Rec.Reserve)
                {
                    Caption = 'Reserve';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(satTaxRegimeClassification; Rec."SAT Tax Regime Classification")
                {
                    Caption = 'SAT Tax Regime Classification';
                }
                field(salesLCY; Rec."Sales (LCY)")
                {
                    Caption = 'Sales (LCY)';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(sellToNoOfArchivedDoc; Rec."Sell-to No. Of Archived Doc.")
                {
                    Caption = 'Sell-to No. Of Sales Archived Doc.';
                }
                field(servShippedNotInvoicedLCY; Rec."Serv Shipped Not Invoiced(LCY)")
                {
                    Caption = 'Serv Shipped Not Invoiced(LCY)';
                }
                field(serviceZoneCode; Rec."Service Zone Code")
                {
                    Caption = 'Service Zone Code';
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(shipmentMethodId; Rec."Shipment Method Id")
                {
                    Caption = 'Shipment Method Id';
                }
                field(shippedNotInvoiced; Rec."Shipped Not Invoiced")
                {
                    Caption = 'Shipped Not Invoiced';
                }
                field(shippedNotInvoicedLCY; Rec."Shipped Not Invoiced (LCY)")
                {
                    Caption = 'Shipped Not Invoiced (LCY)';
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
                field(shippingTime; Rec."Shipping Time")
                {
                    Caption = 'Shipping Time';
                }
                field(specialOrderWork; Rec."Special Order Work")
                {
                    Caption = 'Special Order Work';
                }
                field(specialShippingWork; Rec."Special Shipping Work")
                {
                    Caption = 'Special Shipping Work';
                }
                field(stateInscription; Rec."State Inscription")
                {
                    Caption = 'State Inscription';
                }
                field(statisticsGroup; Rec."Statistics Group")
                {
                    Caption = 'Statistics Group';
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
                field(taxAreaID; Rec."Tax Area ID")
                {
                    Caption = 'Tax Area ID';
                }
                field(taxExemptionNo; Rec."Tax Exemption No.")
                {
                    Caption = 'Tax Exemption No.';
                }
                field(taxIdentificationType; Rec."Tax Identification Type")
                {
                    Caption = 'Tax Identification Type';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                    Caption = 'Telex Answer Back';
                }
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                field(territoryCode; Rec."Territory Code")
                {
                    Caption = 'Territory Code';
                }
                field(upsZone; Rec."UPS Zone")
                {
                    Caption = 'UPS Zone';
                }
                field(useGLNInElectronicDocument; Rec."Use GLN in Electronic Document")
                {
                    Caption = 'Use GLN in Electronic Documents';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }
                field(validateEUVatRegNo; Rec."Validate EU Vat Reg. No.")
                {
                    Caption = 'Validate EU VAT Reg. No.';
                }
            }
        }
    }
}
