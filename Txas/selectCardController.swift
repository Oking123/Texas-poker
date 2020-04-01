//
//  selectCardController.swift
//  Txas
//
//  Created by 陈彦廷 on 2020-03-31.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit
protocol SendMessageDelegate{
    func sendWord(message: ImageCards, index: Int)
}

class selectCardController: UIViewController {
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
    var local_ImageCard : ImageCards?
    var local_ImageCard_index: Int?
    
    var delegate : SendMessageDelegate?
    
    
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
        
        let newBackButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectCardController.back(sender:)))
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    @objc func back(sender: UIBarButtonItem) {
        if(local_ImageCard_index != nil){
//            if card1.text != ""{
//                local_ImageCard?.image1_index = Int(card1.text!)
//            }
//            if card2.text != ""{
//                local_ImageCard?.image2_idnex = Int(card2.text!)
//            }
            self.delegate?.sendWord(message: local_ImageCard!, index: local_ImageCard_index!)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! tableViewController
        vc.ImageCard_reciever = self.local_ImageCard
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
                    item.alpha = 0.5
                    state = 1
                    break
                }
            }
            
        }
        
    }
    
    
    @IBAction func ResetButton(_ sender: UIButton) {
        choose_item.image = tap_item.image
        tap_item.image = #imageLiteral(resourceName: "截屏2020-01-31下午6.07.07")
        tap_item.alpha = 0.5
        state = 1
    }
    
//    @IBAction func finishSelect(_ sender: UIButton) {
//        for item in images_5
//        {
//            print(someDict[item])
//        }
//
//    }
    
     
    
    
    
}
