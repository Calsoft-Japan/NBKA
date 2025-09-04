table 50021 "Quote Price Calculation"
{
    Caption = 'Quote Price Calculation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            TableRelation = "Sales Header"."No.";
            Editable = false;
        }
        field(2; "Quote Line No."; Integer)
        {
            Caption = 'Quote Line No.';
            TableRelation = "Sales Line"."Line No." where("Document No." = field("Quote No."));
            Editable = false;
            //FieldClass = FlowField;
            //CalcFormula = lookup("Sales Line"."Line No." where("Document No." = field("Quote No.")));
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "Sales Header"."Sell-to Customer No." where("No." = field("Quote No."));
            Editable = false;
            //FieldClass = FlowField;
            //CalcFormula = lookup("Sales Header"."Sell-to Customer No." where("No." = field("Quote No.")));
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            TableRelation = "Sales Header"."Sell-to Customer Name" where("No." = field("Quote No."));
            Editable = false;
            //FieldClass = FlowField;
            //CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("No." = field("Quote No.")));
        }
        field(5; "Customer Type"; Code[20])
        {
            Caption = 'Customer Type';
            TableRelation = "Sales Header"."Customer Disc. Group" where("No." = field("Quote No."));
            Editable = false;
            //FieldClass = FlowField;
            //CalcFormula = lookup("Sales Header"."Customer Disc. Group" where("No." = field("Quote No.")));
        }
        field(6; Item; Code[20])
        {
            Caption = 'Item';
            TableRelation = "Sales Line"."No." where("Document No." = field("Quote No."), "Line No." = field("Quote Line No.")); //Item."No.";
            Editable = false;
        }
        field(7; "Product No."; Text[100])
        {
            Caption = 'Product No.';
            TableRelation = "Sales Line"."Description 2" where("Document No." = field("Quote No."), "Line No." = field("Quote Line No."));//TableRelation = Item."Description 2";
            Editable = true;
        }
        field(8; "Special Product"; Boolean)
        {
            Caption = 'Special Product';
            //TableRelation = Item."Special Product" where("No." = field(Item));
            Editable = false;
        }
        field(9; "Item Category"; Code[20])
        {
            Caption = 'Item Category';
            TableRelation = "Item Discount Group".Code;

            trigger OnValidate()
            var
                GroProRate: Record "Gross Profit Rate";
                SalesHeader: Record "Sales Header";
            begin
                if Rec."Item Category" <> xRec."Item Category" then begin
                    ReCalculate := true;

                    SalesHeader.Reset();
                    SalesHeader.Get(SalesHeader."Document Type"::Quote, Rec."Quote No.");

                    GroProRate.Reset();
                    GroProRate.Get(SalesHeader."Customer Disc. Group", Rec."Item Category");

                    Rec.Validate("Gross Profit Rate %", GroProRate."Gross Profit Rate %");
                end;
            end;
        }
        field(10; "Quantity (min)"; Decimal)
        {
            Caption = 'Quantity (min)';
            trigger OnValidate()
            begin
                if (Rec."Quantity (max)" <> 0) and (Rec."Quantity (max)" < Rec."Quantity (min)") then
                    Error('Quantity (max) must larger than Quantity(min).');

                CalculateQuoteAmout();
            end;
        }
        field(11; "Quantity (max)"; Decimal)
        {
            Caption = 'Quantity (max)';

            trigger OnValidate()
            begin
                if (Rec."Quantity (max)" <> 0) and (Rec."Quantity (min)" = 0) then
                    Error('Quantity(min) must be entered in order to enter Quantity (max).');

                if (Rec."Quantity (max)" < Rec."Quantity (min)") then
                    Error('Quantity (max) must larger than Quantity(min).');

                CalculateQuoteAmout();
            end;
        }
        field(12; "Unit Type"; Text[100])
        {
            Caption = 'Unit Type';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field(Item));
        }
        field(13; "Purchase Unit Price(USD)"; Decimal)
        {
            Caption = 'Purchase Unit Price(USD)';
            trigger OnValidate()
            begin
                CalculateQuoteAmout();
            end;
        }
        field(14; "Purchase Shipping Costs"; Decimal)
        {
            Caption = 'Purchase Shipping Costs';

            trigger OnValidate()
            begin
                CalculateQuoteAmout();
            end;
        }
        field(15; Supplier; Code[20])
        {
            Caption = 'Supplier';
            TableRelation = Vendor."No.";
            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                if Rec.Supplier <> '' then begin
                    Vend.Reset();
                    Vend.Get(Rec.Supplier);
                    Rec."Expenses Rate %" := Vend."Expenses Rate %";

                    CalculateQuoteAmout();
                end;
            end;
        }
        field(16; "Expenses Rate %"; Decimal)
        {
            Caption = 'Expenses Rate %';
            trigger OnValidate()
            begin
                CalculateQuoteAmout();
            end;
        }
        field(17; "Gross Profit Rate %"; Decimal)
        {
            Caption = 'Gross Profit Rate %';

            trigger OnValidate()
            var
                Itm: Record Item;
                GroProRate: Record "Gross Profit Rate";
                SalesHeader: Record "Sales Header";
            begin
                if ReCalculate or ((xRec."Gross Profit Rate %" <> Rec."Gross Profit Rate %") and (Rec."Special Product" = true)) then begin
                    ReCalculate := false;

                    SalesHeader.Reset();
                    SalesHeader.Get(SalesHeader."Document Type"::Quote, Rec."Quote No.");

                    Itm.Reset();
                    Itm.Get(Rec.Item);

                    GroProRate.Reset();
                    GroProRate.Get(SalesHeader."Customer Disc. Group", Itm."Item Disc. Group");

                    if GroProRate."Gross Profit Rate %" <> Rec."Gross Profit Rate %" then
                        "Gross Profit Rate Updated" := true
                    else
                        "Gross Profit Rate Updated" := false;
                end;

                CalculateQuoteAmout();
            end;
        }
        field(18; "Gross Profit Rate Updated"; Boolean)
        {
            Caption = 'Gross Profit Rate Updated';
            InitValue = false;

            trigger OnValidate()
            begin
                CalculateQuoteAmout();
            end;
        }
        field(19; "Quote Unit Price"; Decimal)
        {
            Caption = 'Quote Unit Price';
        }
        field(20; "Quote Amount Price"; Decimal)
        {
            Caption = 'Quote Amount Price';
        }
        field(21; "Lead Time"; Integer)
        {
            Caption = 'Lead Time';
        }
    }
    keys
    {
        key(PK; "Quote No.", "Quote Line No.")
        {
            Clustered = true;
        }
    }

    var
        ReCalculate: Boolean;

    procedure CalculateQuoteAmout()
    var
        QAmount: Decimal;
    begin
        //===================Calculation Logic===========================================
        //if (Rec."Purchase Unit Price(USD)" <> 0) and (Rec."Purchase Shipping Costs" <> 0) and (Rec."Quantity (min)" <> 0) and (Rec."Expenses Rate %" <> 0) and (Rec."Gross Profit Rate %" <> 0) then begin end;

        if (Rec."Quantity (min)" <> 0) then begin
            Rec."Quote Unit Price" := (Rec."Purchase Unit Price(USD)" + (Rec."Purchase Shipping Costs" / Rec."Quantity (min)")) * ((100 + Rec."Expenses Rate %") / 100) * ((100 + Rec."Gross Profit Rate %") / 100);
            Rec."Quote Unit Price" := Round(Rec."Quote Unit Price", 0.01);
            if Rec."Quantity (max)" <> 0 then
                QAmount := Rec."Quote Unit Price" * Rec."Quantity (max)"
            else
                QAmount := Rec."Quote Unit Price" * Rec."Quantity (min)";

            Rec."Quote Amount Price" := QAmount;
        end;
    end;
}
