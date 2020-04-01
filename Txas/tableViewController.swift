//
//  tableViewController.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-03-30.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit



class tableViewController: UIViewController{
    @IBOutlet weak var tableView:UITableView!
//    var hand1: Any?
//    var hand2: Any?
    var ImageCard_reciever: ImageCards?
    var sender_index: Int?
    var Cards: [ImageCards] = []
    
    @IBOutlet weak var floop1: UIImageView!
    @IBOutlet weak var floop2: UIImageView!
    @IBOutlet weak var floop3: UIImageView!
    @IBOutlet weak var turn: UIImageView!
    @IBOutlet weak var river: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.river.addGestureRecognizer(UITap1)
        UITap5.addTarget(self, action: #selector(tapclick))
        
        
    }
    @objc func tapclick()
    {
        performSegue(withIdentifier: "toTable", sender: self)
    }
    
    
    /// Description: add new player, with a maximun of six
    /// - Parameter sender: sender Any
    @IBAction func addButtonTapped(_ sender: Any) {
        if (Cards.count <= 6){
            inserNewPlayer()
        }
        else{
            let alertTitle = "Maxmimun Player: 6."
            let message = "Can not add new player"
            
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    /// insert a need player in the table view list
    func inserNewPlayer(){
        let image = ImageCards(image1:#imageLiteral(resourceName: "cardBackground"), image2:#imageLiteral(resourceName: "cardBackground"), win_rate: "100%", tips: "0%")
//        print(Cards.count)
//        tempCard.player += 1
        Cards.append(image)
        let temp_winrate = 100/Cards.count
        
        for player in 0...Cards.count - 1{
            
            Cards[player].win_rate = String(temp_winrate)+"%"
//            print(Cards[player].win_rate)
        }
            
        let indexPath = IndexPath(row: Cards.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at:[indexPath], with: .automatic)
        tableView.endUpdates()
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
    
    func tableView(_ tableView:UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            Cards.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath){
//        tableView.deselectRow(at: indexPath, animated: true)
        let image = Cards[indexPath.row]
        sender_index = indexPath.row
        performSegue(withIdentifier: "toPlayer", sender: image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "toPlayer":
                let reciever:SelectHandController = segue.destination as! SelectHandController
                reciever.delegate = self
                reciever.local_ImageCard = sender as? ImageCards
                reciever.local_ImageCard_index = sender_index
            case "toTable":
                print("to be implemented")
//                let reciever:SelectHandController = segue.destination as! SelectHandController
//                reciever.delegate = self
//                reciever.resultCards = (sender as? [Card])!
         default: break
        }
       
    }
}

extension tableViewController: SendMessageDelegate{
    func sendWord(message: ImageCards, index: Int ) {
        print(index)
//        print(message.image1_index,message.image2_idnex)
        let position = IndexPath(row: index, section: 0)
        Cards[index].image1 = #imageLiteral(resourceName: "d5")
        Cards[index].image2 = #imageLiteral(resourceName: "d8")
        
        tableView.beginUpdates()
        self.tableView.reloadRows(at: [position], with: .right)
        tableView.endUpdates()
    }
}

extension tableViewController: SendHandDelegate{
    func sendHand(message: ImageCards, index: Int) {
        print(message.image1_index)
        print(message.image2_idnex)
        let position = IndexPath(row: index, section: 0)
        Cards[index].image1 = #imageLiteral(resourceName: "d5")
        Cards[index].image2 = #imageLiteral(resourceName: "d8")
        tableView.beginUpdates()
        self.tableView.reloadRows(at: [position], with: .right)
        tableView.endUpdates()
    }
}
