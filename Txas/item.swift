//
//  item.swift
//  Txas
//
//  Created by Shiyun Qin on 2020-02-17.
//  Copyright © 2020 陈彦廷. All rights reserved.
//

/*
import Foundation
import UIKit
import SwiftUI

class Item: CustomStringConvertible,Equatable, Codable, Identifiable{
    var name: String
    var suit: Int
    var point: Int
    var index: Int
    fileprivate var imageName: String
    /// false it is previously selected
    var not_selected: Bool
    
    var featureImage: Image? {
        guard not_selected else { return nil }
        
        return Image(
            ImageStore.loadImage(name: "\(imageName)_feature"),
            scale: 2,
            label: Text(verbatim: name))
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.index == rhs.index
    }
    
    init(suit:Int, point:Int) {
        self.suit = suit
        if point == 1{
            self.point = 14
        }else{
            self.point = point
        }
        self.index = suit * 13 + point
    }
    init(index:Int){
        self.index = index
        self.suit = index/13
        self.point = index%13 + 1
        if self.point == 1{
            self.point = 14
        }
    }
    
    public var description:String{
        let suits:[Int:String] = [0: "♠", 1: "♥", 2: "♣", 3: "♦"]
        let points:[Int:String] = [14: "A", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9", 10: "10", 11: "J", 12: "Q",13: "K"]
        return suits[self.suit]!+points[self.point]!
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}
*/
