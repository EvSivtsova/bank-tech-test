require 'bank_statement'

describe BankStatement do
  before :each do
    @io = double :io
    @bank_statement = BankStatement.new(@io)
  end

  it 'is an instance of BankStatement class' do
    expect(@bank_statement).to be_instance_of(BankStatement)
  end

  it 'provides a list of transactions with updated balance sorted by date in reverse order' do
    transactions = [
      { date: '14/01/2023', value: -500, balance: 2500 },
      { date: '13/01/2023', value: 2000, balance: 3000 },
      { date: '10/01/2023', value: 1000, balance: 1000 }
    ]
    expect(@io).to receive(:puts).with('date || credit || debit || balance').ordered
    expect(@io).to receive(:puts).with('14/01/2023 || || 500.00 || 2500.00').ordered
    expect(@io).to receive(:puts).with('13/01/2023 || 2000.00 || || 3000.00').ordered
    expect(@io).to receive(:puts).with('10/01/2023 || 1000.00 || || 1000.00').ordered
    @bank_statement.bank_statement_formatted(transactions)
  end

  it 'raises error if there is no data available' do
    transactions = []
    expect { @bank_statement.bank_statement_formatted(transactions) }
      .to raise_error 'Please provide an array of transactions in required format'
  end
end
