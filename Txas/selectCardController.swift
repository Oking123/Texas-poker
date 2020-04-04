//
//  selectCardController.swift
//  Txas
//
//  Created by 陈彦廷 on 2020-03-31.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit
protocol SendTableDelegate{
    func sendTable(TableCard: [Any])
}

class selectCardController: UIViewController {
    let cal = Calculate()
    let suits:[Int:String] = [0: "a", 1: "b", 2: "c", 3: "d"]
    let points:[Int:String] = [14: "1", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9", 10: "10", 11: "11", 12: "12",13: "13"]
    
      //variances of poker
        @IBOutlet weak var image_1: UIImageView!
        @IBOutlet weak var image_2: UIImageView!
        @IBOutlet weak var image_3: UIImageView!
        @IBOutlet weak var image_4: UIImageView!
        @IBOutlet weak var image_5: UIImageView!
        @IBOutlet weak var image_6: UIImageView!
        @IBOutlet weak var image_7: UIImageView!
        @IBOutlet weak var image_8: UIImageView!
        @IBOutlet weak var image_9: UIImageView!
        @IBOutlet weak var image_10: UIImageView!
        @IBOutlet weak var image_11: UIImageView!
        @IBOutlet weak var image_12: UIImageView!
        @IBOutlet weak var image_13: UIImageView!
    //variance of deliever pokers
        @IBOutlet weak var a1: UIImageView!
        @IBOutlet weak var a2: UIImageView!
        @IBOutlet weak var a3: UIImageView!
        @IBOutlet weak var a4: UIImageView!
        @IBOutlet weak var a5: UIImageView!
    //
    var local_TableCard: [Any]?
    var delegate : SendTableDelegate?
    var tap_suit = -1
    
    
    lazy var images_5 = [UIImageView](arrayLiteral: a1,a2,a3,a4,a5)
    lazy var images = [UIImageView](arrayLiteral: image_1,image_2,image_3,image_4,image_5,image_6,image_7,image_8,image_9,image_10,image_11,image_12,image_13)
    lazy var image_poker = [UIImage]()
    var someDict:[UIImageView:String] = [:]
    var choose_item:UIImageView!
    var tap_item:UIImageView!
    var state = 0
    var suit = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //addPanGesture
        view.isMultipleTouchEnabled = true
        // Do any additional setup after loading the view
        for i in 0..<13
        {
            let tempImage = UIImage(named: "a\(i+1)")!
            image_poker.append(tempImage)
        }
        for i in 0..<13
        {
            let tempImage = UIImage(named: "b\(i+1)")!
            image_poker.append(tempImage)
        }
        for i in 0..<13
        {
            let tempImage = UIImage(named: "c\(i+1)")!
            image_poker.append(tempImage)
        }
        for i in 0..<13
        {
            let tempImage = UIImage(named: "d\(i+1)")!
            image_poker.append(tempImage)
        }
        for i in 0...4{
            if(local_TableCard![i] as! Int != -1){
                let table = Card(index:cal.transform_chj(use: local_TableCard![i] as! Int))
                images_5[i].image = #imageLiteral(resourceName: (suits[table.suit]! + points[table.point]!))
                let temp = "\(local_TableCard![i])"
                someDict[images_5[i]] = temp
            }
            else{
                images_5[i].image = #imageLiteral(resourceName: "cardBackground")
                someDict[images_5[i]] = String(-1)
            }
        }
        
        let newBackButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectCardController.back(sender:)))
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    @objc func back(sender: UIBarButtonItem) {
        var temp_values: [Int] = []
        for item in images_5
        {
            if(someDict[item] == nil){
                temp_values.append(-1)
            }
            else{
                temp_values.append(Int(someDict[item]!)!)
            }
        }
        
        local_TableCard = temp_values
        self.delegate!.sendTable(TableCard: local_TableCard!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func pokerDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            suit = 0
            for (index,item) in images.enumerated()
            {
                item.image = UIImage(named: "a\(index+1)")
                for (key, _) in someDict
                {
                    let temp = someDict[key]
                    if String(suit*100+index) == temp
                    {
                        item.image = nil
                    }
                }
            }
            
        case 1:
            suit = 1
            for (index,item) in images.enumerated()
            {
                item.image = UIImage(named: "b\(index+1)")
                for (key, _) in someDict
                {
                    let temp = someDict[key]
                    if String(suit*100+index) == temp
                    {
                        item.image = nil
                    }
                }
            }
            
        case 2:
            suit = 2
            for (index,item) in images.enumerated()
            {
                item.image = UIImage(named: "c\(index+1)")
                for (key, _) in someDict
                {
                    let temp = someDict[key]
                    if String(suit*100+index) == temp
                    {
                        item.image = nil
                    }
                }
            }
            
        case 3:
            suit = 3
            for (index,item) in images.enumerated()
            {
                item.image = UIImage(named: "d\(index+1)")
                for (key, _) in someDict
                {
                    let temp = someDict[key]
                    if String(suit*100+index) == temp
                    {
                        item.image = nil
                    }
                }
            }
            
        default:
            for (_,item) in images.enumerated()
            {
                item.image = nil
            }
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first!
        let location = touch.location(in: self.view)
        if state == 1
        {
            for (index,item) in images.enumerated()
            {
                //var p = item.convert(item.frame, to: self.view)
                let point = item.convert(location,from:touch.view)
                if (point == location)
                {
                    choose_item = item
                    tap_item.image = choose_item.image
                    tap_item.alpha = 1.0
                    choose_item.image = nil
                    someDict[tap_item] = String(index+suit*100)
                    tap_suit = suit
                    state = 0
                    break
                }
            }
        }
        if state == 0
        {
            for item in images_5
            {
                //var p = item.convert(item.frame, to: self.view)
                let point = item.convert(location,from:touch.view)
                if (point == location)
                {
                    tap_item = item
                    if someDict[tap_item] != String(-1)
                    {
                        if tap_suit == suit
                        {
                            choose_item.image = tap_item.image
                        }
                    }
                    item.alpha = 0.5
                    state = 1
                    break
                }
            }
            
        }
    }

    @IBAction func ResetButton(_ sender: UIButton) {
        someDict.removeAll()
        for item in images_5
        {
            item.image = #imageLiteral(resourceName: "cardBackground")
        }
        for (index,it) in images.enumerated()
        {
            if suit == 0
            {
                it.image = UIImage(named: "a\(index+1)")
            }
            else if suit == 1
            {
                it.image = UIImage(named: "b\(index+1)")
            }
            else if suit == 2
            {
                it.image = UIImage(named: "c\(index+1)")
            }
            else if suit == 3
            {
                it.image = UIImage(named: "d\(index+1)")
            }
            
        }
    }
    
}
