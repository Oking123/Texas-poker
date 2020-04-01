//
//  calculator.swift
//  Txas
//
//  Created by Zixuan Jin on 2020-02-11.
//  Copyright © 2020 陈彦廷. All rights reserved.
//



import Foundation

class Calculate{
    private var win_rate:[Float] = [0,0,0,0,0,0]
    private var draw_rate:[Float] = [0,0,0,0,0,0]
    private var player_number = 2
    private var table:[Card?] = [nil,nil,nil,nil,nil]
    private var cardlist:[Card]? = nil
    private var players:[[Card?]] = []
    
    private var calculatetimes = 101
    
    private let check = Check()
    
    private let suits:[Int:String] = [0: "♠", 1: "♥", 2: "♣", 3: "♦"]
    private let types:[Int:String] = [0: "high card", 1: "a pair", 2: "two pairs", 3: "three of a kind", 4: "straight", 5: "flush", 6: "full house", 7: "four of a kind", 8: "flush straight"]
    
    
    init() {
//        init cardlist
        var tempcardlist:[Card] = []
        for i in 0...51{
            let tempcard = Card(index: i)
            tempcardlist.append(tempcard)
        }
        cardlist = tempcardlist
        let player0_hand:[Card?] = [nil,nil]
        let player1_hand:[Card?] = [nil,nil]
        let player2_hand:[Card?] = [nil,nil]
        let player3_hand:[Card?] = [nil,nil]
        let player4_hand:[Card?] = [nil,nil]
        let player5_hand:[Card?] = [nil,nil]
        self.players = [player0_hand,player1_hand,player2_hand,player3_hand,player4_hand,player5_hand]
        self.player_number = 2
    }
    
    /// set times of calculation
    /// - Parameter times: times of calculation
    func set_calculatetimes(set times:Int){
        self.calculatetimes = times
    }
    
    /// remove a player from table
    /// - Parameter number: remove which player
    func removeplayer(remove number:Int){
        self.players[number] = [nil,nil]
        self.player_number -= 1
        for _ in number...4{
            self.players[number] = self.players[number+1]
        }
        
    }
    
    /// add a player
    func addplayer(){
        self.player_number += 1
    }
    
    
    /// set  a player's hand
    /// - Parameters:
    ///   - player: which player
    ///   - hand: wich hand
    ///   - card: the card
    func set_playerhand(set player:Int, which hand:Int ,use card:Card){
        self.players[player][hand] = card
    }
    
    /// set the card on the table
    /// - Parameters:
    ///   - loc: which location of the card, flop:0,1,2, turn:3, river:4
    ///   - card: the card
    func set_table(at loc:Int, with card:Card){
        self.table[loc] = card
    }
    

    
    
    /// clear all the flop, turn, river data and the card in player's hand
    func reset(){
        self.table = [nil,nil,nil,nil,nil]
        self.players = []
        for _ in 0...5{
            self.players.append([nil,nil])
        }
    }
    
    /// set player_number
    /// - Parameter player_number: int
    func set_playernumber(use player_number:Int){
        self.player_number = player_number
    }
    
    /// calculate the win rate of the player given the number of players
    /// - Parameter player_number: the player number left on the table
    func calculate(){
        
//      pick 5 from 7 cards
        func five_in_seven(playerhand:[Card],table:[Card])->[Card]{
            var final:[Card] = table
            for i in 0...5{
                for j in i+1...6{
                    var temp:[Card] = playerhand+table
                    temp.remove(at: j)
                    temp.remove(at: i)
                    if check.if_p1_win(player1: temp, player2: final) == 1{
                        final = temp
                    }
                }
            }
            return final
        }
        
        var wintimes:[Int] = [Int](repeating:0,count:player_number)
        var drawtimes:[Int] = [Int](repeating:0,count:player_number)
        
        
//        loop for 250 times
        for _ in 1...self.calculatetimes{
//             all chosen cards
            var cardpool:[Card] = []
//             other player's card
            var playerhands = self.players
            
            for i in 0...self.player_number-1{
                if let tempcard1 = playerhands[i][0]{
                    cardpool.append(tempcard1)
                }
                if let tempcard2 = playerhands[i][1]{
                    cardpool.append(tempcard2)
                }
            }
            
            var temp_table = self.table
//            shuffle
            self.cardlist?.shuffle()
            self.cardlist?.shuffle()
            var cardindex = 0
//            get five cards on table
//            get flop
            for i in 0...4{
                if let tempcard = temp_table[i]{
                    cardpool.append(tempcard)
                }
            }
            
            for i in 0...4{
                while temp_table[i] == nil{
                    let tempcard = self.cardlist![cardindex]
                    if !cardpool.contains(tempcard){
                        temp_table[i] = (tempcard)
                        cardpool.append(tempcard)
                    }
                    cardindex += 1
                }
            }
            
//            get cards for players
            for i in 0...self.player_number-1{
                for j in 0...1{
                    while playerhands[i][j] == nil{
                        let tempcard = self.cardlist![cardindex]
                        if !cardpool.contains(tempcard){
                            playerhands[i][j] = tempcard
                            cardpool.append(tempcard)
                        }
                        cardindex += 1
                    }
                }
            }
//            select 5 from 7 for all players
            var final_hand:[[Card]] = []
            for i in 0...self.player_number-1{
                final_hand.append(five_in_seven(playerhand: playerhands[i] as! [Card], table:temp_table as! [Card]))
            }
            
            //calculate winplayer and drawplayer
            var wincount:[Int] = [Int](repeating: 0, count: self.player_number)
            var drawcount:[Int] = [Int](repeating: 0, count: self.player_number)
            var losecount:[Int] = [Int](repeating: 0, count: self.player_number)
            
            for i in 0...self.player_number-2{
                if losecount[i] == 0{
                    for j in i+1...self.player_number-1{
                        if check.if_p1_win(player1: final_hand[i], player2: final_hand[j]) == 1{
                            wincount[i] += 1
                            losecount[j] += 1
                        }
                        else if check.if_p1_win(player1: final_hand[i], player2: final_hand[j]) == 2{
                            drawcount[i] += 1
                            drawcount[j] += 1
                        }
                        else if check.if_p1_win(player1: final_hand[i], player2: final_hand[j]) == 0{
                            losecount[i] += 1
                            wincount[j] += 1
                            break
                        }
                    }
                }
            }
            var win_player = 0
            for i in 0...self.player_number-1{
                if wincount[i]>0 && losecount[i] == 0 && drawcount[i] == 0{
                    wintimes[i] += 1
                    win_player += 1
                }
            }
            if win_player == 0{
                for i in 0...self.player_number-1{
                    if losecount[i] == 0 && drawcount[i]>0{
                        drawtimes[i] += 1
                    }
                }
            }

        }
        
        var hasnocard:[Int] = []
        
        for i in 0...self.player_number-1{
            if self.players[i][0] == nil && self.players[i][1] == nil{
                hasnocard.append(i)
            }
        }
        var no_card_win = 0
        var no_card_draw = 0
        for i in 0...self.player_number-1{
            if hasnocard.contains(i){
                no_card_win += wintimes[i]
                no_card_draw += drawtimes[i]
            }
            else{
                self.win_rate[i] = Float(wintimes[i]) / Float(self.calculatetimes)
                self.draw_rate[i] = Float(drawtimes[i]) / Float(self.calculatetimes)
            }
        }
        for item in hasnocard{
            self.win_rate[item] = Float(no_card_win/hasnocard.count) / Float(self.calculatetimes)
            self.draw_rate[item] = Float(no_card_draw/hasnocard.count) / Float(self.calculatetimes)
        }
        
        
    }
    
    
    /// get the present win_rate of the table
    func get_winrate(player_number number:Int) -> Float{
        return self.win_rate[number]
    }
    
    func get_drawrate(player_number number:Int) -> Float{
        return self.draw_rate[number]
    }
    
    
}
