# Xcode Testing
* TDD - test driven development
* performed in memory - doesnt need acess to network & database
* should be able to run tests in any order 

## Helpful links
* [hackr](https://hackr.io/blog/types-of-software-testing)
* [slideshare](https://www.slideshare.net/Bugraptors/performance-testing-1)

**What to Test**
* Application Domain - logic of application `{ payment flow, ticket purchase, notifications, etc }`
* user interface by automating unit test
  
**Dont Test**
* test generated code
* issues caught by compiler
* dependency or thirty party code
  
**Good Tests**
* Independent - not dependent on wifi, database, or each other 
* Automatic - runs automatic 
* Repeatable - consistent results 
* Readable


## User Interface testing
* entirely automate tasks to interact with app 

## Integration testing 
* combine and test together
* goes through real world scenarios of how the whole system works

**Integrating all tests**
* ui tests
* domain tests
* services tests
* database tests

## Acceptance testing
* final step 
* tests on actual hardward with actual data
* tested for acceptability 
* test to satisfy business criteria 
* testing requirments and needs
* performed by client or end user 

## Performance testing
* determing speed and effectiveness of software 
  
### Types
#### Throughput
* number of requests/ transactions processed by the application in a specified time duration

#### Response Time
* defined as the delay between the point of request and the first response

#### Tuning
* an iterative process that we use to identify and eliminate bottlenecks in the application 

#### Benchmarking
* the practice of comparing business process and performance metrics to industry bests and best practices from other companies


# Setup
* `import XCTest`
* add new target - Unit testing and UI testing 
* function naming convention `test_`
* name will generate a diamond with play button next to test function 

## Unit Testing 
* domain focused 

[Files](TipCalculator_Test/TipCalculator_TestTests/TipCalculator_TestTests.swift)

```swift
func test_add_two_numbers() {
        
        let result = 3 + 5
        
        // compares if ==
        XCTAssertEqual(result, 8)
        
}
```

* have descriptive test names and classes 
  
```swift
class when_calculating_tip_based_on_total_amount: XCTestCase {

    func test_should_calculate_tip_succesfully() {
        
    }
}
```

* add files to test target to have access in testing 
  
```swift
class when_calculating_tip_based_on_total_amount: XCTestCase {

    func test_should_calculate_tip_succesfully() {
        let tipCalculator = TipCalculator()
        let tip = tipCalculator.calculate(total: 100, tipPercentage: 0.1)
        XCTAssertEqual(10, tip)
        
    }
}
```

```swift
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
```

## UI Testing 
* normally run over night because they take a long time to run 

* `XCUIApplication` - whole app
* `XCTAssertEqual(tipText.label, "$20.00")` - checks if both parameters are `==`
* `@testable import MockingApp` - gives access to whole app without adding to the test targe 

[Files](TipCalculator_Test/TipCalculator_TestUITests/TipCalculator_TestUITests.swift)

```swift
func test_should_make_sure_that_the_total_textfield_contains_default_value() {
       
       //MARK: XCUIApplication - app
       let app = XCUIApplication()
       continueAfterFailure = false
       app.launch()
       
       let totalTextField = app.textFields["totalTextField"]
       
       // will check inital value of text field  - compares ==
       XCTAssertEqual(totalTextField.value as! String, "Enter total")
}
```

**add accessibility identifier** 
```swift
TextField("Enter total", text: $total)
    .accessibilityIdentifier("totalTextField")
```

### Getting access to elements in view
* `app.textFields["totalTextField"]`
* `app.buttons["calculateTipButton"]`
* `app.staticTexts["tipText"]`
* `tipPercentagePicker.buttons.element(boundBy: 1)` - finds which button is selected from array of picker options 

```swift
func test_should_make_sure_20percent_default_tip_option_selected() {
     let app = XCUIApplication()
     continueAfterFailure = false
     app.launch()
     
     let tipPercentagePicker = app.segmentedControls["tipPercentagePicker"]
     // ------------------------- access particular button on picker [array of buttons]
     let pickerButton = tipPercentagePicker.buttons.element(boundBy: 1)
     // ---- check if button is actually selected 
     XCTAssertEqual(pickerButton.label, "20%")
     // checks if currently selected
     XCTAssertTrue(pickerButton.isSelected)

}
```

### Config each test

**runs before every test**
```swift
private var app: XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
```

**runs after each test**
```swift
override func tearDown() {
    
}
```

### Click events 
* `calculateTipButton.tap()`
* `totalTextField.typeText("100")`
* `let _ = totalTextField.waitForExistence(timeout: 0.5)` - will wait for load time 

```swift
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
// for basic text label - staticText
let tipText = app.staticTexts["tipText"]
// will wait for text to be updated - needed
let _ = tipText.waitForExistence(timeout: 0.5)
XCTAssertEqual(tipText.label, "$20.00")
```

## Page Object Pattern 
* represents an entire views accessible elements 

[File](TipCalculator_Test/TipCalculator_TestUITests/Page-Objects/ContentViewPage.swift)

```swift
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
```

* config

 ```swift
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
 ``` 

* usage 

```swift
func test_should_make_sure_that_the_total_textfield_contains_default_value() {
       
  //  let totalTextField = app.textFields[ElementIDs.totalTextField.rawValue] 
    XCTAssertEqual(contentViewPage.totalTextField.value as! String, "Enter total")
}
```

## Recording 
* ???? - reording button at bottom of screen
* attempts to inject the code of your interactions - can be quite buggy
* can be helpful to find nested elements 

## Code Coverage
* will show the exact amount of code being tested
* domain logic should be covered 100%

**Enable**
* Click on Project File -> Product -> Scheme -> Edit Scheme -> Test -> Code Coverage: gather coverage for 
* Report Navigator Tab -> click on file -> opens with editor showing exactly what is not tested 

[File](BankApp/BankApp/BankAccount.swift)

```swift 
import XCTest
@testable import BankApp

class when_deposit_money_into_bank_account: XCTestCase {
    
    func test_should_deposit_amount_succesfully() {
        let bankAccount = BankAccount(accountNumber: "1234", amount: 100)
        bankAccount.deposit(200)
        XCTAssertEqual(300, bankAccount.balance)
    }

}
```

## Mocking
* mock server/ auth service 
* replaces acutal server respones and interaction 


```swift
protocol NetworkService {
    func login(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
}
```

```swift
class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var loginStatus: LoginStatus = .none
    
    private var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func login() {
        
        if username.isEmpty || password.isEmpty {
            self.loginStatus = .validationFailed
            return
        }
        
        service.login(username: username, password: password) { result in
            switch result {
                case .success():
                        DispatchQueue.main.async {
                            self.loginStatus = .authenticated
                        }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.loginStatus = .denied
                    }
            }
        }
    }
    
}
```

* `app.launchEnvironment = ["ENV": "TEST"]`
inject data into view for testing 

```swift
private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
    }
```


[File](MockingApp/MockingApp/Factories/NetworkServiceFactory.swift)
```swift
class NetworkServiceFactory {
    
    static func create() -> NetworkService {
        let environment = ProcessInfo.processInfo.environment["ENV"]
        
        if let environment = environment {
            if environment == "TEST" {
                return MockWebSerivce()
            } else {
                return Webservice()
            }
        } else {
            return Webservice()
        }
    }
}
```


[File](MockingApp/MockingAppUITests/Mocks/MockWebService.swift)
```swift
class MockWebSerivce: NetworkService {
    func login(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        if username == "JohnDoe" && password == "Password" {
            completion(.success(()))
        } else {
            completion(.failure(.notAuthenticated))
        }
    }
}
```

**In View**
```swift
@StateObject private var loginVM = LoginViewModel(service: NetworkServiceFactory.create())
```

# Debugging

- set break point on #variable# to watch
- run + hit breakpoint
- in variables debug panel: look in self -> #variable#
- right click + select "watch #variable#"
- press `cntrl` + `cmd` + `y` to continue stepping through (as many times as needed)
- Xcode will pause and print every time #variable# has changed
  - `old value: some`
  - `new value: none` - red flag
- Switch 'Debugging' View on left side panel
- Thread stack will show all code that is running in order of execution
- step through execution to find where issue is occuring

## Exception Break Point

- click `+` in bottom of break point panel
- defaults to all, objective c is best for UIKit
- select `o_objc_exception_throw` in degub panel
- in console `po $arg1` `po` = print out
- add action to exception break point: `po $arg1` (alternatively)
- right click + move breakpoint to user = sets gloablly on all projects

## Print Statments in cosole

- `po self`
- `po` any variable

## CustomDebugStringConvertible

```swift
extension dProfileViewModel: CustomDebugStringConvertible {

    var debugDescription: String {
        return """
                AppUser: \(self.user)\n
                Profile: \(self.profile)\n
                Self: \(self)
                """
    }
}
```