tableextension 50002 "VendorExt" extends Vendor
{
    fields
    {
        field(50000; "Expenses Rate %"; Decimal)
        {
            ToolTip = 'Used for Quote Price Calculation.';
        }
        field(50001; "EDI Target"; Boolean)
        {
            ToolTip = 'Whether it is the automatic recipient for sending Purchase Order emails.';
        }

    }
}
