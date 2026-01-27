namespace NBKA.NBKA;

pageextension 50112 DSHIPPackageOptionsCardext extends "DSHIP Package Options Card"
{
    layout
    {
        modify("Payment Type")
        {
            ShowMandatory = true;
        }
        modify("Payment Account")
        {
            ShowMandatory = true;
        }
        modify("Payment Postal Code")
        {
            ShowMandatory = true;
        }
        modify("Payment Province")
        {
            ShowMandatory = true;
        }
        modify("Payment Country")
        {
            ShowMandatory = true;
        }
        modify(LPNo)
        {
            ShowMandatory = true;
        }

    }
}
