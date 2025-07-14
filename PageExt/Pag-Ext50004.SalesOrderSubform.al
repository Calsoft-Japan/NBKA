pageextension 50004 "SalesLine Ext" extends "Sales Order Subform"
{
    layout
    {
        modify("Line Discount %")
        {
            Visible = false;
            Editable = false;
        }
        addlast(Control1)
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = All;
            }
            field("P/N"; Rec."P/N")
            {
                ApplicationArea = All;
            }

            field("Web Product No."; Rec."Web Product No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
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
            }
            field("Shipping Date"; Rec."Shipping Date")
            {
                ApplicationArea = All;
                Caption = 'Shipping Date';
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







































