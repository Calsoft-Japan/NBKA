tableextension 50001 "Customer Ext" extends Customer
{
    fields
    {
        field(50000; "Certificate of Conformance"; Boolean)
        {
            ToolTip = 'Specifies whether Certificate of Conformance needs to be printed';
        }
        field(50001; "Special Order Work"; Boolean)
        {
            ToolTip = 'Specifies whether this customer needs special assistance for orders.';
        }
        field(50002; "Special Shipping Work"; Boolean)
        {
            ToolTip = 'Specifies whether this customer needs special assistance for shipping.';
        }
    }
}
