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
    
    var Cards: [ImageCards] = []
    var names = [String]()
    var cardImage : [String]!
    //var Cards: [ImageCards] = []
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Cards = createArray()
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
//        self.cardImage = ["cardBackground"]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        inserNewPlayer()
    }
    
    func inserNewPlayer(){
        var tempCard = Cards[Cards.count - 1]
        tempCard.player += 1
        Cards.append(tempCard)
        
        let indexPath = IndexPath(row: Cards.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at:[indexPath], with: .automatic)
        tableView.endUpdates()
        
        view.endEditing(true)
    }
    
    func createArray() ->[ImageCards]{
        var tempImage: [ImageCards] = []
        
        let image = ImageCards(image1:#imageLiteral(resourceName: "cardBackground"), image2:#imageLiteral(resourceName: "cardBackground"), win_rate: "0", tips: "0", player: 0)
        
        tempImage.append(image)
        return tempImage
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//
////        cell!.imageView!.image = UIImage(named: cardImage[indexPath.row])
//
//        if let lbl = cell?.contentView.viewWithTag(101) as? UILabel {
//            lbl.text = names[indexPath.row]
//        }
//
////        if let btnDelete = cell?.contentView.viewWithTag(102) as? UIButton {
////            btnDelete.addTarget(self, action: #selector(deleteRow(_ :)), for: .touchUpInside)
////        }
//        return cell!
//    }
    
//   

//


//    @objc func deleteRow(_ sender: UIButton) {
//        let point = sender.convert(CGPoint.zero, to: tblList)
//        guard let indexPath = tblList.indexPathForRow(at: point) else {
//            return
//        }
//        names.remove(at: indexPath.row)
//        tblList.deleteRows(at: [indexPath], with: .left)
//    }
    
}

extension tableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cards.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let Picture = Cards[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell

    //        cell!.imageView!.image = UIImage(named: cardImage[indexPath.row])
//
//            if let lbl = cell?.contentView.viewWithTag(101) as? UILabel {
//                lbl.text = names[indexPath.row]
//            }
//            return cell!
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
    
//    func tableView(talbeView: UITableView, cellForRowAtIndexPath
//     indexPath: NSIndexPath) -> UITableViewCell{
//     let cell = UITableViewCell()
//     cell.textLabel!.text = self.names[indexPath.row]
//     return cell
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            names.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .left)
//        }
//    }
//
//    @IBAction func addRow(_ sender: UIButton) {
//        names.insert("New Name", at: 0)
//        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
//    }
}
