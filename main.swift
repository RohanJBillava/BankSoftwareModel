//
//  main.swift
//  BankSoftwareModel
//
//  Created by Rohan J Billava on 01/12/21.
//

import Foundation

enum WithDrawAllowed {
    case current, savings
}
enum DepositAllowed {
    case current, savings, fixedOnlyOnce, recurring, deposit
}

protocol AccountProtocol {
    func depositMoney(accType: DepositAllowed, amount: Float) -> Int
    func withDrawMoney(accType: WithDrawAllowed, amount: Float) -> Int
}

extension AccountProtocol {
    func depositMoney(accType: DepositAllowed, amount: Float) ->Int {
        return 0
    }
    func withDrawMoney(accType: WithDrawAllowed, amount: Float) -> Int {
        return 0
    }
}

class Account {
    let number: String
    let accType: Account
    let customer: AccountHolder
    var balance: Float = 0
    init?(accountNumber: String, customer:AccountHolder, accountType: Account){
        if accountNumber.count == 13 {
            self.number = accountNumber
        }else {
            return nil
        }
        self.accType = accountType
        self.customer = customer
    }
}

class CaSa: Account {

    let holderName: String
    let holderEmail: String?
    let holderMobile: Int?
    
    init( accountHolderName: String, accountHolderEmail: String?, accountHolderMobile: Int?) {
        
        self.holderName = accountHolderName
        self.holderEmail = accountHolderEmail
        self.holderMobile = accountHolderMobile
    }
    
    func printStatement() {
        
    }
}

class Current: CaSa{
    let initialAmount: Float
    let type: WithDrawAllowed = .current
    
    init(initialAmount: Float) {
        self.initialAmount = initialAmount
    }
    
    let m1 = AccountManager()
    m1.depositMoney(type, 2000, account)
    m1.withdrawMoney(type, 500, account)
    
}

class Saving: CaSa {
    let initialAmount: Float
    
    init(initialAmount: Float){
        self.initialAmount = initialAmount
    }
}

enum DepositType {
    case fixed
    case recurring
}

class Deposit: Account {
    let termOfDeposit: Int
    let depositDate: Date
    let type: DepositType
    
    init( termOfDeposit: Int, date: Date, type: DepositType) {
        self.depositDate = date
        self.termOfDeposit = termOfDeposit
        self.type = type
    }
}

enum LoanType {
    case vehiceLoan
    case houseLoan
    case personalLoan
}
class Loan: Account {
    var loanType:LoanType
    var id: Int
    var loanAmount: Float
    
    init(type: LoanType, id: Int, amount: Float) {
        self.id = id
        self.loanType = type
        self.loanAmount = amount
    }
}


class AccountHolder {
    let name: String
    let email: String?
    let mobile: Int?
    
    
    init(name: String, email: String?, mobile: Int? ) {
        self.name = name
        self.email = email
        self.mobile = mobile
    }
    
}
    
class AccountManager: AccountProtocol {
    var allAccounts: [String: Account] = [:]
    var transactionHistory: [String] = []
    
    
    
    func printAccountStatement(){
        var i = 10
        for j in  transactionHistory.reversed() {
            if i > 0 {
                print(j)
                i = i - 1
            }else {
                break
            }
            
        }
    }
    
    func depositMoney(accType: DepositAllowed, amount: Float, account: Account) -> Int {
        let paymentId = generatePaymentId()
        account.balance = account.balance + amount
    
        transactionHistory.append("\(paymentId): Deposit of \(amount)Rs and totalBalance after deposit is: \(account.balance)")
        return paymentId
    }
    
    func withDrawMoney(accType: WithDrawAllowed, amount: Float, account: Account) -> Int? {
        var withDrawStatus = false
        let paymentId = generatePaymentId()
        
        if amount <= account.balance {
            withDrawStatus = true
        }else {
            withDrawStatus = false
        }
        
        if withDrawStatus {
            account.balance = account.balance - amount
            transactionHistory.append("\(paymentId): Withdraw of \(amount)Rs and totalBalance remaining is: \(account.balance)")
            return paymentId
        } else {
            print("Insufficient Balance")
            return nil
        }
    }
    
    func generatePaymentId() -> Int{
        // some logic to generate payment id
        return 0
    }
    func setAccounts( _ accounts: [Account?]) {
        for i in accounts {
            if let number = i?.number {
                allAccounts[number] = i
            }
        }
    }
    
    func printCurrentBalance(of accountNumber: String) {
        if let temp = allAccounts[accountNumber] {
            print(temp.accType.balance)
        }
    }
    
    func printAccountDetails(of accountNumber: String) {
        if let temp = allAccounts[accountNumber] {
            print(temp.number)
            print(temp.customer.name)
            print(temp.customer.email)
            print(temp.customer.mobile)
        }
    }
    
    func aplpyRateofintrest(account: Account, intrestRate: Float) -> Float {
        account.balance = account.balance * (account.balance * intrestRate / 365)
        return account.balance
    }
    
    func aplpyRateofintrestForDeposit(account: Deposit, intrestRate: Float) -> Float {
        account.balance = account.balance + account.balance * intrestRate * Float(account.termOfDeposit)
        return account.balance
    }
}
    
let customer1 = AccountHolder(name: "Rohan", email: "rohan02@gmail.com", mobile: 9856485945)
let savingAccount1 = Saving(initialAmount: 2000)
let account1 = Account(accountNumber: "1000000000025", customer: customer1, accountType: savingAccount1)

let customer2 = AccountHolder(name: "Rahul", email: "rahul03@gmail.com", mobile: 9564856584)
let currentAccount1 = Current(initialAmount: 5000)
let account2 = Account(accountNumber: "1520000000024", customer: customer2, accountType: currentAccount1)
var manager = AccountManager()
manager.setAccounts([account1,account2])





