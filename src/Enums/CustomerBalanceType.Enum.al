enum 50160 "Customer Balance Type" implements "ICustomerBalance"
{
    Extensible = true;
    //DefaultImplementation = ICustomerBalance = "Customer Balance";

    value(0; Balance)
    {
        Caption = 'Balance';
        Implementation = ICustomerBalance = "Customer Balance";
    }
    value(1; "Balance Due")
    {
        Caption = 'Balance Due';
        Implementation = ICustomerBalance = "Customer Balance Due";
    }

}