//
//  SelectHandCardUITests.swift
//  TxasUITests
//
//  Created by Weng Yu on 2020-04-06.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import XCTest

class SelectHandCardUITests: XCTestCase {
    
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
    
    func testSuits() throws{
        // go to HandCard Page
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        // test hearts
        app.buttons["❤️"].tap()
        for i in 1...13 {
            let image = app.images["HandImage\(i)"]
            XCTAssertTrue(image.exists)
        }
        
        // test clubs
        app.buttons["♣️"].tap()
        for i in 1...13 {
            let image = app.images["HandImage\(i)"]
            XCTAssertTrue(image.exists)
        }
        
        // test diamonds
        app.buttons["♦️"].tap()
        for i in 1...13 {
            let image = app.images["HandImage\(i)"]
            XCTAssertTrue(image.exists)
        }
        
        // test spades
        app.buttons["♠️"].tap()
        for i in 1...13 {
            let image = app.images["HandImage\(i)"]
            XCTAssertTrue(image.exists)
        }
        
        // go back to tableView
        //app.navigationBars["Txas.SelectHand"].buttons["Done"].tap()
    }
    
    func testSelectHandCard() throws{
        // go to HandCard Page
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        // first card
        randomChooseSuit()
        let a = Int.random(in: 1 ... 13)
        let imageA = app.images["HandImage\(a)"]
        imageA.tap()
        XCTAssertTrue(imageA.exists)
        
        // second card
        randomChooseSuit()
        let b = Int.random(in: 1 ... 13)
        let imageB = app.images["HandImage\(b)"]
        imageB.tap()
        XCTAssertTrue(imageB.exists)
        
        // go back to main page
        app.navigationBars["Txas.SelectHand"].buttons["Done"].tap()
    }
    
    private func randomChooseSuit(){
        let suit = Int.random(in: 1...4)
        switch suit {
        case 1:
            app.buttons["♠️"].tap()
        case 2:
            app.buttons["❤️"].tap()
        case 3:
            app.buttons["♣️"].tap()
        default:
            app.buttons["♦️"].tap()
        }
    }
    
    
    func testReset() throws{
        // go to HandCard Page
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        // first card
        randomChooseSuit()
        let a = Int.random(in: 1 ... 13)
        let imageA = app.images["HandImage\(a)"]
        imageA.tap()
        XCTAssertTrue(imageA.exists)
        
        // second card
        randomChooseSuit()
        let b = Int.random(in: 1 ... 13)
        let imageB = app.images["HandImage\(b)"]
        imageB.tap()
        XCTAssertTrue(imageB.exists)
        
        // reset all cards
        app.staticTexts["reset"].tap()
        
        // go back to main page
        app.navigationBars["Txas.SelectHand"].buttons["Done"].tap()
    }
}
