page 50002 "User Signature Part"
{
    PageType = CardPart;
    SourceTable = "User Setup";
    Caption = 'User Signature Part';
    ApplicationArea = All;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            field(Picture; Rec."User Signature")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                Caption = 'Import';
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ImportFromDevice();
                end;
            }

            action(DeletePicture)
            {
                Caption = 'Delete';
                Image = Delete;
                ApplicationArea = All;
                Enabled = DeleteExportEnabled;

                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    var
        DeleteExportEnabled: Boolean;
        SelectPictureTxt: Label 'Select a picture to upload';
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."User Signature".Count > 0;
    end;

    procedure ImportFromDevice()
    var
        InStr: InStream;
        ClientFileName, FileName : Text;
        FileMgt: Codeunit "File Management";
    begin
        if Rec."User Signature".Count > 0 then
            if not Confirm(OverrideImageQst) then
                exit;

        UploadIntoStream(SelectPictureTxt, '', '', ClientFileName, InStr);
        if ClientFileName = '' then
            exit;

        FileName := FileMgt.GetFileName(ClientFileName);
        Clear(Rec."User Signature");
        Rec."User Signature".ImportStream(InStr, FileName);
        Rec.Modify(true);
    end;

    procedure DeleteItemPicture()
    begin
        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec."User Signature");
        Rec.Modify(true);
    end;
}
