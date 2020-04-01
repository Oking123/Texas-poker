//
//  check_hands.swift
//  Txas
//
//  Created by Zixuan Jin on 2020-03-30.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import Foundation

class Check{
    
    let suits:[Int:String] = [0: "♠", 1: "♥", 2: "♣", 3: "♦"]
    let types:[Int:String] = [0: "high card", 1: "a pair", 2: "two pairs", 3: "three of a kind", 4: "straight", 5: "flush", 6: "full house", 7: "four of a kind", 8: "flush straight"]
    
    init() {
    }
    
    
    func check_hands(player:[Card]) -> [Int]{
        //chech if the cards is flush
        func check_flush(_ cards:[Card]) -> Bool{
            let temp = cards[0].suit
            for card in cards{
                if card.suit != temp{
                    return false
                }
            }
            return true
        }
//        check if the cards is straight
        func check_straight(_ cards:[Int]) -> Bool{
            if cards == [1,10,11,12,13]{
                return true
            }
            return Set(cards).count==5 && (cards[4]-cards[0]) == 4
        }
//        check if the numbers are four of a kind
        func check_four_of_a_kind(_ cards:[Int]) -> Bool{
            return Set(cards.prefix(4)).count == 1 || Set(cards.suffix(4)).count == 1
        }
//        check if the numbers is full_house as is known that they are not  four of a kind
        func check_full_house(_ cards:[Int]) -> Bool{
            return Set(cards).count == 2
        }
        func check_three_of_a_kind(_ cards:[Int]) -> Int?{
            var counts:[Int:Int] = [:]
            for i in cards{
                counts[i, default:0] += 1
            }
            for (index,number) in counts{
                if number == 3{
                    return index
                }
            }
            return nil
            
        }
//    check if the hands is two pairs
        func check_two_pair(_ cards:[Int]) -> Bool{
            return Set(cards).count == 3
        }
//    check if the hands is one pair
        func check_one_pair(_ cards:[Int]) -> Bool{
            return Set(cards).count == 4
        }
        
        var numbers:[Int] = []
        
        for card in player{
            numbers.append(card.point)
        }
        
        numbers.sort()
//        flush straight
        if check_flush(player) && check_straight(numbers){
            return [8,numbers[4]]
        }
//        four of a kind
        if check_four_of_a_kind(numbers){
            if numbers[0] == numbers[1]{
                return [7,numbers[0]]
            }
            else{
                return [7,numbers[4]]
            }
        }
//        full house
        if (check_full_house(numbers)){
            return [6, numbers[2]]
        }
//        flush
        if (check_flush(player)){
            return [5, numbers[4]]
        }
//        straight
        if(check_straight(numbers)){
            return [4,numbers[4]]
        }
//        three of a kind
        if(check_three_of_a_kind(numbers) != nil){
            return [3, check_three_of_a_kind(numbers)!]
        }
//        two pairs
        if(check_two_pair(numbers)){
            return [2, numbers[3]]
        }
//        one pair
        if(check_one_pair(numbers)){
            return [1, numbers.reduce(0, +)-Set(numbers).reduce(0,+)]
        }
//        high card
        return [0, numbers[4]]
    }
    
    func outputanswer(_ result:[Int])->String{
        return types[result[0]]!+" with highest card number of "+String(result[1])
    }
    
    //    input two hands and judge if player1 wins,   0:lose;1:win;2:draw
    func if_p1_win(player1:[Card],player2:[Card]) -> Int{
        let p1_result = check_hands(player: player1)
        let p2_result = check_hands(player: player2)
        if p1_result[0] < p2_result[0]{
            return 0}
        else if p1_result[0] > p2_result[0]{
            return 1}
        else{
            if p1_result[1] < p2_result[1]{
                return 0}
            else if p1_result[1] > p2_result[1]{
                return 1}
            else{
//                 if the highest card an the type are all the same, compare the two cards one by one to find a winner
                for i in 0...4{
                    if player1[4-i].point < player2[4-i].point{
                        return 0}
                    else if player1[4-i].point > player2[4-i].point{
                        return 1}}}
            return 2}
    }
}
