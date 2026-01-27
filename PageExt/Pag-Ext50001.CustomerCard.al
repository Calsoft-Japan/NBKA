pageextension 50001 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = all;
            }
            field("Special Order Work"; Rec."Special Order Work")
            {
                ApplicationArea = all;
            }
            field("Special Shipping Work"; Rec."Special Shipping Work")
            {
                ApplicationArea = all;
            }

        }
        modify("No.")
        {
            ShowMandatory = true;
        }
        modify("Country/Region Code")
        {
            ShowMandatory = true;
        }
        modify(City)
        {
            ShowMandatory = true;
        }
        modify(County)
        {
            ShowMandatory = true;
        }
        modify("Post Code")
        {
            ShowMandatory = true;
        }
        modify("Phone No.")
        {
            ShowMandatory = true;
        }
        modify("E-Mail")
        {
            ShowMandatory = true;
        }
        modify(ContactName)
        {
            ShowMandatory = true;
        }
        modify("Primary Contact No.")
        {
            ShowMandatory = true;
        }
        modify("Customer Disc. Group")
        {
            ShowMandatory = true;
        }
        modify("Invoice Disc. Code")
        {
            ShowMandatory = true;
        }
        modify("Payment Method Code")
        {
            ShowMandatory = true;
        }
        modify("Payment Terms Code")
        {
            ShowMandatory = true;
        }
        modify("Combine Shipments")
        {
            ShowMandatory = true;
        }
        modify(Address)
        {
            ShowMandatory = true;
        }

    }

}
