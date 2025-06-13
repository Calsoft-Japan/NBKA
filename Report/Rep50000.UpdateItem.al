report 50000 "Update Blocked on Item"
{
    ApplicationArea = All;
    Caption = 'Update Blocked on Item';
    UsageCategory = Tasks;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnPreDataItem()
            begin
                //Process before reading record
            end;

            trigger OnAfterGetRecord()
            var
            begin
                //Process for each Item record
                if ("Effective date" <> 0D) and ("Expiration Date" <> 0D) then begin
                    if ("Effective Date" > "Expiration Date") then begin
                        Error('Effective Date must not be after Expiration Date')
                    end;

                    // Update Blocked status based on the dates
                    if ("Effective Date" <= Today) and ("Expiration Date" >= Today) then
                        Blocked := false
                    else
                        Blocked := true;

                    // Save the updated record
                    Modify();
                end;
            end;

            trigger OnPostDataItem()
            begin
                //Process after reading record
            end;
        }
    }

    var
        blnShowErr: Boolean;

}
