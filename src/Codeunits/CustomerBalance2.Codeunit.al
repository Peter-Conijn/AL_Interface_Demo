codeunit 50161 "Customer Balance Due" implements ICustomerBalance
{
    procedure GetCustomerName(CustomerNo: Code[20]): Text
    var
        Customer: Record Customer;
    begin
        Customer.SetLoadFields(Name);
        if Customer.Get(CustomerNo) then
            exit(Customer.Name);
    end;

    procedure GetCustomerBalance(CustomerNo: Code[20]): Decimal
    begin
        exit(CalculateCustomerBalanceDue(CustomerNo));
    end;

    procedure GetCustomerBalanceFCY(CustomerNo: Code[20]; CurrencyCode: Code[10]): Decimal
    var
        Customer: Record Customer;
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CustomerBalanceDueLCY: Decimal;
    begin
        CustomerBalanceDueLCY := CalculateCustomerBalanceDue(CustomerNo);
        Currency.SetLoadFields("Currency Factor");
        if Currency.Get(CurrencyCode) then
            exit(CurrencyExchangeRate.ExchangeAmtLCYToFCY(WorkDate(), CurrencyCode, CustomerBalanceDueLCY, CurrencyExchangeRate.GetCurrentCurrencyFactor(CurrencyCode)));
        exit(CustomerBalanceDueLCY);
    end;

    local procedure CalculateCustomerBalanceDue(var CustomerNo: Code[20]): Decimal
    var
        Customer: Record Customer;
    begin
        Customer.SetLoadFields("Balance Due (LCY)");
        Customer.SetRange("Date Filter", WorkDate());
        Customer.SetAutoCalcFields("Balance Due (LCY)");
        if Customer.Get(CustomerNo) then
            exit(Customer."Balance Due (LCY)");
    end;
}