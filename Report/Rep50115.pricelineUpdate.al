
report 50115 pricelineUpdate
{
    ApplicationArea = All;
    Caption = 'pricelineUpdate';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
                Pricelistline: Record "Price List Line";
            begin
                Pricelistline.Reset();
                Pricelistline.SetRange("Asset Type", Pricelistline."Asset Type"::Item);
                Pricelistline.SetRange("Product No.", "No.");
                if Pricelistline.FindSet() then
                    repeat
                        Pricelistline."P/N" := "P/N";
                        Pricelistline.Description := Description;
                        Pricelistline.Modify();
                        UpdatedCount += 1;
                    until PriceListLine.Next() = 0;
            end;

        }

    }
    var
        UpdatedCount: Integer;

    trigger OnPostReport()
    begin
        Message('%1 Price List Lines updated.', UpdatedCount);
    end;
}
