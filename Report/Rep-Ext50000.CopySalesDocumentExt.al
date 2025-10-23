namespace NBKA.NBKA;

using Microsoft.Sales.Document;

reportextension 50000 CopySalesDocumentExt extends "Copy Sales Document"
{
    requestpage
    {
        layout
        {
            modify(DocumentType)
            {
                trigger OnAfterValidate()
                begin
                    UpdateEditableFields();
                end;
            }
            modify(IncludeHeader_Options)
            {
                Editable = IncludeHeaderEditable;
            }

            modify(RecalculateLines)
            {
                Editable = RecalculateLinesEditable;
            }
        }

        trigger OnOpenPage()
        begin
            IncludeHeader := true;
            RecalculateLines := false;
            UpdateEditableFields();
        end;

    }
    local procedure UpdateEditableFields()
    begin
        if (FromDocType = FromDocType::Order) or (FromDocType = FromDocType::Quote) then begin
            IncludeHeaderEditable := false;
            RecalculateLinesEditable := false;
        end else begin
            IncludeHeaderEditable := true;
            RecalculateLinesEditable := true;
        end;
    end;

    var
        IncludeHeaderEditable: Boolean;
        RecalculateLinesEditable: Boolean;
}
