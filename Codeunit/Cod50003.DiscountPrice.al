codeunit 50003 "Discount Price"
{
    Subtype = Normal;

    procedure RunForDocument(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        // OLD: PriceListLine: Record 7001; // Price List Line table
        PriceListLine: Record "Price List Line"; // NEW: typed by name for clarity/future-proofing
        TempOriginalPrice: Decimal;
        TempOriginalDiscount: Decimal;
        TempDiscountRate: Decimal;
        PriceMatchFound: Boolean;
    begin
        // Filter sales lines for this Sales Document
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");

        // OLD: if SalesLine.FindSet() then
        if SalesLine.FindSet(true) then // NEW: use true to keep triggers/locks safe while iterating
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
                        // OLD (skips standard recalc):
                        // SalesLine."Line Discount %" := 0;
                        // SalesLine."Discount Rate" := 0;
                        // SalesLine.Modify(true);

                        // NEW: VALIDATE triggers standard line amount/VAT recalculations
                        SalesLine.Validate("Line Discount %", 0);
                        SalesLine."Discount Rate" := 0; // custom field – OK to assign directly
                        SalesLine.Modify(true); // keep triggers ON
                    end else begin
                        // Keep your metadata values
                        TempOriginalPrice := SalesLine."Original Price";
                        TempOriginalDiscount := SalesLine."Original Discount %";
                        TempDiscountRate := SalesLine."Discount Rate";

                        // Reset to no discount and recalc price
                        SalesLine.Validate("Line Discount %", 0);
                        SalesLine.Validate(
                          "Unit Price",
                          Round(TempOriginalPrice * (1 - TempDiscountRate / 100), 0.01, '=')
                        );

                        // Preserve metadata/custom fields
                        SalesLine."Original Price" := TempOriginalPrice;
                        SalesLine."Original Discount %" := TempOriginalDiscount;
                        SalesLine."Discount Rate" := TempDiscountRate;

                        SalesLine.Modify(true); // ensure triggers are ON
                    end;
                end;
            until SalesLine.Next() = 0;

        Message('Discount Price has been applied to all applicable lines.');
    end;
}
