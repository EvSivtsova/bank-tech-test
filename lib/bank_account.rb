class BankAccount
  def initialize
    @transactions = 0
  end

  def deposit(value, date = Time.now());
    @transactions = [value, date]
  end

  def get_transactions
    return @transactions
  end
end