//
//  tableViewController.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-03-30.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit


let cal = Calculate()
let suits:[Int:String] = [0: "a", 1: "b", 2: "c", 3: "d"]
let points:[Int:String] = [14: "1", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9", 10: "10", 11: "11", 12: "12",13: "13"]
class tableViewController: UIViewController{
    @IBOutlet weak var tableView:UITableView!
    var ImageCard_reciever = [Any] (repeating: -1, count: 2)
    var sender_index: Int?
    var Cards: [ImageCards] = []
    var TableCard_reciever = [Any] (repeating: -1, count: 5)

    @IBOutlet weak var floop1: UIImageView!
    @IBOutlet weak var floop2: UIImageView!
    @IBOutlet weak var floop3: UIImageView!
    @IBOutlet weak var turn: UIImageView!
    @IBOutlet weak var river: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cal.set_calculatetimes(set: 251)
        Cards = createArray()
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        
        let UITap1 = UITapGestureRecognizer()
        self.floop1.addGestureRecognizer(UITap1)
        UITap1.addTarget(self, action: #selector(tapclick))
        
        let UITap2 = UITapGestureRecognizer()
        self.floop2.addGestureRecognizer(UITap2)
        UITap2.addTarget(self, action: #selector(tapclick))
        
        let UITap3 = UITapGestureRecognizer()
        self.floop3.addGestureRecognizer(UITap3)
        UITap3.addTarget(self, action: #selector(tapclick))
        
        let UITap4 = UITapGestureRecognizer()
        self.turn.addGestureRecognizer(UITap4)
        UITap4.addTarget(self, action: #selector(tapclick))
        
        let UITap5 = UITapGestureRecognizer()
        self.river.addGestureRecognizer(UITap5)
        UITap5.addTarget(self, action: #selector(tapclick))
    }
    @objc func tapclick()
    {
        performSegue(withIdentifier: "toTable", sender: self)
    }
    
    
    /// Description: add new player, with a maximun of six
    /// - Parameter sender: sender Any
    @IBAction func addButtonTapped(_ sender: Any) {
        if (Cards.count < 6){
            inserNewPlayer()
            cal.addplayer()
            cal.calculate()

            for i in 0...(cal.get_playernumber()-1){
                Cards[i].win_rate = String(format: "%.2f", cal.get_winrate(player_number: i) * 100) + "%"
                Cards[i].tips = String(format: "%.2f", cal.get_drawrate(player_number: i) * 100) + "%"
            }
            self.tableView.reloadData()
        }
        else{
            let alertTitle = "Maxmimun Player: 6."
            let message = "Can not add new player"
            
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
       
        
    }
    
    
    ///insert a need player in the table view list
    func inserNewPlayer(){
        let image = ImageCards(image1:#imageLiteral(resourceName: "cardBackground"), image2:#imageLiteral(resourceName: "cardBackground"), win_rate: "100%", tips: "0%")
        Cards.append(image)
        let temp_winrate = 100/Cards.count
        
        for player in 0...Cards.count - 1{
            Cards[player].win_rate = String(temp_winrate)+"%"
        }
            
        let indexPath = IndexPath(row: Cards.count - 1, section: 0)
        
//        tableView.beginUpdates()
        tableView.insertRows(at:[indexPath], with: .automatic)
//        tableView.endUpdates()
        tableView.reloadData()
        view.endEditing(true)
    }
    
    /// initialize player list: [ImageCards]
    func createArray() ->[ImageCards]{
        var tempImage: [ImageCards] = []
        let image = ImageCards(image1:#imageLiteral(resourceName: "cardBackground"), image2:#imageLiteral(resourceName: "cardBackground"), win_rate: "100%", tips: "0%")
        
        tempImage.append(image)
        return tempImage
    }
}

extension tableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Picture = Cards[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
        cell.setImage(picture: Picture)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
    
    func tableView(_ tableView:UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //delete table cell
    func tableView(_ tableView:UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if cal.get_playernumber() > 1 {
            if editingStyle == .delete{
                Cards.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                cal.removeplayer(remove: indexPath.row)
                cal.calculate()
                for i in 0...(cal.get_playernumber()-1){
                    Cards[i].win_rate = String(format: "%.2f", cal.get_winrate(player_number: i) * 100) + "%"
                    Cards[i].tips = String(format: "%.2f", cal.get_drawrate(player_number: i) * 100) + "%"
                }
                self.tableView.reloadData()
            }
        }
        else{
            let alertTitle = "Warning"
            let message = "Can not delete last player"
            
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // perform segue to select hand card
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath){
        let image = Cards[indexPath.row]
        sender_index = indexPath.row
        performSegue(withIdentifier: "toPlayer", sender: image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "toPlayer":
                let reciever:SelectHandController = segue.destination as! SelectHandController
                ImageCard_reciever[0] = Cards[sender_index!].image1_index
                ImageCard_reciever[1] = Cards[sender_index!].image2_idnex
                reciever.delegate = self
                reciever.local_ImageCard_index = sender_index
                reciever.local_ImageCard = ImageCard_reciever
            case "toTable":
                let reciever:selectCardController = segue.destination as! selectCardController
                reciever.delegate = self
                reciever.local_TableCard = TableCard_reciever
         default: break
        }
       
    }
}

extension tableViewController: SendTableDelegate{
    func sendTable(TableCard: [Any]) {
        TableCard_reciever = TableCard
        let tabledict:[Int:UIImageView] = [0: floop1, 1: floop2, 2: floop3, 3: turn, 4: river]
        for i in 0...4{
            var table: Card? = nil
            
            if(TableCard[i] as! Int != -1){
                table = Card(index:cal.transform_chj(use: TableCard[i] as! Int))
                cal.set_table(at: i, with: table)
                tabledict[i]!.image = #imageLiteral(resourceName: (suits[table!.suit]! + points[table!.point]!))
            }else{
                cal.set_table(at: i, with: nil)
                tabledict[i]!.image = #imageLiteral(resourceName: "cardBackground")
            }
        }
        
        cal.calculate()
        for i in 0...(cal.get_playernumber()-1){
            Cards[i].win_rate = String(format: "%.2f", cal.get_winrate(player_number: i) * 100) + "%"
            Cards[i].tips = String(format: "%.2f", cal.get_drawrate(player_number: i) * 100) + "%"
            
        }
        self.tableView.reloadData()
    }
}

extension tableViewController: SendHandDelegate{
    func sendHand(message: [Any], index: Int) {
        
        var card1: Card? = nil
        var card2: Card? = nil
        if(message[0] as! Int != -1){
            card1 = Card(index:cal.transform_chj(use: message[0] as! Int))
            cal.set_playerhand(set: index, which: 0, use: card1)
            Cards[index].image1 = #imageLiteral(resourceName: (suits[card1!.suit]! + points[card1!.point]!))
            Cards[index].image1_index = (message[0] as! Int)
        }else{
            cal.set_playerhand(set: index, which: 0, use: nil)
            Cards[index].image1 = #imageLiteral(resourceName: "cardBackground")
            Cards[index].image1_index = -1
        }
        if(message[1] as! Int != -1){
            card2 =  Card(index:cal.transform_chj(use: message[1] as! Int))
            cal.set_playerhand(set: index, which: 1, use: card2)
            Cards[index].image2 = #imageLiteral(resourceName: (suits[card2!.suit]! + points[card2!.point]!))
            Cards[index].image2_idnex = (message[1] as! Int)
        }else{
            cal.set_playerhand(set: index, which: 1, use: nil)
            Cards[index].image2 = #imageLiteral(resourceName: "cardBackground")
            Cards[index].image2_idnex = -1
        }
        cal.calculate()
//        print(cal.get_winrate(player_number: index))

        for i in 0...(cal.get_playernumber()-1){
            Cards[i].win_rate = String(format: "%.2f", cal.get_winrate(player_number: i) * 100) + "%"
            Cards[i].tips = String(format: "%.2f", cal.get_drawrate(player_number: i) * 100) + "%"
        }
        self.tableView.reloadData()
    }
}


