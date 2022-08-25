class BankStatement
  def initialize(io)
    @io = io
  end

  def bank_statement_formatted(transactions)
    input_validation(transactions)
    bank_statement_header
    bank_statement_body(transactions)
  end

  private

  def input_validation(transactions)
    raise 'Please provide an array of transactions in required format' if transactions.nil? || transactions.empty?
  end

  def bank_statement_header
    @io.puts 'date || credit || debit || balance'
  end

  def bank_statement_body(transactions)
    transactions.map do |transaction|
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
