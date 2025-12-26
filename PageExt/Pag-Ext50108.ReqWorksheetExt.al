namespace NBKA.NBKA;

using Microsoft.Inventory.Requisition;
using Microsoft.Sales.Document;

pageextension 50108 ReqWorksheetExt extends "Req. Worksheet"
{
    actions
    {
        modify("Get &Sales Orders")
        {
            Visible = false;
        }
        modify(Action53)
        {
            Visible = false;
        }
        addafter("Get &Sales Orders")
        {
            action("Get Sales Order")
            {
                ApplicationArea = all;
                Caption = 'Get &Sales Orders';
                Ellipsis = true;
                Image = "Order";
                ToolTip = 'Copy sales lines to the requisition worksheet. You can use the batch job to create requisition worksheet proposal lines from sales lines for drop shipments or special orders.';

                trigger OnAction()
                begin
                    GetSalesOrderNew.SetReqWkshLine(Rec, 0);
                    GetSalesOrderNew.RunModal();
                    Clear(GetSalesOrderNew);
                end;
            }
        }
        addafter(Action53)
        {
            action("Get Sales Orders")
            {
                ApplicationArea = all;
                Caption = 'Get &Sales Orders';
                Ellipsis = true;
                Image = "Order";
                ToolTip = 'Copy sales lines to the requisition worksheet. You can use the batch job to create requisition worksheet proposal lines from sales lines for drop shipments or special orders.';

                trigger OnAction()
                begin
                    GetSalesOrderNew.SetReqWkshLine(Rec, 1);
                    GetSalesOrderNew.RunModal();
                    Clear(GetSalesOrderNew);
                end;
            }
        }
        addafter(Action53_Promoted)
        {
            actionref(Getsalesorders_Promoted; "Get Sales Orders")
            {

            }

        }
        addafter("Get &Sales Orders_Promoted")
        {
            actionref(Getsalesorder_Promoted; "Get Sales Order")
            {

            }
        }
    }

    var
        GetSalesOrderNew: Report GetSalesOrdersNew;
}