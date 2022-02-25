interface "ICustomerBalance"
{
    procedure GetCustomerName(CustomerNo: Code[20]): Text
    procedure GetCustomerBalance(CustomerNo: Code[20]): Decimal
    procedure GetCustomerBalanceFCY(CustomerNo: Code[20]; CurrencyCode: Code[10]): Decimal

}