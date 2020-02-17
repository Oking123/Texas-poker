//
//  simple_inputViewController.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-02-13.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit

class simple_inputViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var number: UILabel!
    var numberPlayer = ""

    @IBOutlet weak var card1: UITextField!
    @IBOutlet weak var card2: UITextField!
    @IBOutlet weak var flop: UITextField!
    @IBOutlet weak var turn: UITextField!
    @IBOutlet weak var river: UITextField!


    @IBOutlet weak var viewResult: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        number.text = "Number of Player: " + numberPlayer

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

        var temp = card1.text!.components(separatedBy: ",")
        let my_card1_suit: Int = Int(temp[0])!
        let my_card1_point: Int = Int(temp[1])!

        temp = card2.text!.components(separatedBy: ",")
        let my_card2_suit: Int = Int(temp[0])!
        let my_card2_point: Int = Int(temp[1])!

        temp = flop.text!.components(separatedBy: ",")
        let my_flop0: Int = Int(temp[0])!
        let my_flop1: Int = Int(temp[1])!
        let my_flop2: Int = Int(temp[2])!



//        temp = turn.text!.components(separatedBy: ",")

//        temp = river.text!.components(separatedBy: ",")

//        viewResult.text = "card1 suit: \(my_card1_suit!)\ncard1 point: \(my_card1_point!)\n"

        let my_card1 = Card(suit: my_card1_suit, point: my_card1_point)
        let my_card2 = Card(suit: my_card2_suit, point: my_card2_point)
        let cal = Calculate([my_card1,my_card2])
        cal.set_flop(use: [Card(index: my_flop0), Card(index: my_flop1), Card(index: my_flop2)])

        let player = Int(numberPlayer)!

        let result = cal.calculate(player_number: player)*100


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
