namespace NBKAExtension_CalsoftSystems_.NBKAExtension_CalsoftSystems_;

using Microsoft.Sales.History;

pageextension 50102 PostedSalesShptSubformext extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Certificate of Conformance"; Rec."Certificate of Conformance")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'Gets the certificate of conformance value from sales line';
            }
        }
    }
    actions
    {
        addafter(DocumentLineTracking)
        {
            action(PrintCoC)
            {
                Caption = 'Print CoC';
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var
                    CocReport: Report CertificateofConformanceReport;
                begin
                    Rec.TestField("Certificate of Conformance", true);
                    Clear(CocReport);
                    CocReport.SetFilters(Rec."Document No.", Format(Rec."Line No."));
                    CocReport.Run();
                end;
            }
        }
    }
}