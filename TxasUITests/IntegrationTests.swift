//
//  IntegrationTests.swift
//  TxasUITests
//
//  Created by Weng Yu on 2020-04-06.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import XCTest

class IntegrationTests: XCTestCase {
    
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

    private func compareWinRate(player: Int, lower: Double, upper:Double) {
        let lower = lower-10
        let upper = upper+10
        let table = app.tables.element(boundBy: 0)
        let temp = table.cells.element(boundBy: player-1).staticTexts["WinRate"].label
        let length = temp.count
        let num = String(temp.prefix(length-1))
        let winRate = Double(num)!
        XCTAssert(winRate>lower && winRate<upper)
    }
    
    func testOne() throws {
        // step One
        addPlayer(row:0, suit1: "♠️",HandImage1: "HandImage1",suit2: "❤️",HandImage2: "HandImage1")
        app.buttons["ADD"].tap()
        addPlayer(row:1, suit1: "♠️",HandImage1: "HandImage13",suit2: "❤️",HandImage2: "HandImage13")
        compareWinRate(player: 1, lower: 77.00, upper: 87.00)
        compareWinRate(player: 2, lower: 11.00, upper: 21.00)
        
        // step Two
        app.buttons["ADD"].tap()
        compareWinRate(player: 1, lower: 65.00, upper: 75.00)
        compareWinRate(player: 2, lower: 11.00, upper: 21.00)
        compareWinRate(player: 3, lower: 8.00, upper: 18.00)

        // step Three
        let table = app.tables.element(boundBy: 0)
        let secondRow = table.cells.element(boundBy: 1)
        secondRow.swipeLeft()
        let deleteButton = secondRow.buttons["Delete"]
        XCTAssertTrue(deleteButton.exists)
        deleteButton.tap()
        compareWinRate(player: 1, lower: 79.00, upper: 89.00)
        compareWinRate(player: 2, lower: 10.00, upper: 20.00)
    }

    func testTwo() throws{
        addPlayer(row:0, suit1: "♠️",HandImage1: "HandImage1",suit2: "♠️",HandImage2: "HandImage13")
        app.buttons["ADD"].tap()
        addPlayer(row:1, suit1: "❤️",HandImage1: "HandImage1",suit2: "♣️",HandImage2: "HandImage1")
        addTableCard(position: "TableImage1", suit: "♦️", image: "Image10")
        compareWinRate(player: 2, lower: 81.00, upper: 93.00)
        compareWinRate(player: 1, lower: 4.00, upper: 16.00)
        addTableCard(position: "TableImage2", suit: "♠️", image: "Image11")
        compareWinRate(player: 2, lower: 61.00, upper: 73.00)
        compareWinRate(player: 1, lower: 23.00, upper: 36.00)
        addTableCard(position: "TableImage3", suit: "♠️", image: "Image10")
        compareWinRate(player: 2, lower: 50.00, upper: 62.00)
        compareWinRate(player: 1, lower: 36.00, upper: 48.00)
        addTableCard(position: "TableImage4", suit: "♠️", image: "Image4")
        compareWinRate(player: 2, lower: 0.00, upper: 12.00)
        compareWinRate(player: 1, lower: 86.00, upper: 99.00)
        addTableCard(position: "TableImage5", suit: "❤️", image: "Image1")
        compareWinRate(player: 2, lower: 0.00, upper: 0.00)
        compareWinRate(player: 1, lower: 100.00, upper: 100.00)
    }
    
    func testThree() throws{
        addTableCard(position: "TableImage1", suit: "♠️", image: "Image9")
        addTableCard(position: "TableImage2", suit: "♦️", image: "Image11")
        addTableCard(position: "TableImage3", suit: "❤️", image: "Image11")
        addPlayer(row:0, suit1: "❤️",HandImage1: "HandImage5",suit2: "♠️",HandImage2: "HandImage6")
        app.buttons["ADD"].tap()
        addPlayer(row:1, suit1: "♠️",HandImage1: "HandImage3",suit2: "♦️",HandImage2: "HandImage9")
        app.buttons["ADD"].tap()
        addPlayer(row:2, suit1: "♠️",HandImage1: "HandImage13",suit2: "♠️",HandImage2: "HandImage12")
        app.buttons["ADD"].tap()
        addPlayer(row:3, suit1: "♦️",HandImage1: "HandImage13",suit2: "♦️",HandImage2: "HandImage7")
        app.buttons["ADD"].tap()
        addPlayer(row:4, suit1: "♣️",HandImage1: "HandImage5",suit2: "♦️",HandImage2: "HandImage4")
        app.buttons["ADD"].tap()
        addPlayer(row:5, suit1: "♠️",HandImage1: "HandImage1",suit2: "♦️",HandImage2: "HandImage1")
        
        compareWinRate(player: 1, lower: 0.00, upper: 7.00)
        compareWinRate(player: 2, lower: 4.00, upper: 16.00)
        compareWinRate(player: 3, lower: 10.00, upper: 22.00)
        compareWinRate(player: 4, lower: 0.00, upper: 10.00)
        compareWinRate(player: 5, lower: 0.00, upper: 8.00)
        compareWinRate(player: 6, lower: 59.00, upper: 71.00)
    }
    
    private func addPlayer(row: Int, suit1: String, HandImage1: String, suit2: String, HandImage2: String){
        app.tables.element(boundBy: 0).cells.element(boundBy: row).tap()
        // add two hand cards
        app.buttons[suit1].tap()
        let imageA = app.images[HandImage1]
        imageA.tap()
        XCTAssertTrue(imageA.exists)
        app.buttons[suit2].tap()
        let imageB = app.images[HandImage2]
        imageB.tap()
        XCTAssertTrue(imageB.exists)
        // go back to main page
        app.navigationBars["Txas.SelectHand"].buttons["Done"].tap()
    }
    
    private func addTableCard(position: String, suit: String, image: String){
        app.images["BoardImage1"].tap()
        app.images[position].tap()
        app.buttons[suit].tap()
        let imageA = app.images[image]
        imageA.tap()
        XCTAssertTrue(imageA.exists)
        app.navigationBars["Txas.selectCard"].buttons["Done"].tap()
    }
}
