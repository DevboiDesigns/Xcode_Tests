//
//  TipCalculator.swift
//  TipCalculator_Test
//
//  Created by Christopher Hicks on 4/21/22.
//

import Foundation

enum TipCalculatorError: Error {
    case invalidInput
}

class TipCalculator {
    
    func calculate(total: Double, tipPercentage: Double) throws -> Double {
        if total < 0 {
            throw TipCalculatorError.invalidInput
        }
        return total * tipPercentage
    }
    
}
