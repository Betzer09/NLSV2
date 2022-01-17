//
//  Double+Ext.swift
//  AnneCraigFitness
//
//  Created by Austin Betzer on 8/21/21.
//

import Foundation

// Specify the decimal place to round to using an enum
public enum RoundingPrecision {
    case ones
    case tenths
    case hundredths
    case thousands
}

extension Double {
    /**
     Rounds a double to a specific decimal place
     
     https://stackoverflow.com/questions/34929932/round-up-double-to-2-decimal-places
     
     ```
     let value: Double = 98.163846
     print(value.customRound(.toNearestOrEven, precision: .ones)) //98.0
     print(value.customRound(.toNearestOrEven, precision: .tenths)) //98.2
     print(value.customRound(.toNearestOrEven, precision: .hundredths)) //98.16
     print(value.customRound(.toNearestOrEven, precision: .thousands)) //98.164
     ```
     */
    func customRound(_ rule: FloatingPointRoundingRule, precision: RoundingPrecision = .ones) -> Double {
        switch precision {
        case .ones: return (self * Double(1)).rounded(rule) / 1
        case .tenths: return (self * Double(10)).rounded(rule) / 10
        case .hundredths: return (self * Double(100)).rounded(rule) / 100
        case .thousands: return (self * Double(1000)).rounded(rule) / 1000
        }
    }
}

