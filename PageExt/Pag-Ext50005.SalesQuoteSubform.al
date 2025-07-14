pageextension 50005 "Sales Quote Subform Ext" extends "Sales Quote Subform"
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
            field("Quantity (min)"; Rec."Quantity (min)")
            {
                ApplicationArea = All;
            }
            field("Quantity (max)"; Rec."Quantity (max)")
            {
                ApplicationArea = All;
            }
            field("Gross Profit Rate %"; Rec."Gross Profit Rate %")
            {
                ApplicationArea = All;
            }
            field("Lead Time"; Rec."Lead Time")
            {
                ApplicationArea = All;
            }
            field("Discount Rate Updated"; Rec."Discount Rate Updated")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Updated when Approval Workflow API executed.';
            }
            field("Gross Profit Rate Updated"; Rec."Gross Profit Rate Updated")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Updated when Approval Workflow API is executed.';
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
        }


    }

    actions
    {
        addafter("Dimensions")
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
