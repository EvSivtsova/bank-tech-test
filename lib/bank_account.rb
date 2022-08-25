require 'date'

class BankAccount
  def initialize(io)
    @transactions = []
    @io = io
  end

  def deposit(value, date = Time.new.strftime('%d/%m/%Y'))
    input_valid?(value, date)
    @transactions.push({ date: date, value: value })
  end

  def withdraw(value, date = Time.new.strftime('%d/%m/%Y'))
    input_valid?(value, date)
    @transactions.push({ date: date, value: -value })
  end

  def bank_statement
    data_for_bank_statement
    bank_statement_header
    bank_statement_body
  end

  private

  # Data validation

  def input_valid?(value, date)
    @error = nil
    value_validation(value)
    date_validation(date)
    raise @error unless @error.nil?
  end

  def value_validation(value)
    return true if (value.instance_of?(Integer) || value.instance_of?(Float)) && value.positive?

    @error = 'Transaction value must be a positive number'
  end

  def date_validation(date)
    return true if date == Date.parse(date, '%d/%m/%Y').strftime('%d/%m/%Y')

    @error = 'Please insert date in the following format: DD/MM/YY'
  end

  # Data manipulation

  def update_account_balance
    count = 0
    previous_balance = 0
    sorted_transations = @transactions.sort_by { |transaction| transaction[:date] }
    @transactions = sorted_transations.each do |transaction|
      transaction[:balance] = transaction[:value] + previous_balance
      count += 1
      previous_balance = sorted_transations[count - 1][:balance]
    end
  end

  def data_for_bank_statement
    update_account_balance
    @transactions = @transactions.reverse
  end

  # Bank statement formatting

  def bank_statement_header
    @io.puts 'date || credit || debit || balance'
  end

  def bank_statement_body
    @transactions.map do |transaction|
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
