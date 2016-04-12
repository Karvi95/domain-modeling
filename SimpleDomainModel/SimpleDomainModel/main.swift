//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello World!")

public func testMe() -> String {
return "I have been tested"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    
    init(amount : Int, currency : String) {
        self.amount = amount
        self.currency = currency
    }
    
    public func convert(to: String) -> Money {
        if (self.currency == "USD" && to == "GBP") {
            return Money(amount: (self.amount / 2), currency: to)
        }
        else if (self.currency == "USD" && to == "EUR") {
            return Money(amount: ((3 * self.amount) / 2), currency: to)
        }
        else if (self.currency == "USD" && to == "CAN") {
            return Money(amount: (5 * (self.amount) / 4), currency: to)
        }
        else if (self.currency == "GBP" && to == "USD") {
            return Money(amount: (2 * self.amount), currency: to)
        }
        else if (self.currency == "GBP" && to == "EUR") {
            return Money(amount: (3 * self.amount), currency: to)
        }
        else if (self.currency == "GBP" && to == "CAN") {
            return Money(amount: (5 * (self.amount) / 2), currency: to)
        }
        else if (self.currency == "EUR" && to == "USD") {
            return Money(amount: ((2 * self.amount) / 3), currency: to)
        }
        else if (self.currency == "EUR" && to == "GBP") {
            return Money(amount: (self.amount / 3), currency: to)
        }
        else if (self.currency == "EUR" && to == "CAN") {
            return Money(amount: (5 * (self.amount) / 6), currency: to)
        }
        else if (self.currency == "CAN" && to == "USD") {
            return Money(amount: (4 * (self.amount) / 5), currency: to)
        }
        else if (self.currency == "CAN" && to == "GBP") {
            return Money(amount: (2 * (self.amount) / 5), currency: to)
        }
        else if (self.currency == "CAN" && to == "EUR") {
            return Money(amount: (6 * (self.amount) / 5), currency: to)
        }
        else {
            return Money(amount: (self.amount), currency: to)
        }
    }
  
    public func add(to: Money) -> Money {
        if (self.currency != to.currency) {
            let converted = self.convert(to.currency)
            return Money(amount: (converted.amount + to.amount), currency: to.currency)
        } else {
            return Money(amount: (self.amount + to.amount), currency: to.currency)
        }
    }
    public func subtract(from: Money) -> Money {
        if (self.currency != from.currency) {
            let converted = self.convert(from.currency)
            return Money(amount: (from.amount - converted.amount), currency: from.currency)
        } else {
            return Money(amount: (from.amount - self.amount), currency: from.currency)
        }
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public var title : String
    public var type : JobType
    private var aSalary : Int
    private var anHourly : Int
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
  
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
  
    public func calculateIncome(hours: Int) -> Int {
        switch self.type {
        case .Salary(let aSalary):
            self.aSalary = aSalary
            return (aSalary)
        case .Hourly(let rate):
            let returner = Int(Double(hours) * rate)
            self.anHourly = returner
            return returner
        }
    }
  
    public func raise(amt : Double) {
        switch self.type {
        case .Salary(let aSalary):
            self.type = Job.JobType.Salary(aSalary + Int(amt))
        case .Hourly(let rate):
            self.type = Job.JobType.Hourly(rate + amt)
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    public var firstName : String = ""
    public var lastName : String = ""
    public var age : Int = 0
    
    private var myJob : Job?
    private var mySpouse : Person?

    public var job : Job? {
        get {
            return self.myJob
        }
        set(value) {
            if (self.age >= 16) {
                self.myJob = value
            } else {
                self.myJob = nil
            }
        }
    }
    
    public var spouse : Person? {
        get {
            return self.mySpouse
        }
        set(value) {
            if (self.age >= 18) {
                self.mySpouse = value
            } else {
                self.mySpouse = nil
            }
        }
    }
  
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    public func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]"
    }
}

////////////////////////////////////
// Family
//
public class Family {
    private var members : [Person] = []
  
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
  
    public func haveChild(child: Person) -> Bool {
        var possible = false
        for i in 0..<members.count {
            if (members[i].age > 21) {
                possible = true
            }
        }
        if (possible) {
            members.append(child)
        }
        
        return possible
    }
  
    public func householdIncome() -> Int {
        var sum = 0
        for i in 0..<members.count {
            if (members[i].job != nil) {
                sum += (members[i].job!.aSalary + (members[i].job?.anHourly)!)
                print("Hello: \(members[i].job!.aSalary)")
            }
        }
        
        return sum
    }
}

////////////////////////////////////
// MoneyExtra
//
public struct MoneyExtra {
    public var amount : Int
    public var currency : Currency
    
    public enum Currency : String {
        case USD = "USD"
        case GBP = "GBP"
        case EUR = "EUR"
        case CAN = "CAN"
    }
    
    init(amount : Int, currency : Currency) {
        self.amount = amount
        self.currency = currency
    }
    
    public func convert(to: Currency) -> MoneyExtra {
        switch to {
        case .USD:
            if(self.currency.rawValue == "GBP") {
                return MoneyExtra(amount: (2 * self.amount), currency: to)
            } else if(self.currency.rawValue == "EUR") {
                return MoneyExtra(amount: ((2 * self.amount) / 3), currency: to)
            } else if(self.currency.rawValue == "CAN"){
                return MoneyExtra(amount: (4 * (self.amount) / 5), currency: to)
            } else {
                return MoneyExtra(amount: (self.amount), currency: to)
            }
        case .GBP:
            if(self.currency.rawValue == "USD") {
                return MoneyExtra(amount: (self.amount / 2), currency: to)
            } else if(self.currency.rawValue == "EUR") {
                return MoneyExtra(amount: (self.amount / 3), currency: to)
            } else if(self.currency.rawValue == "CAN"){
                return MoneyExtra(amount: (2 * (self.amount) / 5), currency: to)
            } else {
                return MoneyExtra(amount: (self.amount), currency: to)
            }
        case .EUR:
            if(self.currency.rawValue == "USD") {
                return MoneyExtra(amount: ((3 * self.amount) / 2), currency: to)
            } else if(self.currency.rawValue == "GBP") {
                return MoneyExtra(amount: (3 * self.amount), currency: to)
            } else if(self.currency.rawValue == "CAN"){
                return MoneyExtra(amount: (6 * (self.amount) / 5), currency: to)
            } else {
                return MoneyExtra(amount: (self.amount), currency: to)
            }
        case .CAN:
            if(self.currency.rawValue == "USD") {
                return MoneyExtra(amount: (5 * (self.amount) / 4), currency: to)
            } else if(self.currency.rawValue == "GBP") {
                return MoneyExtra(amount: (5 * (self.amount) / 2), currency: to)
            } else if(self.currency.rawValue == "EUR"){
                return MoneyExtra(amount: (5 * (self.amount) / 6), currency: to)
            } else {
                return MoneyExtra(amount: (self.amount), currency: to)
            }
        }
    }
    
    public func add(to: MoneyExtra) -> MoneyExtra {
        if (self.currency.rawValue != to.currency.rawValue) {
            let converted = self.convert(to.currency)
            return MoneyExtra(amount: (converted.amount + to.amount), currency: to.currency)
        } else {
            return MoneyExtra(amount: (self.amount + to.amount), currency: to.currency)
        }
    }
    public func subtract(from: MoneyExtra) -> MoneyExtra {
        if (self.currency.rawValue != from.currency.rawValue) {
            let converted = self.convert(self.currency)
            return MoneyExtra(amount: (from.amount - converted.amount), currency: from.currency)
        } else {
            return MoneyExtra(amount: (from.amount - self.amount), currency: from.currency)
        }
    }
}

let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)

let family = Family(spouse1: ted, spouse2: charlotte)

let familyIncome = family.householdIncome()