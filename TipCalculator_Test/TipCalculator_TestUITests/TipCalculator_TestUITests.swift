//
//  TipCalculator_TestUITests.swift
//  TipCalculator_TestUITests
//
//  Created by Christopher Hicks on 4/21/22.
//

import XCTest

class when_content_view_is_shown: XCTestCase {
    
    private var app: XCUIApplication!
    // Page Object Pattern
    private var contentViewPage: ContentViewPage!
    
    //MARK: Config - runs before every test
    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
    }

    func test_should_make_sure_that_the_total_textfield_contains_default_value() {
        // will check inital value of text field
        XCTAssertEqual(contentViewPage.totalTextField.value as! String, "Enter total")
    }
    
    func test_should_make_sure_20percent_default_tip_option_selected() {
        let pickerButton = contentViewPage.tipPercentagePicker.buttons.element(boundBy: 1)
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
    private var contentViewPage: ContentViewPage!
    
    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
        
        // access element
        let totalTextField = contentViewPage.totalTextField
        //tap textfield
        totalTextField.tap()
        //type text in text field
        totalTextField.typeText("100")
        //access element
        let calculateTipButton = contentViewPage.calculateTipButton
        //tap button
        calculateTipButton.tap()
        
    }
    
    func test_should_make_sure_tip_is_displayed_on_the_screen() {
        
        let tipText = contentViewPage.tipText
        // will wait for text to be updated - needed
        let _ = tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(tipText.label, "$20.00")
        
    }
    
}


class when_calculate_tip_button_is_pressed_for_invalid_input: XCTestCase {
    
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    
    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
        
        // access element
        let totalTextField = contentViewPage.totalTextField
        //tap textfield
        totalTextField.tap()
        //type text in text field
        totalTextField.typeText("-100")
        // will wait for text to be updated - needed
        let _ = totalTextField.waitForExistence(timeout: 0.5)
        //access element
        let calculateTipButton = contentViewPage.calculateTipButton
        //tap button
        calculateTipButton.tap()
        
    }
    
    
    func test_should_clear_tip_label_for_invalid_input() {
        
        let tipText = contentViewPage.tipText
        let _ = tipText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(tipText.label, "")
        
    }
    
    func test_should_display_error_message_for_invalid_input() {
        
        let messageText = contentViewPage.messageText
        let _ = messageText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(messageText.label, "Invalid Input")
        
    }
}
