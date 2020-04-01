//
//  ImageCell.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-03-30.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

import UIKit

//protocol ImageCellDelegate {
//    func didTapAddCards(num: Int)
//}

class ImageCell: UITableViewCell {

    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    
    @IBOutlet weak var Win_Rate: UILabel!
    @IBOutlet weak var Tips: UILabel!
    
//    var delegate: ImageCellDelegate?
//    var CardItem: ImageCards!

    
    /// <#Description#> User cell in the table view,
    /// - Parameter picture: ImageCards
    func setImage(picture: ImageCards){
        Image1.image = picture.image1
        Image2.image = picture.image2
        Win_Rate.text = picture.win_rate
        Tips.text = picture.tips
    }

}
