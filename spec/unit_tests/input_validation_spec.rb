require 'input_validation'

describe InputValidation do
  before :each do
    @input_validation = InputValidation.new
  end

  it 'is an instance of InputValidation class' do
    expect(@input_validation).to be_instance_of(InputValidation)
  end

  it 'accepts Integers and floats as transaction values and correctly formatted dates' do
    expect { @input_validation.input_valid?(1000, '17/01/2023') }.to_not raise_error
    expect { @input_validation.input_valid?(1000.55, '17/01/2023') }.to_not raise_error
  end

  it 'raises argument error if any of parameters are missing' do
    expect { @input_validation.input_valid?(1000) }.to raise_error(ArgumentError)
    expect { @input_validation.input_valid? }.to raise_error(ArgumentError)
  end

  it 'raises error when date is incorrect' do
    expect { @input_validation.input_valid?(1000, '10-06-2023') }
      .to raise_error 'Please insert date in the following format: DD/MM/YY'
    expect { @input_validation.input_valid?(1000, '2023-06-10') }
      .to raise_error 'Please insert date in the following format: DD/MM/YY'
    expect { @input_validation.input_valid?(1000, 'date') }.to raise_error(Date::Error)
  end

  it 'raises error when value of transaction is not a number' do
    expect { @input_validation.input_valid?(:value, '17/01/2023') }
      .to raise_error 'Transaction value must be a positive number'
    expect { @input_validation.input_valid?('transaction', '17/01/2023') }
      .to raise_error 'Transaction value must be a positive number'
  end
end
