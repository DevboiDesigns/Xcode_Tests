//
//  TipCalculator_TestUITests.swift
//  TipCalculator_TestUITests
//
//  Created by Christopher Hicks on 4/21/22.
//

import XCTest

class when_content_view_is_shown: XCTestCase {
    
    private var app: XCUIApplication!
    
    //MARK: Config - runs before every test
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }

    func test_should_make_sure_that_the_total_textfield_contains_default_value() {
        let totalTextField = app.textFields["totalTextField"] // add accessibility label "totalTextField"
        // will check inital value of text field
        XCTAssertEqual(totalTextField.value as! String, "Enter total")
    }
    
    func test_should_make_sure_20percent_default_tip_option_selected() {
        let tipPercentagePicker = app.segmentedControls["tipPercentagePicker"]
        let pickerButton = tipPercentagePicker.buttons.element(boundBy: 1)
        XCTAssertEqual(pickerButton.label, "20%")
        // checks if currently selected
        XCTAssertTrue(pickerButton.isSelected)
   
    }
    
    //MARK: Runs after each test
    override func tearDown() {
        
    }
}


class when_calculate_tip_button_is_pressed_for_valid_input: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        // access element
        let totalTextField = app.textFields["totalTextField"]
        //tap textfield
        totalTextField.tap()
        //type text in text field
        totalTextField.typeText("100")
        //access element
        let calculateTipButton = app.buttons["calculateTipButton"]
        //tap button
        calculateTipButton.tap()
        
    }
    
    func test_should_make_sure_tip_is_displayed_on_the_screen() {
        
        let tipText = app.staticTexts["tipText"]
        // will wait for text to be updated - needed
        let _ = tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(tipText.label, "$20.00")
        
    }
    
}


class when_calculate_tip_button_is_pressed_for_invalid_input: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        // access element
        let totalTextField = app.textFields["totalTextField"]
        //tap textfield
        totalTextField.tap()
        //type text in text field
        totalTextField.typeText("-100")
        // will wait for text to be updated - needed
        let _ = totalTextField.waitForExistence(timeout: 0.5)
        //access element
        let calculateTipButton = app.buttons["calculateTipButton"]
        //tap button
        calculateTipButton.tap()
        
    }
    
    
    func test_should_clear_tip_label_for_invalid_input() {
        
        let tipText = app.staticTexts["tipText"]
        let _ = tipText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(tipText.label, "")
        
    }
    
    func test_should_display_error_message_for_invalid_input() {
        
        let messageText = app.staticTexts["messageText"]
        let _ = messageText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(messageText.label, "Invalid Input")
        
    }
}
