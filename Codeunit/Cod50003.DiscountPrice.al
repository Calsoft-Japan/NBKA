codeunit 50003 "Discount Price"
{
    Subtype = Normal;

    procedure RunForDocument(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        TempOriginalPrice: Decimal;
        TempOriginalDiscount: Decimal;
        TempDiscountRate: Decimal;
    begin
        // Filter sales lines for this document
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");

        if SalesLine.FindSet() then
            repeat
                if not SalesLine."Special Product" then begin
                    // Backup current values
                    TempOriginalPrice := SalesLine."Original Price";
                    TempOriginalDiscount := SalesLine."Original Discount %";
                    TempDiscountRate := SalesLine."Discount Rate";

                    // Clear Line Discount %
                    SalesLine.Validate("Line Discount %", 0);

                    // Recalculate Unit Price
                    SalesLine.Validate("Unit Price", Round(
                        TempOriginalPrice * (1 - TempDiscountRate / 100),
                        0.01,
                        '='
                    ));

                    // Restore pricing fields if needed
                    SalesLine."Original Price" := TempOriginalPrice;
                    SalesLine."Original Discount %" := TempOriginalDiscount;
                    SalesLine."Discount Rate" := TempDiscountRate;

                    // Save the changes
                    SalesLine.Modify(true);
                end;
            until SalesLine.Next() = 0;

        // Show confirmation
        Message('Discount Price has been applied to all lines.');
    end;
}
