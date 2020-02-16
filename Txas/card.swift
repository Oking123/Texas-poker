//
//  card.swift
//  Txas
//
//  Created by Zixuan Jin on 2020-02-11.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import Foundation

class Card:CustomStringConvertible,Equatable{
    
    var suit:Int
    var point:Int
    var index:Int
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.index == rhs.index
    }
    
    /// initialize the card with its suit and point
    /// - Parameters:
    ///   - suit: an integer where [0: "♠", 1: "♥", 2: "♣", 3: "♦"]
    ///   - point: from 1~13
    init(suit:Int, point:Int) {
        self.suit = suit
        if point == 1{
            self.point = 14
        }else{
            self.point = point
        }
        self.index = suit * 13 + point
    }
    
    /// initialize the card with its index from 0~51
    /// - Parameter index: the card from ♠A to♦k, index from 0-51
    init(index:Int){
        self.index = index
        self.suit = index/13
        self.point = index%13 + 1
        if self.point == 1{
            self.point = 14
        }
    }
    
    public var description:String{
        let suits:[Int:String] = [0: "♠", 1: "♥", 2: "♣", 3: "♦"]
        let points:[Int:String] = [14: "A", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9", 10: "10", 11: "J", 12: "Q",13: "K"]
        return suits[self.suit]!+points[self.point]!
    }
}
