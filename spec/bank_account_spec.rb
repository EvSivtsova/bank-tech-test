require 'bank_account'

describe BankAccount do
  context "when depositing money" do
    it "records and returns the value and the date of the transactions" do
      bank_account = BankAccount.new
      bank_account.deposit(1000, '10-01-2023')
      expect(bank_account.get_transactions[0]).to include({date: '10-01-2023', value: 1000})
    end
    
    it "updates the balance of the account" do
      bank_account = BankAccount.new
      bank_account.deposit(1000, '10-01-2023')
      expect(bank_account.get_balance).to eq 1000
    end
    
    it "updates the balance of the account when several transaction have been made" do
      time_double = Time.new(2022, 8, 22, 16, 21, 12).strftime('%d-%m-%Y')
      bank_account = BankAccount.new
      bank_account.deposit(1000, '10-01-2023')
      bank_account.deposit(2000, time_double)
      expect(bank_account.get_balance).to eq 3000
      expect(bank_account.get_transactions[1]).to include({date: '22-08-2022', value: 2000})
    end
  end
end