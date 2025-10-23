namespace NBKA.NBKA;
using Microsoft.Foundation.Reporting;

codeunit 50004 ReportPdfFileName
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, OnGetFilename, '', false, false)]
    local procedure OnGetFilename(ReportID: Integer; Caption: Text[250]; ObjectPayload: JsonObject; FileExtension: Text[30]; ReportRecordRef: RecordRef; var Filename: Text; var Success: Boolean)
    var
        FieldRef: FieldRef;
        DocumentNo: Text[100];
        JsonToken: JsonToken;
        Intent: Text;
    begin
        if ObjectPayload.Get('intent', JsonToken) then
            Intent := JsonToken.AsValue().AsText();

        if UpperCase(Intent) = UpperCase('Download') then begin
            case ReportID of
                50102:
                    begin
                        FieldRef := ReportRecordRef.Field(3);
                        DocumentNo := FieldRef.Value;
                        Filename := Caption + '_' + DocumentNo + FileExtension;
                        Success := true;
                    end;
                50103:
                    begin
                        FieldRef := ReportRecordRef.Field(3);
                        DocumentNo := FieldRef.Value;
                        Filename := Caption + '_' + DocumentNo + FileExtension;
                        Success := true;
                    end;
                50104:
                    begin
                        FieldRef := ReportRecordRef.Field(3);
                        DocumentNo := FieldRef.Value;
                        Filename := Caption + '_' + DocumentNo + FileExtension;
                        Success := true;
                    end;
                50105:
                    begin
                        FieldRef := ReportRecordRef.Field(3);
                        DocumentNo := FieldRef.Value;
                        Filename := Caption + '_' + DocumentNo + FileExtension;
                        Success := true;
                    end;
                50106:
                    begin
                        FieldRef := ReportRecordRef.Field(3);
                        DocumentNo := FieldRef.Value;
                        Filename := Caption + '_' + DocumentNo + FileExtension;
                        Success := true;
                    end;
                50107:
                    begin
                        FieldRef := ReportRecordRef.Field(3);
                        DocumentNo := FieldRef.Value;
                        Filename := Caption + '_' + DocumentNo + FileExtension;
                        Success := true;
                    end;
                50108:
                    begin
                        FieldRef := ReportRecordRef.Field(1);
                        DocumentNo := FieldRef.Value;
                        Filename := Caption + '_' + DocumentNo + FileExtension;
                        Success := true;
                    end;


            end
        end;
    end;
}
