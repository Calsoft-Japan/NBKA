codeunit 50007 BusinessEventHandler
{
    [ExternalBusinessEvent('CustomerTaxLiableOnValidte', 'Customer Tax Liable OnValidate', 'Triggered when tax liable is validated', EventCategory::Sales)]
    procedure CustomerTaxLiableOnValidate(customerID: Guid)
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, OnAfterValidateEvent, 'Tax Liable', false, false)]
    local procedure CustTaxLiableOnValidate(var Rec: Record Customer)
    begin
        CustomerTaxLiableOnValidate(Rec.SystemId);
    end;
}
