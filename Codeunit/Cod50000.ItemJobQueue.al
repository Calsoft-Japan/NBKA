codeunit 50000 "Update Blocked Items"
{
    Subtype = Normal;

    trigger OnRun()
    var
        ItemRec: Record Item;
    begin
        // Process each item
        if ItemRec.FindSet() then begin
            repeat
                // Validate Effective and Expiration Dates
                if (ItemRec."Effective Date" <> 0D) and (ItemRec."Expiration Date" <> 0D) then begin

                    // Determine Blocked status
                    if (ItemRec."Effective Date" <= Today) and (ItemRec."Expiration Date" >= Today) then begin
                        if ItemRec.Blocked then begin
                            ItemRec.Blocked := false;
                            ItemRec.Modify();
                        end;
                    end else begin
                        if not ItemRec.Blocked then begin
                            ItemRec.Blocked := true;
                            ItemRec.Modify();
                        end;
                    end;
                end;
            until ItemRec.Next() = 0;
        end;
    end;
}
