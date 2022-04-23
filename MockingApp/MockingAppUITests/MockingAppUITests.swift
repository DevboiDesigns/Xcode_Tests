//
//  MockingAppUITests.swift
//  MockingAppUITests
//
//  Created by Christopher Hicks on 4/23/22.
//

import XCTest

enum ElementIDs: String {
    case usernameTextField = "usernameTextField"
    case passwordTextField = "passwordTextField"
    case loginButton = "loginButton"
    case messageText = "messageText"
    case Dashboard = "Dashboard"
}

class when_user_clicks_on_login_button: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
    }
    
    func test_should_display_error_message_for_missing_required_fields() {
        
        let userNameTextField = app.textFields[ElementIDs.usernameTextField.rawValue]
        userNameTextField.tap()
        userNameTextField.typeText("")
        
        let passwordTextField = app.textFields[ElementIDs.passwordTextField.rawValue]
        passwordTextField.tap()
        passwordTextField.typeText("")
        
        let loginButton = app.buttons[ElementIDs.loginButton.rawValue]
        loginButton.tap()
        
        let messageText = app.staticTexts[ElementIDs.messageText.rawValue]
        
        XCTAssertEqual(messageText.label, "Required fields are missing")
        
    }
    
    
    func test_should_navigate_to_dashboard_screen_when_authenticated() {
        
        let userNameTextField = app.textFields[ElementIDs.usernameTextField.rawValue]
        userNameTextField.tap()
        userNameTextField.typeText("JohnDoe")
        
        let passwordTextField = app.textFields[ElementIDs.passwordTextField.rawValue]
        passwordTextField.tap()
        passwordTextField.typeText("Password")
        
        let loginButton = app.buttons[ElementIDs.loginButton.rawValue]
        loginButton.tap()
        
        let dashboardNavTitle = app.staticTexts[ElementIDs.Dashboard.rawValue]
        XCTAssertTrue(dashboardNavTitle.waitForExistence(timeout: 0.5))
        
    }
    
}
