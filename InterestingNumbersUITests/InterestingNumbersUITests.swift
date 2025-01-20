//
//  InterestingNumbersUITests.swift
//  InterestingNumbersUITests
//
//  Created by Мария Анисович on 20.01.2025.
//

import XCTest

final class InterestingNumbersUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testUserNumberButton() throws {
        let app = XCUIApplication()
        
        let titleLabel = app.staticTexts["titleLabel"]
        XCTAssertTrue(titleLabel.exists, "Label is not found.")
        
        let subtitleLabel = app.staticTexts["subtitleLabel"]
        XCTAssertTrue(subtitleLabel.exists, "Label is not found.")
        
        let diceView = app.otherElements["diceView"]
        XCTAssertTrue(diceView.exists, "View is not found.")
        
        let buttonsStackView = app.otherElements["buttonsStackView"]
        XCTAssertTrue(buttonsStackView.exists, "StackView is not found.")
        
        let userNumberButton = app.buttons["userNumberButton"]
        XCTAssertTrue(userNumberButton.exists, "Button is not found.")
        userNumberButton.tap()
        
        let enterView = app.otherElements["enterView"]
        XCTAssertTrue(enterView.exists, "View is not found.")
        
        let textField = app.textFields["textField"]
        XCTAssertTrue(textField.exists, "TextField is not found.")
        textField.tap()
        textField.typeText("43")
        
        let displayButton = app.buttons["displayButton"]
        XCTAssertTrue(displayButton.exists, "Button is not found.")
        displayButton.tap()
        
        let numberLabel = app.staticTexts["numberLabel"]
        let _ = numberLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(numberLabel.exists, "Label is not found.")
        
        let label = app.staticTexts["label"]
        XCTAssertTrue(label.exists, "Label is not found.")
        
        let backButton = app.buttons["backButton"]
        XCTAssertTrue(backButton.exists, "Button is not found.")
        backButton.tap()
    }
    
    @MainActor
    func testRandomNumberButton() throws {
        let app = XCUIApplication()
        
        let titleLabel = app.staticTexts["titleLabel"]
        XCTAssertTrue(titleLabel.exists, "Label is not found.")
        
        let subtitleLabel = app.staticTexts["subtitleLabel"]
        XCTAssertTrue(subtitleLabel.exists, "Label is not found.")
        
        let diceView = app.otherElements["diceView"]
        XCTAssertTrue(diceView.exists, "View is not found.")
        
        let buttonsStackView = app.otherElements["buttonsStackView"]
        XCTAssertTrue(buttonsStackView.exists, "StackView is not found.")
        
        let randomNumberButton = app.buttons["randomNumberButton"]
        XCTAssertTrue(randomNumberButton.exists, "Button is not found.")
        randomNumberButton.tap()
                
        let displayButton = app.buttons["displayButton"]
        XCTAssertTrue(displayButton.exists, "Button is not found.")
        displayButton.tap()
        
        let numberLabel = app.staticTexts["numberLabel"]
        let _ = numberLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(numberLabel.exists, "Label is not found.")
        
        let label = app.staticTexts["label"]
        XCTAssertTrue(label.exists, "Label is not found.")
        
        let backButton = app.buttons["backButton"]
        XCTAssertTrue(backButton.exists, "Button is not found.")
        backButton.tap()
    }
    
    @MainActor
    func testNumberInRangeButton() throws {
        let app = XCUIApplication()
        
        let titleLabel = app.staticTexts["titleLabel"]
        XCTAssertTrue(titleLabel.exists, "Label is not found.")
        
        let subtitleLabel = app.staticTexts["subtitleLabel"]
        XCTAssertTrue(subtitleLabel.exists, "Label is not found.")
        
        let diceView = app.otherElements["diceView"]
        XCTAssertTrue(diceView.exists, "View is not found.")
        
        let buttonsStackView = app.otherElements["buttonsStackView"]
        XCTAssertTrue(buttonsStackView.exists, "StackView is not found.")
        
        let numberInRangeButton = app.buttons["numberInRangeButton"]
        XCTAssertTrue(numberInRangeButton.exists, "Button is not found.")
        numberInRangeButton.tap()
        
        let enterView = app.otherElements["enterView"]
        XCTAssertTrue(enterView.exists, "View is not found.")
        
        let textField = app.textFields["textField"]
        XCTAssertTrue(textField.exists, "TextField is not found.")
        textField.tap()
        textField.typeText("52 98")
        
        let displayButton = app.buttons["displayButton"]
        XCTAssertTrue(displayButton.exists, "Button is not found.")
        displayButton.tap()
        
        let numberLabel = app.staticTexts["numberLabel"]
        let _ = numberLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(numberLabel.exists, "Label is not found.")
        
        let label = app.staticTexts["label"]
        XCTAssertTrue(label.exists, "Label is not found.")
        
        let backButton = app.buttons["backButton"]
        XCTAssertTrue(backButton.exists, "Button is not found.")
        backButton.tap()
    }
    
    @MainActor
    func testMultipleNumbersButton() throws {
        let app = XCUIApplication()
        
        let titleLabel = app.staticTexts["titleLabel"]
        XCTAssertTrue(titleLabel.exists, "Label is not found.")
        
        let subtitleLabel = app.staticTexts["subtitleLabel"]
        XCTAssertTrue(subtitleLabel.exists, "Label is not found.")
        
        let diceView = app.otherElements["diceView"]
        XCTAssertTrue(diceView.exists, "View is not found.")
        
        let buttonsStackView = app.otherElements["buttonsStackView"]
        XCTAssertTrue(buttonsStackView.exists, "StackView is not found.")
        
        let multipleNumbersButton = app.buttons["multipleNumbersButton"]
        XCTAssertTrue(multipleNumbersButton.exists, "Button is not found.")
        multipleNumbersButton.tap()
        
        let enterView = app.otherElements["enterView"]
        XCTAssertTrue(enterView.exists, "View is not found.")
        
        let textField = app.textFields["textField"]
        XCTAssertTrue(textField.exists, "TextField is not found.")
        textField.tap()
        textField.typeText("11 45 86")
        
        let displayButton = app.buttons["displayButton"]
        XCTAssertTrue(displayButton.exists, "Button is not found.")
        displayButton.tap()
        
        let label = app.staticTexts["label"]
        let _ = label.waitForExistence(timeout: 5)
        XCTAssertTrue(label.exists, "Label is not found.")
        
        let backButton = app.buttons["backButton"]
        XCTAssertTrue(backButton.exists, "Button is not found.")
        backButton.tap()
    }
}
