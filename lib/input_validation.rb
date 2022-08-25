class InputValidation
  def input_valid?(value, date)
    @error = nil
    value_validation(value)
    date_validation(date)
    raise @error unless @error.nil?
  end

  private

  def value_validation(value)
    return true if (value.instance_of?(Integer) || value.instance_of?(Float)) && value.positive?

    @error = 'Transaction value must be a positive number'
  end

  def date_validation(date)
    return true if date == Date.parse(date, '%d/%m/%Y').strftime('%d/%m/%Y')

    @error = 'Please insert date in the following format: DD/MM/YY'
  end
end
