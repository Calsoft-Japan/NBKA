namespace NBKA.NBKA;

using Microsoft.Sales.Document;

reportextension 50000 CopySalesDocumentExt extends "Copy Sales Document"
{
    requestpage
    {
        trigger OnOpenPage()
        begin
            IncludeHeader := true;
            RecalculateLines := false;
        end;
    }
}
