# Bank Tech Test

<div align="left">
  <img src="https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white"/>&nbsp
  <img src="https://img.shields.io/badge/RSpec-blue?style=for-the-badge&logo=Rspec&logoColor=white" alt="Rspec"/>
  <img src="https://img.shields.io/badge/Test_coverage:_97.86-blue?style=for-the-badge&logo=Rspec&logoColor=white" alt="Rspec"/>
</div><br>

This is a Makers' Academy challenge with the following requirements:

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

<img src="https://github.com/EvSivtsova/bank_tech_test/blob/main/outputs/bank_tech_test_required_output.png" width='350'>
  
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

Technologies used: 
* Ruby(3.0.0)
* RVM
* Rspec(Testing)
* Rubocop(Linter)
* Simplecov(Test Coverage)

To install the project, clone the repository and run `bundle install` to install the dependencies within bankTechTest folder:

```
git clone https://github.com/EvSivtsova/bank_tech_test.git
cd bank-test-tech
bundle install
```
To run the file and print the bank statement required:

`ruby bank_account.rb`

To run tests and lint the code use:

`rspec`

`rubocop`

## Code design

There are three classe BankAccount, BankStatement and InputValidation

BankAccount class has three public methods:
  * deposit and withdraw methods register and store the transactions in memory . These methods hold the instance of InputValidation class.
  * bank_statement method hold the instance of BankStatement class, which use the BancAccount data to output a record of all the transactions in required format

<img src="https://github.com/EvSivtsova/bank_tech_test/blob/main/outputs/bank_tech_test_final_output.png" width='500'>

BankAccount transactions and balance variables were made initially public to simplify class behaviour testing and then made private to protect the data. Tests have been amended to reflect that change.

The BankAccount class allows for manual input of transaction values. A possibility to input dates has also been added in order to produce required output of the test tech. 

BankStatement and InputValidation were initially part of BankAccount class but were extracted in line with Single Responsibility Principle. The tests have been amended to reflect that change.

Private methods address the formatting of the data and input validation. 

<img src="https://github.com/EvSivtsova/bank_tech_test/blob/main/outputs/bank_tech_test_coverage.png" width='500'>