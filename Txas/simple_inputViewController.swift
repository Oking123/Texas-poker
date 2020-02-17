//
//  simple_inputViewController.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-02-13.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit

class simple_inputViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var card1: UITextField!
    @IBOutlet weak var card2: UITextField!
    @IBOutlet weak var flop: UITextField!
    @IBOutlet weak var turn: UITextField!
    @IBOutlet weak var river: UITextField!
    
    
    @IBOutlet weak var viewResult: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card1.delegate = self
        card2.delegate = self
        flop.delegate = self
        turn.delegate = self
        river.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// show caculated result in text field
    /// - Parameter sender: Caculator
    @IBAction func Caculator(_ sender: Any) {
        
        let cal = Calculate()
        var temp:[String]
        
        if card1.text != ""{
        temp = card1.text!.components(separatedBy: ",")
        let my_card1_suit: Int = Int(temp[0])!
        let my_card1_point: Int = Int(temp[1])!
        cal.set_playerhand0(use: Card(suit:my_card1_suit, point: my_card1_point))
        }
        if card2.text != ""{
        temp = card2.text!.components(separatedBy: ",")
        let my_card2_suit: Int = Int(temp[0])!
        let my_card2_point: Int = Int(temp[1])!
        cal.set_playerhand1(use: Card(suit:my_card2_suit, point: my_card2_point))
        }
        if flop.text != ""{
        temp = flop.text!.components(separatedBy: ",")
        let my_flop0: Int = Int(temp[0])!
        let my_flop1: Int = Int(temp[1])!
        let my_flop2: Int = Int(temp[2])!
        cal.set_flop0(use: Card(index:my_flop0))
        cal.set_flop1(use: Card(index:my_flop1))
        cal.set_flop2(use: Card(index:my_flop2))
        }
       
        
        if turn.text != ""{
            cal.set_turn(use: Card(index:Int(turn.text!)!))
        }
        
        if river.text != ""{
            cal.set_river(use: Card(index:Int(river.text!)!))
        }
        
              
        let result = cal.calculate()*100
        
        viewResult.text = "my winning change is: \(result)%.\n"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        card1.resignFirstResponder()
        card2.resignFirstResponder()
        flop.resignFirstResponder()
        turn.resignFirstResponder()
        river.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
