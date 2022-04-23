//
//  ContentViewPage.swift
//  TipCalculator_TestUITests
//
//  Created by Christopher Hicks on 4/23/22.
//

import Foundation
import XCTest

enum ElementIDs: String {
    case totalTextField = "totalTextField"
    case tipPercentagePicker = "tipPercentagePicker"
    case calculateTipButton = "calculateTipButton"
    case tipText = "tipText"
    case messageText = "messageText"
}

class ContentViewPage {
    
    var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var totalTextField: XCUIElement {
        app.textFields[ElementIDs.totalTextField.rawValue]
    }
    
    var calculateTipButton: XCUIElement {
        app.buttons[ElementIDs.calculateTipButton.rawValue]
    }
    
    var tipPercentagePicker: XCUIElement {
        app.segmentedControls[ElementIDs.tipPercentagePicker.rawValue]
    }
    
    var tipText: XCUIElement {
        app.staticTexts[ElementIDs.tipText.rawValue]
    }
    
    var messageText: XCUIElement {
        app.staticTexts[ElementIDs.messageText.rawValue]
    }
}
