tableextension 50003 "SalesHeader Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "EC Order"; Boolean)
        {
            ToolTip = 'Indicate whether it was received from EC';
            Caption = 'EC Order';
            DataClassification = ToBeClassified;
        }
        field(50001; "Special Order Work"; Boolean)
        {
            ToolTip = 'If the customer requires Special Order Work';
            Caption = 'Special Order Work';
            DataClassification = ToBeClassified;
        }
        field(50002; "Special Order Work Completed"; Boolean)
        {
            ToolTip = 'If Special Order Work is completed';
            Caption = 'Special Order Work Completed';
            DataClassification = ToBeClassified;
        }
        field(50003; "Special Shipping Work"; Boolean)
        {
            ToolTip = 'If the customer requires Special Shipping Work';
            Caption = 'Special Shipping Work';
            DataClassification = ToBeClassified;
        }
        field(50004; "Special Shipping Completed"; Boolean)
        {
            ToolTip = 'If Special Shipping Work is completed';
            Caption = 'Special Shipping Work Completed';
            DataClassification = ToBeClassified;
        }


    }


}

//----------------------------------------------------------------------------
// trigger OnBeforeModify()
// var
//     Customer: Record Customer;
//     SalesLine: Record "Sales Line";
// begin
//     // Logic 1: Special Order Work - When Customer No. is updated
//     if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then begin
//         if Customer.Get(Rec."Sell-to Customer No.") then begin
//             Rec."Special Order Work" := Customer."Special Order Work";
//             Rec."Special Shipping Work" := Customer."Special Shipping Work";
//         end;
//     end;

// // Logic 2 & 3: When Status changes from Open to Released
// if (Rec.Status = Rec.Status::Released) and (xRec.Status = Rec.Status::Open) then begin
//     if Rec."Special Order Work" and not Rec."Special Order Work Completed" then begin

//         // Revert the status back to Open
//         Rec.Status := Rec.Status::Open;

//         Error('Special Order Work is not completed.');

//         SalesLine.Reset();
//         SalesLine.SetRange("Document Type", Rec."Document Type");
//         SalesLine.SetRange("Document No.", Rec."No.");
//         if SalesLine.FindSet() then
//             repeat
//                 if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."No." = 'JB-FREIGHT') then begin
//                     Rec."Shipping Advice" := Rec."Shipping Advice"::Complete;
//                     exit;
//                 end;
//             until SalesLine.Next() = 0;
//     end;
// end;



//end;







