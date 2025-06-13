tableextension 50002 "VendorExt" extends Vendor
{
    fields
    {
        field(50000; "Expenses Rate %"; Decimal)
        {
            // ObsoleteState = Removed;
            // ObsoleteReason = 'Replaced by "Expense Rate %".';
            Caption = 'Expenses Rate %';
        }
        field(50001; "EDI Target"; Boolean)
        {
            ToolTip = 'Whether it is the automatic recipient for sending Purchase Order emails.';
        }

    }
}
