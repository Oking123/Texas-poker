//
//  selectHandController.swift
//  Txas
//
//  Created by 陈彦廷 on 2020-04-01.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit

protocol SendHandDelegate{
    func sendHand(message: [Any], index: Int)
}

class SelectHandController:UIViewController{
    @IBOutlet weak var a1: UIImageView!
    @IBOutlet weak var a2: UIImageView!
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
    
    var local_ImageCard : [Any]?
    var local_ImageCard_index: Int?
    
    var delegate : SendHandDelegate?
    
    lazy var images_2 = [UIImageView](arrayLiteral: a1,a2)
    lazy var images_temp_2 = [UIImageView](arrayLiteral: a1,a2)
    lazy var images = [UIImageView](arrayLiteral: image_1,image_2,image_3,image_4,image_5,image_6,image_7,image_8,image_9,image_10,image_11,image_12,image_13)
    lazy var image_poker = [UIImage]()
    lazy var pre_card = [String]()
    var someDict:[UIImageView:String] = [:]
    var choose_item:UIImageView!
    var tap_item:UIImageView!
    var state = 0
    var suit = 0
    var tap_suit = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //addPanGesture
        view.isMultipleTouchEnabled = true
        for i in images_2
        {
            if someDict[i] == nil
            {
                someDict[i] = String(-1)
            }
        }
        for card in cal.get_cardpool()
        {
            if card.point != 14
            {
                let temp = String(card.suit*100+(card.point-1))
                if card.suit == 0
                {
                    images[card.point-1].image = nil
                }
                pre_card.append(temp)
            }
            if card.point == 14
            {
                let temp = String(card.suit*100+0)
                if card.suit == 0
                {
                    images[0].image = nil
                }
                pre_card.append(temp)
            }
        }
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

        if(local_ImageCard![0] as! Int != -1){
            let card =  Card(index:cal.transform_chj(use: local_ImageCard![0] as! Int))
            images_2[0].image = #imageLiteral(resourceName: (suits[card.suit]! + points[card.point]!))
            let temp = "\(local_ImageCard![0])"
            someDict[a1] = temp
        }
        if(local_ImageCard![1] as! Int != -1){
            let card =  Card(index:cal.transform_chj(use: local_ImageCard![1] as! Int))
            images_2[1].image = #imageLiteral(resourceName: (suits[card.suit]! + points[card.point]!))
            let temp = "\(local_ImageCard![1])"
            someDict[a2] = temp
        }
        tap_item = images_temp_2[0]
        tap_item.alpha = 0.5
        state = 1
        if someDict[tap_item] != String(-1)
        {
            let value = Int(someDict[tap_item]!)
            let indx = value!%100
            let p = value! - indx
            if p == suit*100
            {
                images[indx].image = tap_item.image
            }
            for (inx,k) in pre_card.enumerated()
            {
                if Int(k) == value
                {
                    pre_card.remove(at: inx)
                }
            }
        }
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(SelectHandController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        var temp_values: [Any]? = []
        for item in images_2
        {
            if(someDict[item] == nil){
                temp_values?.append(-1)
            }
            else{
                temp_values?.append(Int(someDict[item]!)!)
            }
        }
        local_ImageCard = temp_values
        self.delegate?.sendHand(message: local_ImageCard!, index: local_ImageCard_index!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DidPokerChanged(_ sender: UISegmentedControl) {
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
                for card in pre_card
                {
                    if String(suit*100+index) == card
                    {
                        item.image = nil
                    }
                }
            }
            if someDict[tap_item] != String(-1)
            {
                let value = Int(someDict[tap_item]!)
                let indx = value!%100
                let p = value! - indx
                if p == suit*100
                {
                    images[indx].image = tap_item.image
                }
                for (inx,k) in pre_card.enumerated()
                {
                    if Int(k) == value
                    {
                        pre_card.remove(at: inx)
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
                for card in pre_card
                {
                    if String(suit*100+index) == card
                    {
                        item.image = nil
                    }
                }
            }
            if someDict[tap_item] != String(-1)
            {
                let value = Int(someDict[tap_item]!)
                let indx = value!%100
                let p = value! - indx
                if p == suit*100
                {
                    images[indx].image = tap_item.image
                }
                for (inx,k) in pre_card.enumerated()
                {
                    if Int(k) == value
                    {
                        pre_card.remove(at: inx)
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
                for card in pre_card
                {
                    if String(suit*100+index) == card
                    {
                        item.image = nil
                    }
                }
            }
            if someDict[tap_item] != String(-1)
            {
                let value = Int(someDict[tap_item]!)
                let indx = value!%100
                let p = value! - indx
                if p == suit*100
                {
                    images[indx].image = tap_item.image
                }
                for (inx,k) in pre_card.enumerated()
                {
                    if Int(k) == value
                    {
                        pre_card.remove(at: inx)
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
                for card in pre_card
                {
                    if String(suit*100+index) == card
                    {
                        item.image = nil
                    }
                }
            }
            if someDict[tap_item] != String(-1)
            {
                let value = Int(someDict[tap_item]!)
                let indx = value!%100
                let p = value! - indx
                if p == suit*100
                {
                    images[indx].image = tap_item.image
                }
                for (inx,k) in pre_card.enumerated()
                {
                    if Int(k) == value
                    {
                        pre_card.remove(at: inx)
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
        for item in images_2
        {
            //var p = item.convert(item.frame, to: self.view)
            if (item.frame.contains(location))
            {
                if tap_item != nil
                {
                    tap_item.alpha = 1.0
                }
                state = 0
                break
            }
        }
        if state == 1
        {
            for (index,item) in images.enumerated()
            {
                //var p = item.convert(item.frame, to: self.view)
                let point = item.convert(location,from:touch.view)
                if (point == location)
                {
                    if item.image != nil
                    {
                        choose_item = item
                        tap_item.image = choose_item.image
                        tap_item.alpha = 1.0
                        choose_item.image = nil
                        someDict[tap_item] = String(index+suit*100)

                        for (ind,it) in images_temp_2.enumerated()
                        {
                            if tap_item == it
                            {
                                images_temp_2.remove(at: ind)
                                break
                            }
                        }
                        if images_temp_2.count != 0
                        {
                            tap_item = images_temp_2[0]
                            tap_item.alpha = 0.5
                            if someDict[tap_item] != String(-1)
                            {
                                let value = Int(someDict[tap_item]!)
                                let indx = value!%100
                                let p = value! - indx
                                if p == suit*100
                                {
                                    images[indx].image = tap_item.image
                                }
                            }
                        }
                        if images_temp_2.count == 0
                        {
                            state = 0
                        }
                        break
                    }
                }
            }
        }
        if state == 0
        {
            for item in images_2
            {
                //var p = item.convert(item.frame, to: self.view)
                if (item.frame.contains(location))
                {
                    tap_item = item
                    if someDict[tap_item] != String(-1)
                    {
                        let value = Int(someDict[tap_item]!)
                        let indx = value!%100
                        let p = value! - indx
                        if p == suit*100
                        {
                            images[indx].image = tap_item.image
                        }
                    }
                    item.alpha = 0.5
                    state = 1
                    break
                }
            }
            
        }
        
    }
    
    @IBAction func resetPoker(_ sender: UIButton) {
        someDict.removeAll()
        for item in images_2
        {
            item.image = #imageLiteral(resourceName: "cardBackground")
            someDict[item] = String(-1)
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
