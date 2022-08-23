# Bank Tech Test

This is Makers' Academy challenge with the following requirements:

### Requirements

* You should be able to interact with your code via a REPL like IRB or Node. (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

* Given a client makes a deposit of 1000 on 10-01-2023
* And a deposit of 2000 on 13-01-2023
* And a withdrawal of 500 on 14-01-2023
* When she prints her bank statement
* Then she would see

<img src="https://github.com/EvSivtsova/bank_tech_test/blob/main/bank_tech_test_required_output.png" width='350'>
  
  
## User stories

Based on the above requirements, I developed the following user stories:

_As a user,_<br>
_So that I could keep my money safe_<br>
**_I want to be able to deposit money into my bank account_**

_As a user,_<br>
_So that I could use my money_<br>
**_I want to be able to withdraw money from my bank account_**

_As a user,_<br>
_So that I could keep the records of all the transaction_<br>
**_I want to be able to view a bank statement_**

## TechBit

To install the project clone the repository and install node.js and the dependencies within bankTechTest folder:

```
git clone https://github.com/EvSivtsova/bank_tech_test.git
cd bank_test_tech
gem install bundler
```
To run the file and print the bank statement required:

`ruby lib/bank_account.rb`

To run tests and lint the code use:

`rspec`

`rubocop`

## Code design

There is one class BankAccount with three public methods:
  * deposit and withdraw methods register and store the transactions in memory 
  * bank_statement method provide a record of all the transactions in required format:

<img src="https://github.com/EvSivtsova/bank_tech_test/blob/main/bank_tech_test_final_output.png" width='500'>

Private methods address the formatting of the data.

The data can be easily accessed either by calling bank_statement method or using attribute accessors depending on the format required, as well as the purpose (read variable `balance` to access the current balance of your bank account).
