codeunit 50101 SingleInstance
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;
    procedure SetWarehouseRequestDate(ToBeShippedBY: date)
    begin
        ToBeShippedBY2:=ToBeShippedBY;
    end;
    procedure GetWarehouseRequestDate(var ToBeShippedBY: date)
    begin
        ToBeShippedBY:=ToBeShippedBY2;
    end;
    procedure ClearWarehouseRequestDate()
    begin
        clear(ToBeShippedBY2);
    end;
    procedure SetToPickBin(ToBinCodeP: Code[20])
    begin
        ToBinCode:=ToBinCodeP;
    end;
    procedure GetToPickBin(var ToBinCodeP: Code[20])
    begin
        ToBinCodeP:=ToBinCode;
    end;
    procedure ClearToPickBin()
    begin
        clear(ToBinCode);
    end;
    procedure SetFromPickBin(FromBinCodeP: Code[20])
    begin
        FromBinCode:=FromBinCodeP;
    end;
    procedure GetFromPickBin(var FromBinCodeP: Code[20])
    begin
        FromBinCodeP:=FromBinCode;
    end;
    procedure ClearFromPickBin()
    begin
        clear(FromBinCode);
    end;
    procedure SetWarehouseShipmentLine(WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
        gWarehouseShipmentLine:=WarehouseShipmentLine;
    end;
    procedure GetWarehouseShipmentLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
        WarehouseShipmentLine:=gWarehouseShipmentLine;
    end;
    procedure ClearWarehouseShipmentLine()
    begin
        clear(gWarehouseShipmentLine);
    end;
    var ToBeShippedBY2: date;
    gWarehouseShipmentLine: Record "Warehouse Shipment Line";
    ToBinCode: Code[20];
    FromBinCode: Code[20];
}
