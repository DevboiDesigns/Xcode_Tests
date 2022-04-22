//
//  TipCalculator_TestTests.swift
//  TipCalculator_TestTests
//
//  Created by Christopher Hicks on 4/21/22.
//

import XCTest

class when_calculating_tip_based_on_total_amount: XCTestCase {

    func test_should_calculate_tip_succesfully() {
        let tipCalculator = TipCalculator()
        let tip = try! tipCalculator.calculate(total: 100, tipPercentage: 0.1)
        XCTAssertEqual(10, tip)
        
    }
}


class when_calculating_tip_based_on_negative_total_amount: XCTestCase {
    
    func test_should_throw_invalid_input_exception() {
        let tipCalculator = TipCalculator()
        
        //MARK: Will test if expression throws or not 
        XCTAssertThrowsError(try tipCalculator.calculate(total: -100, tipPercentage: 0.1), "") { error in
            XCTAssertEqual(error as! TipCalculatorError, TipCalculatorError.invalidInput)
        }
        
    }
}
