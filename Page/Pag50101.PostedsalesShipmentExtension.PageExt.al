pageextension 50101 PostedsalesShipmentExtension extends "Posted Sales Shipment"
{
    actions
    {
        addafter("&Track Package")
        {
            action(PrintCoC)
            {
                Caption = 'Print CoC';
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                var
                    SalesShipmentHeader: Record "Sales Shipment Header";
                begin
                    SalesShipmentHeader.Reset();
                    SalesShipmentHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::CertificateofConformanceReport, true, true, SalesShipmentHeader);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(PrintCoC_Promoted; PrintCoC)
            {
            }
        }
    }
}
