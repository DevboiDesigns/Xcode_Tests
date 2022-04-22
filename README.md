# Unit Testing
* TDD
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
* add new target - Unit testing and UI testing 
* function naming convention `test_`
* name will generate a diamond with play button next to test function 

## Unit Testing 
* domain focused 

[Files](TipCalculator_Test/TipCalculator_TestTests/TipCalculator_TestTests.swift)

```swift
func test_add_two_numbers() {
        
        let result = 3 + 5
        
        // assert result of value
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

[Files](TipCalculator_Test/TipCalculator_TestUITests/TipCalculator_TestUITests.swift)

```swift
func test_should_make_sure_that_the_total_textfield_contains_default_value() {
       
       //MARK: XCUIApplication - app
       let app = XCUIApplication()
       continueAfterFailure = false
       app.launch()
       
       let totalTextField = app.textFields["totalTextField"]
       
       // will check inital value of text field
       XCTAssertEqual(totalTextField.value as! String, "Enter total")
}
```

**add accessibility label** 
```swift
TextField("Enter total", text: $total)
    .textFieldStyle(.roundedBorder)
    .accessibilityLabel("totalTextField")
```

## getting access to elements in view

```swift
func test_should_make_sure_20percent_default_tip_option_selected() {
     let app = XCUIApplication()
     continueAfterFailure = false
     app.launch()
     
     let tipPercentagePicker = app.segmentedControls["tipPercentagePicker"]
     let pickerButton = tipPercentagePicker.buttons.element(boundBy: 1)
     XCTAssertEqual(pickerButton.label, "20%")
     // checks if currently selected
     XCTAssertTrue(pickerButton.isSelected)

}
```

## Config each test

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

## Click events 

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