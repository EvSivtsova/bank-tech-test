class BankAccount
  def initialize(io)
    @transactions = []
    @balance = 0
    @io = io
  end

  def deposit(value, date = Time.new().strftime('%d/%m/%Y'));
    @balance += value
    @transactions.push({
      date: date, 
      value: value, 
      balance: @balance})
  end
  
  def withdraw(value, date = Time.new().strftime('%d/%m/%Y'));
    @balance -= value
    @transactions.push({
      date: date, 
      value: -value, 
      balance:  @balance})
  end
  
  def get_transactions
    return @transactions
  end
  
  def get_balance
    return @balance
  end

  def get_bank_statement
    bank_statement_header
    bank_statement_body
  end
  
  private 
  
  def bank_statement_header
    @io.puts "date || credit || debit || balance"
  end
  
  def bank_statement_body
    @transactions.reverse.map do |transaction|
      if transaction[:value] > 0
        transaction_value = "|| #{'%.2f' % transaction[:value]} || ||"
      else
        transaction_value = "|| || #{'%.2f' % -transaction[:value]} ||"
      end
      @io.puts "#{transaction[:date]} #{transaction_value} #{'%.2f' % transaction[:balance] if !transaction[:balance].nil?}"
    end
  end
end
