class BankAccount
  def initialize(io)
    @transactions = []
    @balance = 0
    @io = io
  end

  def deposit(value, date = Time.new.strftime('%d/%m/%Y'))
    @balance += value
    @transactions.push({ date: date, value: value, balance: @balance })
  end

  def withdraw(value, date = Time.new.strftime('%d/%m/%Y'))
    @balance -= value
    @transactions.push({ date: date, value: -value, balance: @balance })
  end

  def bank_statement
    bank_statement_header
    bank_statement_body
  end

  private

  def bank_statement_header
    @io.puts 'date || credit || debit || balance'
  end

  def bank_statement_body
    @transactions.reverse.map do |transaction|
      @io.puts "#{transaction[:date]} #{debit_or_credit(transaction)} #{balance_formatted(transaction)}"
    end
  end

  def debit_or_credit(transaction)
    return format('|| %.2f || ||', transaction[:value]) unless transaction[:value].negative?

    format('|| || %.2f ||', -transaction[:value])
  end

  def balance_formatted(transaction)
    !transaction[:balance].nil? ? format('%.2f', transaction[:balance]) : '0.00'
  end
end

if __FILE__ == $PROGRAM_NAME
  bank_account = BankAccount.new(Kernel)
  bank_account.deposit(1000, '10/01/2023')
  bank_account.deposit(2000, '13/01/2023')
  bank_account.withdraw(500, '14/01/2023')
  bank_account.bank_statement
end
