page 50021 "Quote Price Calculation"
{
    ApplicationArea = All;
    Caption = 'Quote Price Calculation';
    PageType = Card;
    SourceTable = "Quote Price Calculation";
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Quote No."; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the value of the Quote No. field.', Comment = '%';
                }
                field("Quote Line No."; Rec."Quote Line No.")
                {
                    ToolTip = 'Specifies the value of the Quote Line No. field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ToolTip = 'Specifies the value of the Customer Type field.', Comment = '%';
                }

            }

            group(ItemInfo)
            {
                Caption = 'Item';

                field(Item; Rec.Item)
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the Item field.', Comment = '%';
                }
                field("Product No."; Rec."Product No.")
                {
                    ToolTip = 'Specifies the value of the Product No. field.', Comment = '%';
                }
                field("Special Product"; Rec."Special Product")
                {
                    ToolTip = 'Specifies the value of the Special Product field.', Comment = '%';
                }
                field("Item Category"; Rec."Item Category")
                {
                    ToolTip = 'Specifies the value of the Item Category field.', Comment = '%';
                }
                field("Quantity (min)"; Rec."Quantity (min)")
                {
                    ToolTip = 'Specifies the value of the Quantity (min) field.', Comment = '%';
                }
                field("Quantity (max)"; Rec."Quantity (max)")
                {
                    ToolTip = 'Specifies the value of the Quantity (max) field.', Comment = '%';
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ToolTip = 'Specifies the value of the Unit Type field.', Comment = '%';
                }
                field("Purchase Unit Price(USD)"; Rec."Purchase Unit Price(USD)")
                {
                    ToolTip = 'Specifies the value of the Purchase Unit Price(USD) field.', Comment = '%';
                }
                field("Purchase Shipping Costs"; Rec."Purchase Shipping Costs")
                {
                    ToolTip = 'Specifies the value of the Purchase Shipping Costs field.', Comment = '%';
                }
                field(Supplier; Rec.Supplier)
                {
                    ToolTip = 'Specifies the value of the Supplier field.', Comment = '%';
                }
                field("Expenses Rate %"; Rec."Expenses Rate %")
                {
                    ToolTip = 'Specifies the value of the Expenses Rate % field.', Comment = '%';
                }
                field("Gross Profit Rate %"; Rec."Gross Profit Rate %")
                {
                    ToolTip = 'Specifies the value of the Gross Profit Rate % field.', Comment = '%';
                }
                field("Gross Profit Rate Updated"; Rec."Gross Profit Rate Updated")
                {
                    ToolTip = 'Specifies the value of the Gross Profit Rate % Updated field.', Comment = '%';
                    Editable = false;
                }
                field("Quote Unit Price"; Rec."Quote Unit Price")
                {
                    ToolTip = 'Specifies the value of the Quote Unit Price field.', Comment = '%';
                }
                field("Quote Amount Price"; Rec."Quote Amount Price")
                {
                    ToolTip = 'Specifies the value of the Quote Amount Price field.', Comment = '%';
                }
                field("Lead Time"; Rec."Lead Time")
                {
                    ToolTip = 'Specifies the value of the Lead Time field.', Comment = '%';
                }
            }
        }
    }
    actions
    { }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        QAmount: Decimal;
    begin
        if CloseAction = Action::LookupOK then begin
            //===================Calculation Logic===========================================
            if (Rec."Unit Type" = '') then
                Error('Unit Type must be entered.');

            if (Rec."Quantity (min)" = 0) then
                Error('Quantity(min) must be entered.');

            if (Rec."Quantity (max)" <> 0) and (Rec."Quantity (min)" = 0) then
                Error('Quantity(min) must be entered in order to enter Quantity (max).');

            Rec."Quote Unit Price" := (Rec."Purchase Unit Price(USD)" + (Rec."Purchase Shipping Costs" / Rec."Quantity (min)")) * ((100 + Rec."Expenses Rate %") / 100) * ((100 + Rec."Gross Profit Rate %") / 100);
            Rec."Quote Unit Price" := Round(Rec."Quote Unit Price", 0.01);
            if Rec."Quantity (max)" <> 0 then
                QAmount := Rec."Quote Unit Price" * Rec."Quantity (max)"
            else
                QAmount := Rec."Quote Unit Price" * Rec."Quantity (min)";

            Rec."Quote Amount Price" := QAmount;
        end;
    end;

    procedure InitPage(var SalesLine: Record "Sales Line");// Quote_No: Code[20]; Quote_Line_No: Integer)
    var
        SalesHeader: Record "Sales Header";
        Itm: Record Item;
        Vendor: Record Vendor;
        GroProRate: Record "Gross Profit Rate";

    begin
        SalesHeader.Reset();
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");

        Itm.Reset();
        Itm.Get(SalesLine."No.");

        Vendor.Reset();
        if Vendor.Get(Itm."Vendor No.") then;

        GroProRate.Reset();
        if GroProRate.Get(SalesHeader."Customer Disc. Group", Itm."Item Disc. Group") then;



        Rec.Init();
        Rec."Quote No." := SalesLine."Document No.";
        Rec."Quote Line No." := SalesLine."Line No.";
        Rec."Customer No." := SalesHeader."Sell-to Customer No.";
        Rec."Customer Name" := SalesHeader."Sell-to Customer Name";
        Rec."Customer Type" := SalesHeader."Customer Disc. Group";
        Rec.Item := SalesLine."No.";
        Rec."Product No." := SalesLine."Description";
        Rec."Special Product" := SalesLine."Special Product";
        Rec.Supplier := Itm."Vendor No.";
        Rec."Expenses Rate %" := Vendor."Expenses Rate %";
        Rec."Gross Profit Rate %" := GroProRate."Gross Profit Rate %";
        Rec."Item Category" := Itm."Item Disc. Group";
        rec."Unit Type" := SalesLine."Unit of Measure Code";
        Rec.Insert();

        SetTableView(Rec);
    end;

    procedure GetUnitPrice(): Decimal;
    begin
        exit(Rec."Quote Unit Price");
    end;
}
