//
//  CalculatorTests.swift
//  TxasTests
//
//  Created by Zixuan Jin on 2020-03-30.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import XCTest

@testable import Txas

class CalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_check_hands() throws{
        let che = Check()
        let result = che.check_hands(player: [Card(suit: 0, point: 1),Card(suit: 0, point: 13),Card(suit: 0, point: 12),Card(suit: 0, point: 11),Card(suit: 0, point: 10)])
        XCTAssert(result == [8, 14])
        let result1 = che.check_hands(player: [Card(suit:0, point: 12), Card(suit: 1, point: 10), Card(suit: 2, point: 10),Card(suit: 1, point: 12), Card(suit: 2, point: 12)])
        XCTAssert(result1 == [6, 12])
        let result2 = che.check_hands(player: [Card(suit: 0, point: 12),Card(suit: 1, point: 12),Card(suit: 2, point: 10),Card(suit: 3, point: 10),Card(suit: 2, point: 8)])
        XCTAssert(result2 == [2, 12])
        let result3 = che.check_hands(player: [Card(suit: 0, point: 7),Card(suit: 1, point: 8),Card(suit: 2, point: 9),Card(suit: 1, point: 10),Card(suit: 1, point: 11)])
        XCTAssert(result3 == [4, 11])
        let result4 = che.check_hands(player: [Card(suit: 0, point: 1), Card(suit: 2, point: 6), Card(suit: 2, point: 2), Card(suit: 3, point: 10),Card(suit: 2, point: 5)])
        XCTAssert(result4 == [0, 14])
    }
    
    func test_if_p1_win() throws{
        let che = Check()
        let player1:[Card] = [Card(suit: 0, point: 1),Card(suit: 0, point: 13),Card(suit: 0, point: 12),Card(suit: 0, point: 11),Card(suit: 0, point: 10)]
        var player2:[Card] = [Card(suit: 0, point: 1),Card(suit: 0, point: 13),Card(suit: 0, point: 12),Card(suit: 0, point: 11),Card(suit: 0, point: 10)]
        XCTAssert(che.if_p1_win(player1:player1,player2:player2)==2)
        player2 = [Card(suit: 0, point: 7),Card(suit: 1, point: 8),Card(suit: 2, point: 9),Card(suit: 1, point: 10),Card(suit: 1, point: 11)]
        XCTAssert(che.if_p1_win(player1:player1,player2:player2)==1)
        XCTAssert(che.if_p1_win(player1:player2,player2:player1)==0)
    }

    func testPerformance_check_hands() throws {
        let che = Check()
        // This is an example of a performance test case.
        self.measure {
            for _ in 0...1000{
                che.check_hands(player: [Card(suit: 0, point: 12),Card(suit: 1, point: 12),Card(suit: 2, point: 10),Card(suit: 3, point: 10),Card(suit: 2, point: 8)])
            }
            
            // Put the code you want to measure the time of here.
        }
    }
    
    /// test when 2 people in the field
    /// - Throws:
    func test_odds_calculate_2_player() throws{
        
        ///AA
        let cal = Calculate()
        cal.set_calculatetimes(set: 5000)
        cal.addplayer()
        cal.set_playerhand(set: 0, which: 0, use: Card(suit: 0, point: 1))
        cal.set_playerhand(set: 0, which: 1, use: Card(suit: 1, point: 1))
        cal.calculate()
        var win_result = cal.get_winrate(player_number: 0)
        XCTAssert(win_result > 0.80 && win_result < 0.90)
        var draw_result = cal.get_drawrate(player_number: 0)
        XCTAssert(draw_result < 0.02)
        
        
        ///7K
        cal.set_playerhand(set: 0, which: 0, use: Card(suit: 0, point: 7))
        cal.set_playerhand(set: 0, which: 1, use: Card(suit: 0, point: 13))
        cal.calculate()
        win_result = cal.get_winrate(player_number: 0)
        draw_result = cal.get_drawrate(player_number: 0)
        XCTAssert(win_result > 0.525 && win_result < 0.59)
        XCTAssert(draw_result > 0.025 && draw_result < 0.045)
        
        /// AA vs KK
        cal.set_playerhand(set: 0, which: 0, use: Card(suit: 0, point: 1))
        cal.set_playerhand(set: 0, which: 1, use: Card(suit: 1, point: 1))
        cal.set_playerhand(set: 1, which: 0, use: Card(suit: 0, point: 13))
        cal.set_playerhand(set: 1, which: 1, use: Card(suit: 1, point: 13))
        cal.calculate()
        let p1_win_rate = cal.get_winrate(player_number: 0)
        let p1_draw_rate = cal.get_drawrate(player_number: 0)
        let p2_win_rate = cal.get_winrate(player_number: 1)
        let p2_draw_rate = cal.get_drawrate(player_number: 1)
        XCTAssert(p1_win_rate > 0.74 && p1_win_rate < 0.84)
        XCTAssert(p2_win_rate > 0.16 && p2_win_rate < 0.26)
        XCTAssert(p1_draw_rate < 0.02 && p2_draw_rate < 0.02 && p1_draw_rate==p2_draw_rate)
    }
    
    func test_odds_6player_without_fold() throws{
        ///AK
        let cal = Calculate()
        cal.set_calculatetimes(set: 251)
        cal.addplayer()
        cal.addplayer()
        cal.addplayer()
        cal.addplayer()
        cal.addplayer()
        cal.set_playerhand(set: 0, which: 0, use: Card(suit: 0, point: 1))
        cal.set_playerhand(set: 0, which: 1, use: Card(suit: 0, point: 13))
        cal.calculate()
        var p1_win = cal.get_winrate(player_number: 0)
        var p1_draw = cal.get_drawrate(player_number: 0)
        XCTAssert(p1_win < 0.35 && p1_win > 0.25)
        XCTAssert(p1_draw < 0.04)
        var p2_win = cal.get_winrate(player_number: 1)
        var p2_draw = cal.get_drawrate(player_number: 1)
        XCTAssert(p2_win < 0.14 && p2_win > 0.11)
        XCTAssert(p2_draw < 0.03 && p2_draw > 0)
        for i in 2...5{
            let win = cal.get_winrate(player_number: i)
            let draw = cal.get_drawrate(player_number: i)
            XCTAssert(win == p2_win)
            XCTAssert(draw == p2_draw)
        }
        
        cal.set_table(at: 0, with: Card(suit: 1, point: 8))
        cal.set_table(at: 1, with: Card(suit: 2, point: 7))
        cal.set_table(at: 2, with: Card(suit: 2, point: 13))
        cal.set_table(at: 3, with: Card(suit: 1, point: 13))
        cal.set_table(at: 4, with: Card(suit: 3, point: 10))
        cal.calculate()
        p1_win = cal.get_winrate(player_number: 0)
        p1_draw = cal.get_drawrate(player_number: 0)
        p2_win = cal.get_winrate(player_number: 1)
        p2_draw = cal.get_drawrate(player_number: 1)
        XCTAssert(p1_win < 0.83 && p1_win > 0.73)
        XCTAssert(p1_draw < 0.03)
        XCTAssert(p2_win < 0.06 && p2_win > 0.03)
        XCTAssert(p2_draw < 0.03)
    }
    
    func test_performance_6_player(){
        self.measure {
            let cal = Calculate()
            cal.set_calculatetimes(set: 100)
            cal.addplayer()
            cal.addplayer()
            cal.addplayer()
            cal.addplayer()
            cal.addplayer()
            cal.set_playerhand(set: 0, which: 0, use: Card(suit: 0, point: 1))
            cal.set_playerhand(set: 0, which: 1, use: Card(suit: 0, point: 13))
            cal.calculate()
        }
        
    }
    
    func test_performace_2_player(){
        self.measure {
            let cal = Calculate()
            cal.set_calculatetimes(set: 100)
            cal.set_playerhand(set: 0, which: 0, use: Card(suit: 0, point: 1))
            cal.set_playerhand(set: 0, which: 1, use: Card(suit: 1, point: 1))
            cal.calculate()
        }
    }
    
    
    func test_noinput(){
        let cal = Calculate()
        cal.calculate()
        let p1_win_rate = cal.get_winrate(player_number: 0)
        let p1_drwa_rate = cal.get_drawrate(player_number: 0)
        XCTAssert(p1_win_rate == 1)
        XCTAssert(p1_drwa_rate == 0)
    }
    
    
    func test_remove_player(){
        let cal = Calculate()
        cal.set_calculatetimes(set: 251)
        cal.addplayer()
        cal.addplayer()
        cal.set_playerhand(set: 0, which: 0, use: Card(suit: 0, point: 13))
        cal.set_playerhand(set: 0, which: 1, use: Card(suit: 1, point: 13))
        cal.set_playerhand(set: 2, which: 0, use: Card(suit: 0, point: 1))
        cal.set_playerhand(set: 2, which: 1, use: Card(suit: 1, point: 1))
        cal.calculate()
        var p1_win_rate = cal.get_winrate(player_number: 0)
        var p3_win_rate = cal.get_winrate(player_number: 2)
        print(p1_win_rate,p3_win_rate)
        XCTAssert(p1_win_rate > 0.11 && p1_win_rate < 0.21)
        XCTAssert(p3_win_rate > 0.65 && p3_win_rate < 0.75)
        cal.removeplayer(remove: 2)
        cal.calculate()
        p1_win_rate = cal.get_winrate(player_number: 0)
        p3_win_rate = cal.get_winrate(player_number: 2)
        XCTAssert(p1_win_rate > 0.76 && p1_win_rate < 0.86)
    }
    
    func test_reset(){
        let cal = Calculate()
        cal.set_calculatetimes(set: 251)
        cal.addplayer()
        cal.addplayer()
        cal.set_playerhand(set: 0, which: 0, use: Card(suit: 0, point: 13))
        cal.set_playerhand(set: 0, which: 1, use: Card(suit: 1, point: 13))
        cal.set_playerhand(set: 2, which: 0, use: Card(suit: 0, point: 1))
        cal.set_playerhand(set: 2, which: 1, use: Card(suit: 1, point: 1))
        cal.reset()
        cal.calculate()
        var p1_win_rate = cal.get_winrate(player_number: 0)
        XCTAssert(p1_win_rate > 0.27 && p1_win_rate < 0.37)
        cal.removeplayer(remove: 2)
        cal.calculate()
        p1_win_rate = cal.get_winrate(player_number: 0)
        let p2_win_rate = cal.get_winrate(player_number: 1)
        XCTAssert(p1_win_rate>0.45 && p1_win_rate<0.55)
        XCTAssert(p2_win_rate>0.45 && p2_win_rate<0.55)
        XCTAssert(p1_win_rate==p2_win_rate)
    }
    
    func test_get_playernumber(){
        let cal = Calculate()
        XCTAssert(cal.get_playernumber()==1)
        cal.addplayer()
        XCTAssert(cal.get_playernumber()==2)
        cal.reset()
        XCTAssert(cal.get_playernumber()==2)
        cal.removeplayer(remove: 1)
        XCTAssert(cal.get_playernumber()==1)
        
    }
    
    func test_shuffle(){
        var test_list:[Int] = [1,2,3]
        var result:[Int] = [0,0,0,0,0,0]
        for _ in 1...10000{
            test_list = [1,2,3]
            test_list.shuffle()
            switch test_list{
            case [1,2,3]:
                result[0] += 1
            case [1,3,2]:
                result[1] += 1
            case [2,1,3]:
                result[2] += 1
            case [2,3,1]:
                result[3] += 1
            case [3,2,1]:
                result[4] += 1
            case [3,1,2]:
                result[5] += 1
            default:
                break
            }
        }
        XCTAssert(result[0] > 1600 && result[0] < 1716)
        XCTAssert(result[1] > 1600 && result[1] < 1716)
        XCTAssert(result[2] > 1600 && result[2] < 1716)
        XCTAssert(result[3] > 1600 && result[3] < 1716)
        XCTAssert(result[4] > 1600 && result[4] < 1716)
        XCTAssert(result[5] > 1600 && result[5] < 1716)
    }
    
    func test_get_table(){
        let cal = Calculate()
        cal.set_table(at: 2, with: Card(suit: 0, point: 1))
        cal.set_table(at: 0, with: Card(suit: 1, point: 1))
        let result = cal.get_table()
        XCTAssert(result == [Card(suit: 1, point: 1),nil,Card(suit: 0, point: 1),nil,nil])
    }
    
    func test_cardpool(){
        let cal = Calculate()
        cal.set_table(at: 2, with: Card(suit: 0, point: 1))
        cal.set_table(at: 0, with: Card(suit: 1, point: 1))
        cal.set_playerhand(set: 0, which: 0, use: Card(suit: 3, point: 3))
        cal.addplayer()
        cal.set_playerhand(set: 1, which: 1, use: Card(suit: 2, point: 10))
        cal.set_playerhand(set: 2, which: 1, use: Card(suit: 2, point: 11))
        let result = cal.get_cardpool()
        XCTAssert(result.count == 4)
        XCTAssert(result.contains(Card(suit: 0, point: 1)))
        XCTAssert(result.contains(Card(suit: 1, point: 1)))
        XCTAssert(result.contains(Card(suit: 3, point: 3)))
        XCTAssert(result.contains(Card(suit: 2, point: 10)))
        XCTAssertFalse(result.contains(Card(suit: 2, point: 11)))
        
    }
}
