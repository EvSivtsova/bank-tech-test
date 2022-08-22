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

  context "when withdrawing money" do
    it "records the withdrawal transactions" do
      bank_account = BankAccount.new
      bank_account.withdraw(1000, '10-01-2023')
      expect(bank_account.get_transactions[0]).to include({date: '10-01-2023', value: -1000})
    end
  end
  
  context "when both depositing and withdrawing money" do
    it "records withdrawal and deposit transations" do
      time_double = Time.new(2022, 8, 22, 16, 21, 12).strftime('%d-%m-%Y')
      bank_account = BankAccount.new
      bank_account.deposit(1000, time_double)
      bank_account.withdraw(500, '11-01-2023')
      bank_account.deposit(3000, '12-01-2023')
      bank_account.withdraw(2000, '13-01-2023')
      expect(bank_account.get_transactions[0]).to include({date: '22-08-2022', value: 1000})
      expect(bank_account.get_transactions[1]).to include({date: '11-01-2023', value: -500})
      expect(bank_account.get_transactions[2]).to include({date: '12-01-2023', value: 3000})
      expect(bank_account.get_transactions[3]).to include({date: '13-01-2023', value: -2000})
    end
  end
 
end