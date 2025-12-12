tableextension 50004 "SalesLine Ext" extends "Sales Line"
{
    fields
    {
        field(50000; "Certificate of Conformance"; Boolean)
        {
            ToolTip = 'Print Certificate of Conformance when Ship is posted';
            Caption = 'Certificate of Conformance';
            DataClassification = ToBeClassified;
        }

        field(50001; "P/N"; Code[50])
        {
            Caption = 'P/N';
            DataClassification = CustomerContent;
        }

        field(50002; "Web Product No."; Code[50])
        {
            Caption = 'Web Product No.';
            DataClassification = CustomerContent;
        }

        field(50003; "Quantity (min)"; Decimal)
        {
            Caption = 'Quantity (min)';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50004; "Quantity (max)"; Decimal)
        {
            Caption = 'Quantity (max)';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50005; "Gross Profit Rate %"; Decimal)
        {
            Editable = false;
            Caption = 'Gross Profit Rate %';
            DataClassification = ToBeClassified;
        }

        field(50006; "Lead Time"; Integer)
        {
            Caption = 'Lead Time';
            DataClassification = ToBeClassified;
        }

        field(50007; "Discount Rate Updated"; Boolean)
        {
            Caption = 'Discount Rate Updated';
            DataClassification = ToBeClassified;
            ToolTip = 'Mark if the default rate has been changed.';
        }

        field(50008; "Gross Profit Rate Updated"; Boolean)
        {
            Caption = 'Gross Profit Rate Updated';
            DataClassification = ToBeClassified;
            ToolTip = 'Mark if the default rate has been changed.';
        }

        field(50009; "Special Product"; Boolean)
        {
            Caption = 'Special Product';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies if the item is a Special Product.';
        }

        field(50010; "Estimator Role"; Boolean)
        {
            Caption = 'Estimator Role';
            DataClassification = ToBeClassified;
        }

        field(50011; "Gross Profit Rate < 60%"; Boolean)
        {
            Caption = 'Gross Profit Rate < 60%';
            DataClassification = ToBeClassified;
        }

        field(50012; "Original Price"; Decimal)
        {
            Caption = 'Original Price';
            DataClassification = ToBeClassified;
            ToolTip = 'Copied from Unit Price';
            Editable = false;
        }

        field(50013; "Original Discount %"; Decimal)
        {
            Caption = 'Original Discount %';
            DataClassification = ToBeClassified;
            ToolTip = 'Copied from Discount %';
            Editable = false;
        }

        field(50014; "Discount Rate"; Decimal)
        {
            Caption = 'Discount Rate';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the discount percentage';

            trigger OnValidate()
            var
                salesheader: Record "Sales Header";
            begin
                if ("Discount Rate" <> 0) and (Rec."Discount Rate" <> xRec."Discount Rate") then begin
                    "Line Discount %" := "Discount Rate";
                    // Validate("Line Discount %", "Discount Rate");
                    // Validate("Line Discount %", "Original Discount %");
                end;
            end;
        }

        field(50015; "Shipping Date"; Date)
        {
            Caption = 'Shipping Date';
            DataClassification = ToBeClassified;
        }
        field(50016; "Lead Time text"; Text[50])
        {
            Caption = 'Lead Time';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Intvar: Integer;
            begin
                if Rec."Lead Time text" <> '' then begin
                    if not Evaluate(Intvar, Rec."Lead Time text") then
                        Error('Enter a numerical value');
                end;
            end;
        }
        field(50017; "Ship-to PO No."; Code[100])
        {
            Caption = 'Ship-to PO No.';
            DataClassification = ToBeClassified;
            ToolTip = 'End user''s PO number';

        }


        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                if not Rec."Special Product" then begin
                    Rec."Original Discount %" := Rec."Line Discount %";
                    Rec."Discount Rate" := Rec."Line Discount %";
                end;
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                if not Rec."Special Product" then
                    Rec."Original Price" := Rec."Unit Price";
            end;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Customer: Record Customer;
                Item: Record Item;
            begin
                if Customer.Get(Rec."Sell-to Customer No.") then
                    Rec."Certificate of Conformance" := Customer."Certificate of Conformance";

                if Rec.Type = Rec.Type::Item then
                    if Item.Get(Rec."No.") then begin
                        Rec."P/N" := Item."P/N";
                        Rec."Web Product No." := Item."Web Product No.";
                        Rec."Special Product" := Item."Special Product";
                    end;

                if Rec."Special Product" then begin
                    Rec.Validate("Line Discount %", 0);
                    Rec."Original Discount %" := 0;
                    Rec."Discount Rate" := 0;
                end;
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                if Rec."Special Product" then begin
                    Rec.Validate("Line Discount %", 0);
                    Rec."Original Discount %" := 0;
                    Rec."Discount Rate" := 0;
                end;
            end;
        }
    }
}
