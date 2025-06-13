tableextension 50000 "Item Ext" extends "Item"
{
    fields
    {
        //Adding Effective Date field 
        field(50000; "Effective Date"; Date)
        {
            ToolTip = 'Specifies the date when Blocked will be deactivated.';
            trigger OnValidate()

            begin
                // Call the procedure to update blocked status
                UpdateBlockedField(Rec);
            end;

        }

        field(50001; "Expiration Date"; Date)
        {
            ToolTip = 'Specifies the date one day before Blocked will be activated';

            trigger OnValidate()

            begin
                // Call the procedure to update blocked status
                UpdateBlockedField(Rec);
            end;

        }

        field(50002; "P/N"; Code[50])
        {
            ToolTip = 'Specifies P/N of the item';
        }

        field(50003; "Web Product No."; Code[50])
        {
            ToolTip = 'Specifies the date one day before Blocked will be activated';
        }

        field(50004; "Special Product"; Boolean)
        {
            ToolTip = 'Specifies if the item is special product';
        }
    }

    trigger OnInsert()
    begin
        Rec.Validate(Blocked, true);
    end;


    procedure UpdateBlockedField(var ItemRec: Record "Item")

    begin
        //Check if today is within the Effective and Expiration date range
        if (ItemRec."Effective Date" <> 0D) and (ItemRec."Expiration Date" <> 0D) then begin

            // Validate that Effective Date is not after Expiration Date
            if ItemRec."Effective Date" > ItemRec."Expiration Date" then
                Error('Effective Date must not be after Expiration Date');

            if (ItemRec."Effective Date" <= Today) and (ItemRec."Expiration Date" >= Today) then
                ItemRec.Validate(Blocked, false)
            else
                ItemRec.Validate(Blocked, true);

            // Only modify the record if Blocked status is changed
            if ItemRec."Blocked" <> Rec."Blocked" then
                ItemRec.Modify();
        end;
    end;
}

