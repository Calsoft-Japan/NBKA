pageextension 50004 "SalesLine Ext" extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("P/N"; Rec."P/N")
            {
                ApplicationArea = All;
            }

            field("Web Product No."; Rec."Web Product No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Special Product"; Rec."Special Product")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
        modify("Line Discount %")
        {
            Visible = false;
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            ShowMandatory = true;
        }
        modify("Purchasing Code")
        {
            ShowMandatory = true;
        }
        modify("Unit Price")
        {
            ShowMandatory = true;
        }
        modify("Requested Delivery Date")
        {
            ShowMandatory = true;
        }
        addafter("Line Discount %")
        {
            field("Original Price"; Rec."Original Price")
            {
                ApplicationArea = All;
                Caption = 'Original Price';
            }
            field("Original Discount %"; Rec."Original Discount %")
            {
                ApplicationArea = All;
                Caption = 'Original Discount %';
            }
            field("Discount Rate"; Rec."Discount Rate")
            {
                ApplicationArea = All;
                Caption = 'Discount Rate';
                Editable = false;
            }
        }
        addafter("Amount Including VAT")
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = All;
            }
            field("Shipping Date"; Rec."Shipping Date")
            {
                ApplicationArea = All;
                Caption = 'Shipping Date';
                ShowMandatory = true;
            }
            field("Ship-to PO No."; Rec."Ship-to PO No.")
            {
                ApplicationArea = all;
                ToolTip = 'End user''s PO number';
                ShowMandatory = true;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(DiscountPrice)
            {
                Caption = 'Discount Price';
                ApplicationArea = All;
                Image = Discount;
                trigger OnAction()
                var
                    CalcPrice: Codeunit "Discount Price";
                    SalesHeader: Record "Sales Header";
                begin
                    if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
                        CalcPrice.RunForDocument(SalesHeader);
                end;
            }
        }
    }
}







































