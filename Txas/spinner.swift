//
//  spinner.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-04-03.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    /// add a spinner to a view controller: the spinner has a max life cycle of 20 seconds
    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        let mySpinner = UIActivityIndicatorView(style: .large)
        mySpinner.color = .systemYellow
        mySpinner.center = aView!.center
        mySpinner.startAnimating()
        aView?.addSubview(mySpinner)
        self.view.addSubview(aView!)
        print("start")
        
        Timer.scheduledTimer(withTimeInterval: 20.0, repeats: false){ (t) in
            print("cancel")
            self.removeSpinner()
        }
    }
    
    /// remove an existing spinner
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
        print("done")
    }
}

