codeunit 50003 "Discount Price"
{
    Subtype = Normal;

    procedure RunForDocument(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        PriceListLine: Record 7001; // Price List Line table
        TempOriginalPrice: Decimal;
        TempOriginalDiscount: Decimal;
        TempDiscountRate: Decimal;
        PriceMatchFound: Boolean;
    begin
        // Filter sales lines for this Sales Document
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");

        if SalesLine.FindSet() then
            repeat
                if not SalesLine."Special Product" then begin
                    // Reset PriceListLine filter
                    PriceListLine.Reset();
                    PriceListLine.SetRange("Source Type", PriceListLine."Source Type"::Customer);
                    PriceListLine.SetRange("Source No.", SalesLine."Sell-to Customer No.");
                    PriceListLine.SetRange("Product No.", SalesLine."No.");
                    PriceListLine.SetRange("Minimum Quantity", 0, SalesLine.Quantity);

                    PriceMatchFound := false;
                    if PriceListLine.FindSet() then
                        repeat
                            if (PriceListLine."Starting Date" <= SalesHeader."Order Date") and
                               (SalesHeader."Order Date" <= PriceListLine."Ending Date") then begin
                                PriceMatchFound := true;
                                break;
                            end;
                        until PriceListLine.Next() = 0;

                    if PriceMatchFound then begin
                        SalesLine."Line Discount %" := 0;
                        //   SalesLine.Validate("Line Discount %", 0);
                        SalesLine.Validate("Discount Rate", 0);
                        //SalesLine."Discount Rate" := 0;
                        SalesLine.Modify(true);
                    end else begin
                        TempOriginalPrice := SalesLine."Original Price";
                        TempOriginalDiscount := SalesLine."Original Discount %";
                        TempDiscountRate := SalesLine."Discount Rate";

                        SalesLine.Validate("Line Discount %", 0);
                        SalesLine.Validate("Unit Price",
                            Round(TempOriginalPrice * (1 - TempDiscountRate / 100), 0.01, '='));

                        SalesLine."Original Price" := TempOriginalPrice;
                        SalesLine."Original Discount %" := TempOriginalDiscount;
                        SalesLine."Discount Rate" := TempDiscountRate;
                        SalesLine.Modify(true);
                    end;
                end;
            until SalesLine.Next() = 0;

        Message('Discount Price has been applied to all applicable lines.');
    end;
}



