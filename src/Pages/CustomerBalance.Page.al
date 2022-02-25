page 50160 "Customer Balance"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Settings)
            {
                Caption = 'Settings';

                field(CustomerNoControl; CustomerNo)
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the customer no.';
                    TableRelation = Customer;
                }
                field(CurrencyControl; CurrencyCode)
                {
                    ApplicationArea = All;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the currency code to use for the FCY amount.';
                    TableRelation = Currency;
                }
                field(CalculationControl; CustomerBalanceType)
                {
                    ApplicationArea = All;
                    Caption = 'Calculation';
                    ToolTip = 'Specifies the calculation to use.';
                }
            }
            group(BalanceGroup)
            {
                Caption = 'Balance';

                field(CustomerNameControl; CustomerName)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                    Editable = false;
                }
                field(CustomerBalanceControl; CustomerBalance)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Balance';
                    Editable = false;
                }
                field(CustomerBalanceFCYControl; CustomerBalanceFCY)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Balance (FCY)';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = All;
                Caption = 'Calculate Balance';
                Image = Balance;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (CustomerNo <> '') and (CurrencyCode <> '');

                trigger OnAction()
                begin
                    CalculateBalance();
                end;
            }
        }
    }

    local procedure CalculateBalance()
    var
        ICustomerBalance: Interface ICustomerBalance;
    begin
        ICustomerBalance := CustomerBalanceType;

        CustomerBalance := ICustomerBalance.GetCustomerBalance(CustomerNo);
        CustomerBalanceFCY := ICustomerBalance.GetCustomerBalanceFCY(CustomerNo, CurrencyCode);
        CustomerName := ICustomerBalance.GetCustomerName(CustomerNo);
    end;

    var
        CustomerBalance: Decimal;
        CustomerBalanceFCY: Decimal;
        CustomerBalanceType: Enum "Customer Balance Type";
        CustomerName: Text;
        CustomerNo: Code[20];
        CurrencyCode: Code[10];
}