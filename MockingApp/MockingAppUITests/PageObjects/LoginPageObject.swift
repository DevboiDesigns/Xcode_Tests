//
//  LoginPageObject.swift
//  MockingApp
//
//  Created by Christopher Hicks on 4/23/22.
//

import Foundation
import XCTest

enum ElementIDs: String {
    case usernameTextField = "usernameTextField"
    case passwordTextField = "passwordTextField"
    case loginButton = "loginButton"
    case messageText = "messageText"
    case Dashboard = "Dashboard"
}

class LoginPageObject {
    
    var app: XCUIApplication!
    
    init(_ app: XCUIApplication) {
        self.app = app
    }

    var usernameTextField: XCUIElement {
        app.textFields[ElementIDs.usernameTextField.rawValue]
    }
    
    var passwordTextField: XCUIElement {
        app.textFields[ElementIDs.passwordTextField.rawValue]
    }
    
    var loginButton: XCUIElement {
        app.buttons[ElementIDs.loginButton.rawValue]
    }
    
    var messageText: XCUIElement {
        app.staticTexts[ElementIDs.messageText.rawValue]
    }
}
