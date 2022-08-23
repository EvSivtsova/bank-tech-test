require 'bank_account'

describe BankAccount do
  context "when depositing money" do
    it "records and returns the value and the date of the transactions" do
      io = double :io
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, '10/01/2023')
      expect(bank_account.get_transactions[0]).to include({date: '10/01/2023', value: 1000, balance: 1000})
    end
    
    it "updates the balance of the account" do
      io = double :io
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, '10/01/2023')
      expect(bank_account.get_balance).to eq 1000
    end
    
    it "updates the balance of the account when several transaction have been made" do
      time_double = Time.new(2022, 8, 22, 16, 21, 12).strftime('%d/%m/%Y')
      io = double :io
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, '10/01/2023')
      bank_account.deposit(2000, time_double)
      expect(bank_account.get_balance).to eq 3000
      expect(bank_account.get_transactions[1]).to include({date: '22/08/2022', value: 2000, balance: 3000})
    end
  end
  
  context "when withdrawing money" do
    it "records the withdrawal transactions" do
      io = double :io
      bank_account = BankAccount.new(io)
      bank_account.withdraw(1000, '10/01/2023')
      expect(bank_account.get_transactions[0]).to include({date: '10/01/2023', value: -1000, balance: -1000})
    end
    
    it "updates the balance" do
      io = double :io
      bank_account = BankAccount.new(io)
      bank_account.withdraw(1000)
      expect(bank_account.get_balance).to eq -1000
    end
    
    it "updates the balance when several transaction have been made" do
      time_double = Time.new(2022, 8, 23, 16, 21, 12).strftime('%d/%m/%Y')
      io = double :io
      bank_account = BankAccount.new(io)
      bank_account.withdraw(1000)
      bank_account.withdraw(500, time_double)
      expect(bank_account.get_balance).to eq -1500
      expect(bank_account.get_transactions[1]).to include({date: '23/08/2022', value: -500, balance: -1500})
    end
 
  end
  
  context "when both depositing and withdrawing money" do
    it "records withdrawal and deposit transations" do
      time_double = Time.new(2022, 8, 22, 16, 21, 12).strftime('%d/%m/%Y')
      io = double :io
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, time_double)
      bank_account.withdraw(500, '11/01/2023')
      bank_account.deposit(3000, '12/01/2023')
      bank_account.withdraw(2000, '13/01/2023')
      expect(bank_account.get_transactions[0]).to include({date: '22/08/2022', value: 1000, balance: 1000})
      expect(bank_account.get_transactions[1]).to include({date: '11/01/2023', value: -500, balance: 500})
      expect(bank_account.get_transactions[2]).to include({date: '12/01/2023', value: 3000, balance: 3500})
      expect(bank_account.get_transactions[3]).to include({date: '13/01/2023', value: -2000, balance: 1500})
    end

    it "updates the balance" do
      io = double :io
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000)
      bank_account.withdraw(500)
      bank_account.deposit(3000)
      bank_account.withdraw(2000)
      expect(bank_account.get_balance).to eq 1500
    end
  end

  context "when priting a bank statement" do
    it "provides a list of transactions with updates balance sorted by date in reverse order" do
      io = double :io
      expect(io).to receive(:puts).with("date || credit || debit || balance").ordered
      expect(io).to receive(:puts).with("14/01/2023 || || 500.00 || 2500.00").ordered
      expect(io).to receive(:puts).with("13/01/2023 || 2000.00 || || 3000.00").ordered
      expect(io).to receive(:puts).with("10/01/2023 || 1000.00 || || 1000.00").ordered
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, '10/01/2023')
      bank_account.deposit(2000, '13/01/2023')
      bank_account.withdraw(500, '14/01/2023')
      bank_account.get_bank_statement
    end
  end
end