//
//  SelectCardTests.swift
//  TxasUITests
//
//  Created by Yuling Hu on 2020-04-04.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import XCTest

class SelectCardUITests: XCTestCase {

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
        // go to selectCard
        app.images["BoardImage1"].tap()
        
        // test hearts
        app.buttons["❤️"].tap()
        for i in 1...13 {
            let image = app.images["Image\(i)"]
            XCTAssertTrue(image.exists)
        }
        
        // test clubs
        app.buttons["♣️"].tap()
        for i in 1...13 {
            let image = app.images["Image\(i)"]
            XCTAssertTrue(image.exists)
        }
        
        // test diamonds
        app.buttons["♦️"].tap()
        for i in 1...13 {
            let image = app.images["Image\(i)"]
            XCTAssertTrue(image.exists)
        }
        
        // test spades
        app.buttons["♠️"].tap()
        for i in 1...13 {
            let image = app.images["Image\(i)"]
            XCTAssertTrue(image.exists)
        }
        
        // go back to tableView
        //app.navigationBars["Txas.selectCard"].buttons["Done"].tap()
    }
    
    
    func testSelectCard() throws{
        // go to selectCard
        app.images["BoardImage1"].tap()
        
        // first card
        app.images["TableImage1"].tap()
        randomChooseSuit()
        let a = Int.random(in: 1 ... 13)
        let imageA = app.images["Image\(a)"]
        imageA.tap()
        XCTAssertTrue(imageA.exists)
        
        // second card
        app.images["TableImage2"].tap()
        randomChooseSuit()
        let b = Int.random(in: 1 ... 13)
        let imageB = app.images["Image\(b)"]
        imageB.tap()
        XCTAssertTrue(imageB.exists)
        
        // third card
        app.images["TableImage3"].tap()
        randomChooseSuit()
        let c = Int.random(in: 1 ... 13)
        let imageC = app.images["Image\(c)"]
        imageC.tap()
        XCTAssertTrue(imageC.exists)
        
        // fourth card
        app.images["TableImage4"].tap()
        randomChooseSuit()
        let d = Int.random(in: 1 ... 13)
        let imageD = app.images["Image\(d)"]
        imageD.tap()
        XCTAssertTrue(imageD.exists)
        
        // fifth card
        app.images["TableImage5"].tap()
        randomChooseSuit()
        let e = Int.random(in: 1 ... 13)
        let imageE = app.images["Image\(e)"]
        imageE.tap()
        XCTAssertTrue(imageE.exists)
        
        // go back to main page
        app.navigationBars["Txas.selectCard"].buttons["Done"].tap()
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
        // go to selectCard
        app.images["BoardImage1"].tap()
        
        // first card
        app.images["TableImage1"].tap()
        randomChooseSuit()
        let a = Int.random(in: 1 ... 13)
        let imageA = app.images["Image\(a)"]
        imageA.tap()
        XCTAssertTrue(imageA.exists)
        
        // second card
        app.images["TableImage2"].tap()
        randomChooseSuit()
        let b = Int.random(in: 1 ... 13)
        let imageB = app.images["Image\(b)"]
        imageB.tap()
        XCTAssertTrue(imageB.exists)
        
        // reset all cards
        app.staticTexts["reset"].tap()
        XCTAssertTrue(app.images["TableImage1"].exists)
        XCTAssertTrue(app.images["TableImage2"].exists)
        
        // go back to main page
        //app.navigationBars["Txas.selectCard"].buttons["Done"].tap()
    }
    
}
