//
//  MockingAppUITests.swift
//  MockingAppUITests
//
//  Created by Christopher Hicks on 4/23/22.
//

import XCTest

class when_user_clicks_on_login_button: XCTestCase {

    private var app: XCUIApplication!
    private var loginPage: LoginPageObject!
    
    override func setUp() {
        app = XCUIApplication()
        loginPage = LoginPageObject(app)
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
    }
    
    func test_should_display_error_message_for_missing_required_fields() {
        
        let userNameTextField = loginPage.usernameTextField
        userNameTextField.tap()
        userNameTextField.typeText("")
        
        let passwordTextField = loginPage.passwordTextField
        passwordTextField.tap()
        passwordTextField.typeText("")
        
        let loginButton = loginPage.loginButton
        loginButton.tap()
        
        let messageText = loginPage.messageText
        
        XCTAssertEqual(messageText.label, "Required fields are missing")
        
    }
    
    func test_should_display_error_message_for_invalid_credentials() {
        
        let userNameTextField = loginPage.usernameTextField
        userNameTextField.tap()
        userNameTextField.typeText("JohnDoe")
        
        let passwordTextField = loginPage.passwordTextField
        passwordTextField.tap()
        passwordTextField.typeText("WrongPassword")
        
        let loginButton = loginPage.loginButton
        loginButton.tap()
        
        let messageText = loginPage.messageText
        XCTAssertEqual(messageText.label, "Invalid credentials")
        
    }
    
    
    func test_should_navigate_to_dashboard_screen_when_authenticated() {
        
        let userNameTextField = loginPage.usernameTextField
        userNameTextField.tap()
        userNameTextField.typeText("JohnDoe")
        
        let passwordTextField = loginPage.passwordTextField
        passwordTextField.tap()
        passwordTextField.typeText("Password")
        
        let loginButton = loginPage.loginButton
        loginButton.tap()
        
        let dashboardNavTitle = app.staticTexts[ElementIDs.Dashboard.rawValue]
        XCTAssertTrue(dashboardNavTitle.waitForExistence(timeout: 0.5))
        
    }
    
}
