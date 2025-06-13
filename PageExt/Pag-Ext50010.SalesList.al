pageextension 50010 SalesListExtReleasedQuotesOnly extends "Sales List"
{
    trigger OnOpenPage()
    begin
        if (CurrPage.LookupMode) and (Rec."Document Type" = Rec."Document Type"::Quote) then
            Rec.SetRange(Status, Rec.Status::Released);
    end;
}
