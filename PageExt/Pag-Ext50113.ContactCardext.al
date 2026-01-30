namespace NBKA.NBKA;

using Microsoft.CRM.Contact;

pageextension 50113 ContactCardext extends "Contact Card"
{
    layout
    {
        modify("No.")
        {
            ShowMandatory = true;
        }
        modify("Contact Business Relation")
        {
            ShowMandatory = true;
        }
        modify("E-Mail")
        {
            ShowMandatory = true;
        }
    }
}
