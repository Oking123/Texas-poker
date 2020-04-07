//
//  TableViewUITests.swift
//  TableViewUITests
//
//  Created by Weng Yu on 2020-04-04.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import XCTest

class TableViewUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
        app = nil
    }

    func testAddAndDeleteRow() throws {
        let table = app.tables.element(boundBy: 0)
        XCTAssertEqual(table.cells.count, 1)
        
        let addButton = app.buttons["ADD"]
        // Add 5 rows
        for i in 0..<5 {
            addButton.tap()
            XCTAssertEqual(table.cells.count, i + 2)
        }
        
        // Add a row when there are 6 rows
        addButton.tap()
        XCTAssertEqual(table.cells.count, 6)
        // Max player alert
        let maxPlayerAlert = app.alerts["Maxmimun Player: 6."]
        XCTAssertTrue(maxPlayerAlert.exists)
        // Dismiss the alert
        maxPlayerAlert.buttons["OK"].tap()
        
        // Remove 5 rows
        for i in 0..<5 {
            let rowIndex = 5 - i
            let lastRow = table.cells.element(boundBy: rowIndex)
            lastRow.swipeLeft()
            let deleteButton = lastRow.buttons["Delete"]
            XCTAssertTrue(deleteButton.exists)
            deleteButton.tap()
            XCTAssertEqual(table.cells.count, rowIndex)
        }
        
        // Delete the row when there is 1 row
        let firstRow = table.cells.element(boundBy: 0)
        firstRow.swipeLeft()
        let deleteButton = firstRow.buttons["Delete"]
        XCTAssertTrue(deleteButton.exists)
        deleteButton.tap()
        XCTAssertEqual(table.cells.count, 1)
        // Min player alert
        let minPlayerAlert = app.alerts["Warning"]
        XCTAssertTrue(minPlayerAlert.exists)
        // Dismiss the alert
        minPlayerAlert.buttons["OK"].tap()
    }
    
    func testNavigation() throws {
        // Navigate to selecting cards on board
        for i in 0..<5 {
            let boardImage1 = app.images["BoardImage\(i + 1)"]
            boardImage1.tap()
            let selectCardView = app.otherElements["SelectCardView"]
            XCTAssertTrue(selectCardView.exists)
            app.navigationBars["Txas.selectCard"].buttons["Done"].tap()
        }
        
        // Navigate to selecting cards in hand
        let tableCell = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        tableCell.tap()
        let selectHandView = app.otherElements["SelectHandView"]
        XCTAssertTrue(selectHandView.exists)
        app.navigationBars["Txas.SelectHand"].buttons["Done"].tap()
        
        // Navigate to help
        let helpButton = app.buttons["Help"]
        helpButton.tap()
        let helpImage = app.images["HelpImage"]
        XCTAssertTrue(helpImage.exists)
        app.navigationBars["UIView"].buttons["Back"].tap()
    }
}
