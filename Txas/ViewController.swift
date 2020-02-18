//
//  ViewController.swift
//  Txas
//
//  Created by 陈彦廷 on 2020-01-18.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var NumberOfPlayer: UILabel!
    var player = ""
    
    @IBOutlet weak var dropPlayer: UITextField!
    
    //variances of poker

    let cal = Calculate()
    
    var suit: Int = 0 //defalut suit is spade
    var point: Int = 0
    
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
    //variance of hand pokers
      @IBOutlet weak var hand1: UIImageView!

      @IBOutlet weak var hand2: UIImageView!
    
    /// placeholder for table cards
    lazy var images_5 = [UIImageView](arrayLiteral: a1,a2,a3,a4,a5)
    /// place holder for hand cards
    lazy var images_2 = [UIImageView](arrayLiteral: hand1,hand2)
    lazy var images = [UIImageView](arrayLiteral: image_1,image_2,image_3,image_4,image_5,image_6,image_7,image_8,image_9,image_10,image_11,image_12,image_13)
    
    //CGPoint defines coordinates in 2D space. It's composed of two CGFloats: X and Y.
    var original = [UIImageView:CGPoint]()
    var original_images_5 = [UIImageView:CGPoint]()
    var original_images_2 = [UIImageView:CGPoint]()
    var drag_item:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //number of player
        NumberOfPlayer.text = "Number of player: " + player
        // Do any additional setup after loading the view
        //addPanGesture()
        
        view.isMultipleTouchEnabled = true
        
        //add initial coordiantes to every canadiate card when initializing
        for item in images
        {
            original[item] = item.center
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let title_lable1 = UILabel()
        title_lable1.text = "Texas"
        title_lable1.font = UIFont(name: "Marker Felt", size: 17)
        title_lable1.sizeToFit()
        
        let title_lable2 = UILabel()
        title_lable2.text = "Poker"
        title_lable2.font = UIFont(name: "Menlo", size: 30)
        title_lable2.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [title_lable1,title_lable2])
        stackView.axis = .horizontal
        stackView.frame.size.width = title_lable1.frame.width + title_lable2.frame.width
        stackView.frame.size.height = max(title_lable1.frame.height,title_lable2.frame.height)
        
        navigationItem.titleView = stackView
        setCustomerBackImage()
    }
    
    @IBAction func done(_ sender: Any) {
        let NumberOfPlayer = Int(player)!
        let NumberDrop:Int? = Int(dropPlayer.text!)
        let PlayerInGame = NumberOfPlayer - NumberDrop!
        player = String(PlayerInGame)
    }
    
    
    func setCustomerBackImage(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style: .plain, target: nil, action: nil)
    }

//control button of changing color
    @IBAction func spadeButton(_ sender: UIButton) {
        image_1.image = #imageLiteral(resourceName: "a1");
        image_2.image = #imageLiteral(resourceName: "a2") ;
        image_3.image = #imageLiteral(resourceName: "a3") ;
        image_4.image = #imageLiteral(resourceName: "a4") ;
        image_5.image = #imageLiteral(resourceName: "a5") ;
        image_6.image = #imageLiteral(resourceName: "a6") ;
        image_7.image = #imageLiteral(resourceName: "a7") ;
        image_8.image = #imageLiteral(resourceName: "a8") ;
        image_9.image = #imageLiteral(resourceName: "a9") ;
        image_10.image = #imageLiteral(resourceName: "a10") ;
        image_11.image = #imageLiteral(resourceName: "a11") ;
        image_12.image = #imageLiteral(resourceName: "a12") ;
        image_13.image = #imageLiteral(resourceName: "a13") ;
        suit = 0
    }
    @IBAction func heartsButton(_ sender: UIButton) {
//        print (a1.frame)
//        print (a2.frame)
        image_1.image = #imageLiteral(resourceName: "b1") ;
        image_2.image = #imageLiteral(resourceName: "b2") ;
        image_3.image = #imageLiteral(resourceName: "b3") ;
        image_4.image = #imageLiteral(resourceName: "b4") ;
        image_5.image = #imageLiteral(resourceName: "b5") ;
        image_6.image = #imageLiteral(resourceName: "b6") ;
        image_7.image = #imageLiteral(resourceName: "b7") ;
        image_8.image = #imageLiteral(resourceName: "b8") ;
        image_9.image = #imageLiteral(resourceName: "b9") ;
        image_10.image = #imageLiteral(resourceName: "b10") ;
        image_11.image = #imageLiteral(resourceName: "b11") ;
        image_12.image = #imageLiteral(resourceName: "b12") ;
        image_13.image = #imageLiteral(resourceName: "b13") ;
        suit = 1
    }
    @IBAction func plumButton(_ sender: UIButton) {
        image_1.image = #imageLiteral(resourceName: "c1") ;
        image_2.image = #imageLiteral(resourceName: "c2") ;
        image_3.image = #imageLiteral(resourceName: "c3") ;
        image_4.image = #imageLiteral(resourceName: "c4") ;
        image_5.image = #imageLiteral(resourceName: "c5") ;
        image_6.image = #imageLiteral(resourceName: "c6") ;
        image_7.image = #imageLiteral(resourceName: "c7") ;
        image_8.image = #imageLiteral(resourceName: "c8") ;
        image_9.image = #imageLiteral(resourceName: "c9") ;
        image_10.image = #imageLiteral(resourceName: "c10") ;
        image_11.image = #imageLiteral(resourceName: "c11") ;
        image_12.image = #imageLiteral(resourceName: "c12") ;
        image_13.image = #imageLiteral(resourceName: "c13") ;
        suit = 2
    }
    @IBAction func squareButton(_ sender: UIButton) {
        image_1.image = #imageLiteral(resourceName: "d1") ;
        image_2.image = #imageLiteral(resourceName: "d2") ;
        image_3.image = #imageLiteral(resourceName: "d3") ;
        image_4.image = #imageLiteral(resourceName: "d4") ;
        image_5.image = #imageLiteral(resourceName: "d5") ;
        image_6.image = #imageLiteral(resourceName: "d6") ;
        image_7.image = #imageLiteral(resourceName: "d7") ;
        image_8.image = #imageLiteral(resourceName: "d8") ;
        image_9.image = #imageLiteral(resourceName: "d9") ;
        image_10.image = #imageLiteral(resourceName: "d10") ;
        image_11.image = #imageLiteral(resourceName: "d11") ;
        image_12.image = #imageLiteral(resourceName: "d12") ;
        image_13.image = #imageLiteral(resourceName: "d13") ;
        suit = 3
    }
    
    func addPanGesture(view:UIView)
    {
        let pan = UIPanGestureRecognizer(target:self,action:#selector(ViewController.handlePan(_:)))
        view.addGestureRecognizer(pan)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        //print(location)
        for item in images
        {
            //var p = item.convert(item.frame, to: self.view)
            let point = item.convert(location,from:touch.view)
            if (point == location)
            {
//                print("OK")
                drag_item = item
                addPanGesture(view: item)
                break
            }
        }
    }
    
    // use to find which card is dragged
    func find(value searchValue: UIImageView, in array: [UIImageView]) -> Int?
    {
        for (index, value) in array.enumerated()
        {
            if value == searchValue {
                return index
            }
        }
        return nil
    }
    
//pangesture for pokers
    var fileViewOrigin: CGPoint!
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        // this statement was: guard sender.view! != nil else{return}
        // if sender.view = nil, then force unwrapping here should break the code here
        // remove force unwrapping for sender.view
        guard sender.view != nil else{return}

        //start the drag version
        let piece = sender.view!
        let translation = sender.translation(in:view)
        if sender.state == .began || sender.state == .changed
        {
            piece.center = CGPoint(x:piece.center.x + translation.x,y:piece.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in:view)
        }

        if sender.state == .ended
        {
            var not_used : Bool  = true
        
            // flop, turn, river
            for it in images_5
            {
                if (it.convert(piece.frame, from: piece)).contains(piece.center)
                {
                    it.image = drag_item.image
                    UIView.animate(withDuration: 0.3, animations: { piece.alpha = 0.0 })
                    point = find(value: drag_item, in: images)! + 1
                    
//                    print(find(value: drag_item, in: images)!)
                    
                    not_used = false
                    
                    // add values
//                    print("Add to table \(suit),\(point)")
//                    table_suit.append(suit)
//                    table_point.append(point)
                    
                    let table_index = find(value: it, in: images_5)!
//                    print("table index: \(table_index)")
                    storeValue(my_suit: suit, my_point: point, table_or_hand: 0, index: table_index)
                    // add return value of the card
                }
            }
            
            if (not_used){
                // hand 1, hand 2
                for it in images_2
                {
                    if (piece.convert(it.frame, from: it)).contains(it.center)
                    {
                        it.image = drag_item.image
                        UIView.animate(withDuration: 0.3, animations: { piece.alpha = 0.0} )
                        point = find(value: drag_item, in: images)! + 1
//                        print(find(value: drag_item, in: images)!)
//                        add value
                        not_used = false
//                        print("Add to hand \(suit),\(point)")
//                        hand_suit.append(suit)
//                        hand_point.append(point)
                        
                        
                        let hand_index = find(value: it, in: images_2)!
//                        print("hand index: \(hand_index)")
                        storeValue(my_suit: suit, my_point: point, table_or_hand: 1, index: hand_index)
                    }
                }
            }
            
            if (!not_used){
                if(cal.check_can_be_calculated()){
                    let result = cal.calculate()
                    print("This is my result: \(result)")
                }
                else{
                    print("Can not calculate")
                }
                   
            }
            
            piece.center = original[drag_item]!
            piece.alpha = 1.0
        }
    }
    
    func storeValue(my_suit:Int, my_point:Int, table_or_hand: Int, index:Int){
        switch table_or_hand {
        case 0:
            switch index{
                case 0:
                    cal.set_flop0(use: Card(suit:my_suit, point: my_point))
                case 1:
                    cal.set_flop1(use: Card(suit:my_suit, point: my_point))
                case 2:
                    cal.set_flop2(use: Card(suit:my_suit, point: my_point))
                case 3:
                    cal.set_turn(use: Card(suit:my_suit, point: my_point))
                case 5:
                    cal.set_river(use: Card(suit:my_suit, point: my_point))
            default:
                print("invalid table")
            }
        case 1:
            switch index{
                case 0:
                    cal.set_playerhand0(use: Card(suit:my_suit, point: my_point))
                case 1:
                    cal.set_playerhand1(use: Card(suit:my_suit, point: my_point))
            default:
                print("invalid hand")
            }
        default:
            print("invalid input")
        }
    }
    
    
//    @IBAction func help(_ sender: Any) {
//        performSegue(withIdentifier: "help", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! simple_inputViewController
//        vc.numberPlayer = player
//    }
}

