require 'bank_account'

describe BankAccount do
  it "records and returns the value and the date of the deposit transaction " do
    bank_account = BankAccount.new
    bank_account.deposit(1000, '10-01-2023')
    expect(bank_account.get_transactions).to include 1000
    expect(bank_account.get_transactions).to include '10-01-2023'
  end
end
  