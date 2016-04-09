//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

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
            let converted = self.convert(self.currency)
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
            return (aSalary)
        case .Hourly(let rate):
            return Int(Double(hours) * rate)
        }
    }
  
    public func raise(amt : Double) {
        switch self.type {
        case .Salary(let aSalary):
            Double(aSalary) + amt
        case .Hourly(let rate):
            rate + amt
        }
    }
}

////////////////////////////////////
// Person
//
//public class Person {
//    public var firstName : String = ""
//    public var lastName : String = ""
//    public var age : Int = 0
//
//    public var job : Job? {
//        get { }
//        set(value) {
//        }
//    }
//  
//    public var spouse : Person? {
//        get { }
//        set(value) {
//        }
//    }
//  
//    public init(firstName : String, lastName: String, age : Int) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.age = age
//    }
//  
//    public func toString() -> String {
//    }
//}
//
//////////////////////////////////////
//// Family
////
//public class Family {
//    private var members : [Person] = []
//  
//    public init(spouse1: Person, spouse2: Person) {
//    }
//  
//    public func haveChild(child: Person) -> Bool {
//    }
//  
//    public func householdIncome() -> Int {
//    }
//}

let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
//print("Currency: \(job.title)" + " Amount: \(job.JobType)")


//let tenUSD = Money(amount: 10, currency: "USD")
//print("Currency: \(tenUSD.currency)" + " Amount: \(tenUSD.amount)")
//
//print("\nCONVERSION")
//let gbp = tenUSD.convert("GBP")
//print("Currency: \(gbp.currency)" + " Amount: \(gbp.amount)")
//
//print("\nADDITION")
//let fiveGBP = Money(amount: 5, currency: "GBP")
//let total = tenUSD.subtract(fiveGBP)
//print("Currency: \(total.currency)" + " Amount: \(total.amount)")
