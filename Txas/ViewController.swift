//
//  ViewController.swift
//  Txas
//
//  Created by 陈彦廷 on 2020-01-18.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.bringSubviewToFront(a1)
        // Do any additional setup after loading the view.
    }
    
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
    
    @IBOutlet weak var a1: UIImageView!
    @IBOutlet weak var a2: UIImageView!
    @IBOutlet weak var a3: UIImageView!
    @IBOutlet weak var a4: UIImageView!
    @IBOutlet weak var a5: UIImageView!
    @IBOutlet weak var hand1: UIImageView!
    
    @IBOutlet weak var hand2: UIImageView!
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
        
    }
    @IBAction func heartsButton(_ sender: UIButton) {
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
    }
    
    var fileViewOrigin: CGPoint!
    @IBAction func pan_button1(_ sender: UIPanGestureRecognizer) {
        guard sender.view! != nil else{return}
        let piece = sender.view!
        view.bringSubviewToFront(image_1)
        let translation = sender.translation(in:view)
        //view.bringSubviewToFront(a1)
        fileViewOrigin = a1.frame.origin
        if sender.state == .began || sender.state == .changed
        {
            piece.center = CGPoint(x:piece.center.x + translation.x,y:piece.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in:view)
        }
        if sender.state == .ended
        {
            if piece.frame.intersects(image_1.frame)
            {
                UIView.animate(withDuration: 0.3, animations: {
                    self.a1.alpha = 0.0
                })
            }
        }
        
    }

    
}

