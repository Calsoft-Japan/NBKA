//FDD300 Page Ext for NBKA API Data Menu
pageextension 50023 "NBKA API Data Menu" extends "Administrator Main Role Center"
{
    actions
    {
        addbefore(Group9)
        {
            group("NBKA API Data")
            {
                //FDD301
                action("NBKA API INSTOKUCD")
                {
                    ApplicationArea = All;
                    RunObject = page NBK_INSTOKUCD;
                }
                //FDD303
                action("NBKA API INS")
                {
                    ApplicationArea = All;
                    RunObject = page NBK_INS;
                }
                //FDD304
                action("NBKA API DEL")
                {
                    ApplicationArea = All;
                    RunObject = page NBK_DEL;
                }
                //FDD305
                action("NBKA API ANNOKI")
                {
                    ApplicationArea = All;
                    RunObject = page NBK_ANNOKI;
                }
                //FDD306
                action("NBKA API SYKA")
                {
                    ApplicationArea = All;
                    RunObject = page NBK_SYKA;
                }
                //FDD307
                action("NBKA API ORDSTS")
                {
                    ApplicationArea = All;
                    RunObject = page NBK_ORDSTS;
                }
                //FDD308
                action("NBKA API CHKITEM")
                {
                    ApplicationArea = All;
                    RunObject = page NBK_CHKITEM;
                }
            }
        }
    }
}
