page 50020 "Gross Profit Rate Setup"
{
    ApplicationArea = All;
    Caption = 'Gross Profit Rate Setup';
    PageType = List;
    SourceTable = "Gross Profit Rate";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Customer Type"; Rec."Customer Type")
                { }
                field("Item Category"; Rec."Item Category")
                { }
                field("Gross Profit Rate %"; Rec."Gross Profit Rate %")
                { }
            }
        }
    }
}
