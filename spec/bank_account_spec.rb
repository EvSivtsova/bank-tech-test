require 'bank_account'

describe BankAccount do
  context 'when depositing money' do
    it 'records and returns the value and the date of the transactions' do
      io = double :io
      expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, '10/01/2023')
      bank_account.bank_statement
    end

    it 'updates the balance of the account when several transaction have been made' do
      time_double = Time.new(2022, 8, 22, 16, 21, 12).strftime('%d/%m/%Y')
      io = double :io
      expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(io).to receive(:puts).with('22/08/2022 || 2000.00 || || 3000.00').ordered
      expect(io).to receive(:puts).with('10/01/2022 || 1000.00 || || 1000.00').ordered
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, '10/01/2022')
      bank_account.deposit(2000, time_double)
      bank_account.bank_statement
    end
  end

  context 'when withdrawing money' do
    it 'records the withdrawal transactions' do
      io = double :io
      expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(io).to receive(:puts).with('10/01/2023 || || 1000.00 || -1000.00').ordered
      bank_account = BankAccount.new(io)
      bank_account.withdraw(1000, '10/01/2023')
      bank_account.bank_statement
    end

    it 'updates the balance when several transaction have been made' do
      time_double = Time.new(2022, 8, 23, 16, 21, 12).strftime('%d/%m/%Y')
      io = double :io
      expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(io).to receive(:puts).with('23/08/2022 || || 500.00 || -1500.00').ordered
      expect(io).to receive(:puts).with('22/08/2022 || || 1000.00 || -1000.00').ordered
      bank_account = BankAccount.new(io)
      bank_account.withdraw(1000, '22/08/2022')
      bank_account.withdraw(500, time_double)
      bank_account.bank_statement
    end
  end

  context 'when both depositing and withdrawing money' do
    it 'provides a list of transactions with updated balance sorted by date in reverse order' do
      io = double :io
      expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(io).to receive(:puts).with('14/01/2023 || || 500.00 || 2500.00').ordered
      expect(io).to receive(:puts).with('13/01/2023 || 2000.00 || || 3000.00').ordered
      expect(io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, '10/01/2023')
      bank_account.deposit(2000, '13/01/2023')
      bank_account.withdraw(500, '14/01/2023')
      bank_account.bank_statement
    end

    it 'sorts the transactions by date from latest to earliest' do
      io = double :io
      expect(io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(io).to receive(:puts).with('14/01/2023 || || 500.00 || 2500.00').ordered
      expect(io).to receive(:puts).with('13/01/2023 || 2000.00 || || 3000.00').ordered
      expect(io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered
      bank_account = BankAccount.new(io)
      bank_account.deposit(1000, '10/01/2023')
      bank_account.withdraw(500, '14/01/2023')
      bank_account.deposit(2000, '13/01/2023')
      bank_account.bank_statement
    end
  end
end
