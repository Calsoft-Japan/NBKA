report 50001 "Customer List Report"
{
    Caption = 'Customer List Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'CustomerListReport.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column("No"; "No.") { }
            column(Name; Name) { }
            column(Balance; "Balance (LCY)") { }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field("Show Only Blocked"; ShowOnlyBlocked)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    var
        ShowOnlyBlocked: Boolean;
}
