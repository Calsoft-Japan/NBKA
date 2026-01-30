pageextension 50000 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter("Description")
        {
            field("P/N"; Rec."P/N")
            {
                ApplicationArea = all;
                ShowMandatory = true;
            }
            field("Web Product No."; Rec."Web Product No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Item Category Code")
        {
            field("Special Product"; Rec."Special Product")
            {
                ApplicationArea = all;
                ShowMandatory = true;
            }
            field("Effective Date"; Rec."Effective Date")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                NotBlank = true;
            }
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                NotBlank = true;
            }
        }
        modify(Type)
        {
            ShowMandatory = true;
        }
        modify("Base Unit of Measure")
        {
            ShowMandatory = true;
        }
        modify("Purchasing Code")
        {
            ShowMandatory = true;
        }
        modify("Search Description")
        {
            ShowMandatory = true;
        }
        modify("Tariff No.")
        {
            ShowMandatory = true;
        }
        modify("Country/Region of Origin Code")
        {
            ShowMandatory = true;
        }
        modify("Allow Invoice Disc.")
        {
            ShowMandatory = true;
        }
        modify("Item Disc. Group")
        {
            ShowMandatory = true;
        }
        modify("Include Inventory")
        {
            ShowMandatory = true;
        }
        modify("Use Cross-Docking")
        {
            ShowMandatory = true;
        }
        modify("Net Weight")
        {
            ShowMandatory = true;
        }
        modify("Sales Unit of Measure")
        {
            ShowMandatory = true;
        }
        modify("Put-away Unit of Measure Code")
        {
            ShowMandatory = true;
        }

    }
}
