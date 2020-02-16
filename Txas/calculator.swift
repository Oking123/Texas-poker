//
//  calculator.swift
//  Txas
//
//  Created by Zixuan Jin on 2020-02-11.
//  Copyright © 2020 陈彦廷. All rights reserved.
//



import Foundation

/// initial with two Card object as [Card, Card], has function set_flop, set_turn, set_river, clear
class Calculate{
    private var player_hand:[Card]?
    private var win_rate:Float = 0
    private var draw_rate:Float = 0
    private var lose_rate:Float = 0
    private var player_number = 2
    private var flop:[Card]? = nil
    private var turn:Card? = nil
    private var river:Card? = nil
    
    let suits:[Int:String] = [0: "♠", 1: "♥", 2: "♣", 3: "♦"]
    let types:[Int:String] = [0: "high card", 1: "a pair", 2: "two pairs", 3: "three of a kind", 4: "straight", 5: "flush", 6: "full house", 7: "four of a kind", 8: "flush straight"]
    
    
    /// initialize the Callulate class with two original cards in player's hand
    /// - Parameter player: [Card] with a size of 2 and should not be duplicate
    init(_ player:[Card]) {
        if player.count != 2{
            fputs("The number of input hands is not 2", stderr)
        }
        self.player_hand = player
    }
    
    /// set the flop of the table with 3 Card object
    /// - Parameter flop: [Card] with size of 3 should not be duplicate with other input
    func set_flop(use flop:[Card]){
        self.flop = flop
    }
    
    /// set the turn of the table with a Card object
    /// - Parameter turn: Card type should not be duplicate with other input
    func set_turn(use turn:Card){
        self.turn = turn
    }
    
    /// set the river of the table with a Card object
    /// - Parameter river: Card type should not be duplicate with other input
    func set_river(use river:Card){
        self.river = river
    }
    
    
    /// clear all the flop, turn, river data and reset the card in player's hand
    /// - Parameter player_hand: [Card] type with size of 2
    func reset(use player_hand:[Card]){
        self.flop = nil
        self.turn = nil
        self.river = nil
        self.player_hand = player_hand
    }
    
//  check the type of the player_hands, return[type ID, highest card]
    private func check_hands(player:[Card]) -> [Int]{
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
    private func outputanswer(_ result:[Int])->String{
        return types[result[0]]!+" with highest card number of "+String(result[1])
    }
    
//    input two hands and judge if player1 wins,   0:lose;1:win;2:draw
    private func if_p1_win(player1:[Card],player2:[Card]) -> Int{
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
    
    func calculate(player_number: Int) -> Float{
        self.player_number = player_number
//      pick 5 from 7 cards
        func five_in_seven(playerhand:[Card],table:[Card])->[Card]{
            var final:[Card] = table
            for i in 0...5{
                for j in i+1...6{
                    var temp:[Card] = playerhand+table
                    temp.remove(at: j)
                    temp.remove(at: i)
                    if if_p1_win(player1: temp, player2: final) == 1{
                        final = temp
                    }
                }
            }
            return final
        }
        
        
        var player1_win:Int = 0

//        loop for 1000 times
        for _ in 1...1000{
//             all chosen cards
            var cardpool:[Card] = player_hand!
            var card1 = player_hand
//             other player's cards
            var players:[[Card]] = []
            var table = [Card]()
//            get five cards on table
            
//            get flop
            if let threecards = flop{
                table += threecards
                cardpool += threecards
            }
            else{
                while table.count < 3{
                    let tempcard = Card(index: Int.random(in: 0...51))
                    if !cardpool.contains(tempcard){
                        table.append(tempcard)
                        cardpool.append(tempcard)
                    }
                }
            }
            
//            get turn
            if let fourthcard = turn{
                table.append(fourthcard)
                cardpool.append(fourthcard)
            }
            else{
                while table.count < 4{
                    let tempcard = Card(index: Int.random(in: 0...51))
                    if !card1!.contains(tempcard){
                        table.append(tempcard)
                        cardpool.append(tempcard)
                    }
                }
            }
//             get river
            if let fifth = river{
                table.append(fifth)
                cardpool.append(fifth)
            }
            else{
                while table.count < 5{
                    let tempcard = Card(index: Int.random(in: 0...51))
                    if !card1!.contains(tempcard){
                        table.append(tempcard)
                        cardpool.append(tempcard)
                    }
                }
            }
//            get cards for players
            for _ in 2...self.player_number{
                var player:[Card] = []
                while player.count < 2{
                    let newcard = Card(index:Int.random(in: 0...51))
                    if !cardpool.contains(newcard){
                        player.append(newcard)
                        cardpool.append(newcard)
                    }
                }
                players.append(player)
            }
//            select 5 from 7 for all players
            card1 = five_in_seven(playerhand: card1!, table: table)
            for i in 0...self.player_number-2{
                players[i] = five_in_seven(playerhand: players[i], table: table)
            }
            
            //judge player1 win
            var count = 0
            for i in 0...self.player_number-2{
                if if_p1_win(player1: card1!, player2: players[i]) == 1{
                    count += 1
                }
            }
            if count == self.player_number-1{
                player1_win += 1
            }
        }
        win_rate = Float(player1_win)/1000.0
        return self.win_rate
        }
    
    
    /// get the present win_rate of the table
    func get_winrate() -> Float{
        return self.win_rate
    }
    
}
