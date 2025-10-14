namespace NBKA.NBKA;

using Microsoft.Sales.Setup;
using Microsoft.Foundation.NoSeries;

tableextension 50008 SalesandReceivablesetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Ship-to address No."; Code[20])
        {
            Caption = 'Ship-to address No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the code for the number series that will be used to assign numbers to Sales & Receivables Page. ';
        }
    }
}
