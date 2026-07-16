namespace NBKA.NBKA;

using Microsoft.Sales.Document;
using Microsoft.CRM.Contact;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;

pageextension 50120 SalesCreditMemoExt extends "Sales Credit Memo"
{
    layout
    {
        modify("Sell-to Contact")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Contact: Record Contact;
            begin
                Contact.FilterGroup(2);
                Rec.LookupContact(Rec."Sell-to Customer No.", Rec."Sell-to Contact No.", Contact);
                if Page.RunModal(0, Contact) = ACTION::LookupOK then
                    Rec.Validate("Sell-to Contact No.", Contact."No.");

                if ShipToOptions = ShipToOptions::"Default (Sell-to Address)" then
                    Rec.Validate("Ship-to Contact", Rec."Sell-to Contact");
                Contact.FilterGroup(0);

                Text := Rec."Sell-to Contact";
                CurrPage.Update();
            end;
        }
        modify(Billing)
        {
            Caption = 'Shipping and Billing';
        }
        addfirst(Billing)
        {
            group(Control91)
            {
                ShowCaption = false;
                group(Control90)
                {
                    ShowCaption = false;
                    field(ShippingOptions; ShipToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ship-to';
                        ToolTip = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.';

                        trigger OnValidate()
                        var
                            ShipToAddress: Record "Ship-to Address";
                            ShipToAddressList: Page "Ship-to Address List";
                            IsHandled: Boolean;
                        begin

                            case ShipToOptions of
                                ShipToOptions::"Default (Sell-to Address)":
                                    begin
                                        Rec.Validate("Ship-to Code", '');
                                        Rec.CopySellToAddressToShipToAddress();
                                    end;
                                ShipToOptions::"Alternate Shipping Address":
                                    begin
                                        ShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                                        ShipToAddressList.LookupMode := true;
                                        ShipToAddressList.SetTableView(ShipToAddress);

                                        if ShipToAddressList.RunModal() = ACTION::LookupOK then begin
                                            ShipToAddressList.GetRecord(ShipToAddress);
                                            Rec.Validate("Ship-to Code", ShipToAddress.Code);
                                            IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                        end else
                                            ShipToOptions := ShipToOptions::"Custom Address";
                                    end;
                                ShipToOptions::"Custom Address":
                                    begin
                                        if not Rec."EC Order" then
                                            Error('Custom address is not allowed.');
                                        Rec.Validate("Ship-to Code", '');
                                        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                                    end;
                            end;

                        end;
                    }
                    group(Control4)
                    {
                        ShowCaption = false;
                        Visible = not (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                        field("Ship-to Code"; Rec."Ship-to Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Code';
                            Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                            Importance = Promoted;
                            ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                            trigger OnValidate()
                            var
                                ShipToAddress: Record "Ship-to Address";
                            begin
                                if (xRec."Ship-to Code" <> '') and (Rec."Ship-to Code" = '') then
                                    Error(EmptyShipToCodeErr);
                                if Rec."Ship-to Code" <> '' then begin
                                    ShipToAddress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code");
                                    IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                end else
                                    IsShipToCountyVisible := false;
                            end;
                        }
                        field("Ship-to Name"; Rec."Ship-to Name")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name';
                            Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                        }
                        field("Ship-to Name 2"; Rec."Ship-to Name 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name 2';
                            Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            Importance = Additional;
                            QuickEntry = false;
                            Visible = false;
                        }
                        field("Ship-to Address"; Rec."Ship-to Address")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address';
                            Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            QuickEntry = false;
                        }
                        field("Ship-to Address 2"; Rec."Ship-to Address 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address 2';
                            Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            QuickEntry = false;
                        }
                        field("Ship-to City"; Rec."Ship-to City")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'City';
                            Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            QuickEntry = false;
                        }
                        group(Control297)
                        {
                            ShowCaption = false;
                            Visible = IsShipToCountyVisible;
                            field("Ship-to County"; Rec."Ship-to County")
                            {
                                ApplicationArea = Basic, Suite;
                                CaptionClass = '5,1,' + Rec."Ship-to Country/Region Code";
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                QuickEntry = false;
                            }
                        }
                        field("Ship-to Post Code"; Rec."Ship-to Post Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Post Code';
                            Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            ToolTip = 'Specifies the postal code.';
                        }
                        field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Country/Region';
                            Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the customer''s country/region.';

                            trigger OnValidate()
                            begin
                                IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                            end;
                        }
                        field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                        {
                            Caption = 'UPS Zone';
                            Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            ToolTip = 'Specifies a UPS Zone code for this document if UPS is used for shipments.';
                        }
                    }
                    field("Ship-to Phone No."; Rec."Ship-to Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Phone No.';
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                    }
                }

            }


        }

    }
    var
        ShipToOptions: Enum "Sales Ship-to Options";
        FormatAddress: Codeunit "Format Address";
        IsShipToCountyVisible: Boolean;
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';

    trigger OnOpenPage()
    begin
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
    end;
}