//
//  MainViewController.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-02-17.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {


    @IBOutlet weak var NumberTextField: UITextField!
    var NumberText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func comfirm(_ sender: Any) {
        self.NumberText = NumberTextField.text!
        performSegue(withIdentifier: "player", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
//        vc.player = self.NumberText
    }

}

