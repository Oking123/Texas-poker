//
//  CardTests.swift
//  CardTests
//
//  Created by Zixuan Jin on 2020-03-30.
//  Copyright © 2020 陈彦廷. All rights reserved.
//
import XCTest

@testable import Txas

class CardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// test if A is the largest
    /// - Throws:
    func testA() throws{
        let test_card = Card(suit: 0, point: 1)
        XCTAssert(test_card.point == 14)
    }
    
    /// test if the two cards are equal
    /// - Throws:
    func test_equal() throws{
        let test_cardA = Card(suit: 0, point: 1)
        let test_cardB = Card(suit: 0, point: 1)
        XCTAssert(test_cardA == test_cardB)
    }
    
    func test_performance_all_cards() throws{
        measure {
            var carlist:[Card] = []
            for i in 0...51{
                carlist.append(Card(index: i))
            }
        }
    }


}
