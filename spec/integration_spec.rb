require_relative '../bank_account'

describe BankAccount do
  before :each do
    @io = double :io
    @bank_account = BankAccount.new(@io)
  end

  context 'when depositing money' do
    it 'is an instance of BankAccount class' do
      expect(@bank_account).to be_instance_of(BankAccount)
    end

    it 'records and returns the value and the date of the transactions' do
      expect(@io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(@io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered
      @bank_account.deposit(1000, '10/01/2023')
      @bank_account.bank_statement
    end

    it 'updates the balance of the account when several transaction have been made' do
      time_double = Time.new(2022, 8, 22, 16, 21, 12).strftime('%d/%m/%Y')
      expect(@io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(@io).to receive(:puts).with('22/08/2022 || 2000.00 || || 3000.00').ordered
      expect(@io).to receive(:puts).with('10/01/2022 || 1000.00 || || 1000.00').ordered
      @bank_account.deposit(1000, '10/01/2022')
      @bank_account.deposit(2000, time_double)
      @bank_account.bank_statement
    end
  end

  context 'when withdrawing money' do
    it 'records the withdrawal transactions' do
      expect(@io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(@io).to receive(:puts).with('10/01/2023 || || 1000.00 || -1000.00').ordered
      @bank_account.withdraw(1000, '10/01/2023')
      @bank_account.bank_statement
    end

    it 'updates the balance when several transaction have been made' do
      time_double = Time.new(2022, 8, 23, 16, 21, 12).strftime('%d/%m/%Y')
      expect(@io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(@io).to receive(:puts).with('23/08/2022 || || 500.00 || -1500.00').ordered
      expect(@io).to receive(:puts).with('22/08/2022 || || 1000.00 || -1000.00').ordered
      @bank_account.withdraw(1000, '22/08/2022')
      @bank_account.withdraw(500, time_double)
      @bank_account.bank_statement
    end
  end

  context 'when both depositing and withdrawing money' do
    it 'provides a list of transactions with updated balance sorted by date in reverse order' do
      expect(@io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(@io).to receive(:puts).with('14/01/2023 || || 500.00 || 2500.00').ordered
      expect(@io).to receive(:puts).with('13/01/2023 || 2000.00 || || 3000.00').ordered
      expect(@io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered
      @bank_account.deposit(1000, '10/01/2023')
      @bank_account.deposit(2000, '13/01/2023')
      @bank_account.withdraw(500, '14/01/2023')
      @bank_account.bank_statement
    end

    it 'sorts the transactions by date from latest to earliest' do
      expect(@io).to receive(:puts).with('date || credit || debit || balance').ordered
      expect(@io).to receive(:puts).with('14/01/2023 || || 500.00 || 2500.00').ordered
      expect(@io).to receive(:puts).with('13/01/2023 || 2000.00 || || 3000.00').ordered
      expect(@io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered
      @bank_account.deposit(1000, '10/01/2023')
      @bank_account.withdraw(500, '14/01/2023')
      @bank_account.deposit(2000, '13/01/2023')
      @bank_account.bank_statement
    end
  end

  context 'when inputing data manually' do
    it 'raises error when date is incorrect' do
      expect { @bank_account.deposit(1000, '17/01/2023') }.to_not raise_error
      expect { @bank_account.deposit(1000, '10-06-2023') }
        .to raise_error 'Please insert date in the following format: DD/MM/YY'
      expect { @bank_account.deposit(1000, '2023-06-10') }
        .to raise_error 'Please insert date in the following format: DD/MM/YY'
      expect { @bank_account.deposit(1000, 'date') }.to raise_error(Date::Error)

      expect { @bank_account.withdraw(500, '14/01/2023') }.to_not raise_error
      expect { @bank_account.withdraw(1000, '10-06-2023') }
        .to raise_error 'Please insert date in the following format: DD/MM/YY'
      expect { @bank_account.withdraw(1000, '2023-06-10') }
        .to raise_error 'Please insert date in the following format: DD/MM/YY'
      expect { @bank_account.withdraw(1000, 'date') }.to raise_error(Date::Error)
    end

    it 'raises error when value of transaction is not a number' do
      expect { @bank_account.deposit(1000, '17/01/2023') }.to_not raise_error
      expect { @bank_account.deposit(1000.34, '17/01/2023') }.to_not raise_error
      expect { @bank_account.deposit('transaction', '17/01/2023') }
        .to raise_error 'Transaction value must be a positive number'

      expect { @bank_account.withdraw(500, '14/01/2023') }.to_not raise_error
      expect { @bank_account.withdraw(500.55, '14/01/2023') }.to_not raise_error
      expect { @bank_account.withdraw('transaction', '14/01/2023') }
        .to raise_error 'Transaction value must be a positive number'
    end

    it 'raises argument error if parameters are missing' do
      expect { @bank_account.deposit }.to raise_error(ArgumentError)
      expect { @bank_account.withdraw }.to raise_error(ArgumentError)
    end
  end
end
