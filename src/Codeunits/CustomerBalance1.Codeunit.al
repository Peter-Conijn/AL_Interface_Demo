codeunit 50160 "Customer Balance" implements ICustomerBalance
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
        exit(CalculateCustomerBalance(CustomerNo));
    end;

    procedure GetCustomerBalanceFCY(CustomerNo: Code[20]; CurrencyCode: Code[10]): Decimal
    var
        Customer: Record Customer;
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CustomerBalanceLCY: Decimal;
    begin
        CustomerBalanceLCY := CalculateCustomerBalance(CustomerNo);
        Currency.SetLoadFields("Code");
        if Currency.Get(CurrencyCode) then
            exit(CurrencyExchangeRate.ExchangeAmtLCYToFCY(WorkDate(), CurrencyCode, CustomerBalanceLCY, CurrencyExchangeRate.GetCurrentCurrencyFactor(CurrencyCode)));
        exit(CustomerBalanceLCY);
    end;

    local procedure CalculateCustomerBalance(var CustomerNo: Code[20]): Decimal
    var
        Customer: Record Customer;
    begin
        Customer.SetLoadFields("Balance (LCY)");
        Customer.SetRange("Date Filter", WorkDate());
        Customer.SetAutoCalcFields("Balance (LCY)");
        if Customer.Get(CustomerNo) then
            exit(Customer."Balance (LCY)");
    end;
}