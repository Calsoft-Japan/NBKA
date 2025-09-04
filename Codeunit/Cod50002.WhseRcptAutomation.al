namespace NBKA.NBKA;

using Microsoft.Projects.RoleCenters;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Request;
using System.Threading;

codeunit 50002 WhseRcptAutomation
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        If UpperCase(Rec."Parameter String") = 'CREATE' then
            CreateWarehouseRcpt()
        else If UpperCase(Rec."Parameter String") = 'DELETE' then
            DeleteWarehouseRcpt();
    end;

    procedure CreateWarehouseRcpt()
    var
        WhseRcptHdr: Record "Warehouse Receipt Header";
        WarehouseRequest: Record "Warehouse Request";
        GetSourceDocuments: Report "Get Source Documents";
    begin
        WhseRcptHdr.Init();
        WhseRcptHdr.Validate("Location Code", 'NBKAM');
        WhseRcptHdr.Validate("Posting Date", Today);
        if WhseRcptHdr.Insert(true) then begin
            WarehouseRequest.FilterGroup(2);
            WarehouseRequest.SetRange(Type, WarehouseRequest.Type::Inbound);
            WarehouseRequest.SetRange("Location Code", WhseRcptHdr."Location Code");
            WarehouseRequest.FilterGroup(0);
            WarehouseRequest.SetRange("Document Status", WarehouseRequest."Document Status"::Released);
            WarehouseRequest.SetRange("Completely Handled", false);

            GetSourceDocuments.SetOneCreatedReceiptHeader(WhseRcptHdr);
            GetSourceDocuments.UseRequestPage(false);
            GetSourceDocuments.SetTableView(WarehouseRequest);
            GetSourceDocuments.RunModal();

            WhseRcptHdr."Document Status" := WhseRcptHdr.GetHeaderStatus(0);
            WhseRcptHdr.Modify();
        end;
    end;

    procedure DeleteWarehouseRcpt()
    var
        WhseRcptHdr: Record "Warehouse Receipt Header";
    begin
        WhseRcptHdr.Reset();
        if WhseRcptHdr.FindSet() then
            repeat
                WhseRcptHdr.Delete(true);
            until WhseRcptHdr.Next() = 0;
    end;
}
