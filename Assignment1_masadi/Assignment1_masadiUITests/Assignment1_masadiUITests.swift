//
//  Assignment1_masadiUITests.swift
//  Assignment1_masadiUITests
//
//  Created by Mohammad Asadi on 1/12/25.
//

import XCTest

final class Assignment1_masadiUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Launch the application
        app = XCUIApplication()
        app.launch()

        // Continue after a failure to check all assertions
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // Clean up after each test
        app = nil
    }
    
    func testAddingPatient() throws {
        // 1. Navigate to the "Add Patient" form
        let addPatientButton = app.buttons["Add Patient"]
        XCTAssertTrue(addPatientButton.exists, "The Add Patient button should be visible.")
        addPatientButton.tap()
        
        // 2. Fill in the required fields in the form
        let firstNameField = app.textFields["First Name"]
        XCTAssertTrue(firstNameField.exists, "The First Name field should exist.")
        firstNameField.tap()
        firstNameField.typeText("John")
        
        let lastNameField = app.textFields["Last Name"]
        XCTAssertTrue(lastNameField.exists, "The Last Name field should exist.")
        lastNameField.tap()
        lastNameField.typeText("Doe")
        
        let dateOfBirthPicker = app.datePickers["dateOfBirthPicker"]
        XCTAssertTrue(dateOfBirthPicker.exists, "The Date of Birth picker should exist.")
        dateOfBirthPicker.tap()

        // Interact with the DatePicker (e.g., adjust year, month, or day)
        let yearWheel = app.pickerWheels.element(boundBy: 2) // Assuming the third wheel represents the year
        XCTAssertTrue(yearWheel.exists, "The year wheel should exist.")
        yearWheel.adjust(toPickerWheelValue: "1990") // Adjust the year to 1990
        
        let monthWheel = app.pickerWheels.element(boundBy: 0) // Assuming the first wheel represents the month
        XCTAssertTrue(monthWheel.exists, "The month wheel should exist.")
        monthWheel.adjust(toPickerWheelValue: "May") // Adjust the month to May
        
        let dayWheel = app.pickerWheels.element(boundBy: 1) // Assuming the second wheel represents the day
        XCTAssertTrue(dayWheel.exists, "The day wheel should exist.")
        dayWheel.adjust(toPickerWheelValue: "15") // Adjust the day to 15
        
        let heightField = app.textFields["Height (cm)"]
        XCTAssertTrue(heightField.exists, "The Height field should exist.")
        heightField.tap()
        heightField.typeText("180")
        
        let weightField = app.textFields["Weight (kg)"]
        XCTAssertTrue(weightField.exists, "The Weight field should exist.")
        weightField.tap()
        weightField.typeText("75")
        
        // 3. Save the new patient
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.exists, "The Save button should exist.")
        XCTAssertTrue(saveButton.isEnabled, "The Save button should be enabled when the form is valid.")
        saveButton.tap()
        
        // 4. Verify the new patient appears in the list
        let patientName = app.staticTexts["Doe, John"]
        XCTAssertTrue(patientName.exists, "The new patient should appear in the patient list.")
    }
}
