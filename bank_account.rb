require 'date'
require_relative './lib/input_validation'
require_relative './lib/bank_statement'

class BankAccount
  def initialize(io)
    @transactions = []
    @io = io
    @input_validation = InputValidation.new
  end

  def deposit(value, date = Time.new.strftime('%d/%m/%Y'))
    @input_validation.input_valid?(value, date)
    @transactions.push({ date: date, value: value })
  end

  def withdraw(value, date = Time.new.strftime('%d/%m/%Y'))
    @input_validation.input_valid?(value, date)
    @transactions.push({ date: date, value: -value })
  end

  def bank_statement
    statement = BankStatement.new(@io)
    statement.bank_statement_formatted(data_for_bank_statement)
  end

  private

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
    @transactions.reverse
  end
end

if __FILE__ == $PROGRAM_NAME
  bank_account = BankAccount.new(Kernel)
  bank_account.deposit(1000, '10/01/2023')
  bank_account.deposit(2000, '13/01/2023')
  bank_account.withdraw(500, '14/01/2023')
  bank_account.bank_statement
end
