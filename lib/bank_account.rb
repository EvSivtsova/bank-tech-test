class BankAccount
  def initialize
    @transactions = []
    @balance = 0
  end

  def deposit(value, date = Time.new().strftime('%d-%m-%Y'));
    @transactions.push({date: date, value: value})
    @balance += value
  end

  def withdraw(value, date = Time.new().strftime('%d-%m-%Y'));
    value = -(value)
    @transactions.push({date: date, value: value})
  end

  def get_transactions
    return @transactions
  end

  def get_balance
    return @balance
  end
end