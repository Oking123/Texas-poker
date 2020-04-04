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

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){ (t) in
            self.removeSpinner()
        }
    }
    
    /// remove an existing spinner
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
}

extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}
