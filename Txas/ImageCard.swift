//
//  ImageCard.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-03-30.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import Foundation
import UIKit


/// image card instance class
class ImageCards {
    var image1: UIImage
    var image2: UIImage
    var win_rate: String
    var tips: String
    var image1_index: Int = -1
    var image2_idnex: Int = -1
//    var player: Int
    
    /// Description initialize ImageCards
    /// - Parameters:
    ///   - image1: UIImage
    ///   - image2: UIImage
    ///   - win_rate: String
    ///   - tips: String
    init(image1: UIImage, image2: UIImage, win_rate: String, tips: String){
        self.image1 = image1
        self.image2 = image2
        self.win_rate = win_rate
        self.tips = tips    }
    
    func update_image(){
        
    }
}
