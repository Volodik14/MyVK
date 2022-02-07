//
//  Photo.swift
//  MyVK
//
//  Created by Владимир Моторкин on 03.02.2022.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
    @objc dynamic var height = 0
    @objc dynamic var width = 0
    @objc dynamic var url = ""
    
    convenience init(json: JSON) {
        self.init()
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.url = json["url"].stringValue
    }
    
    convenience init(url: String) {
        self.init()
        self.url = url
        self.width = 200
        self.height = 200
    }
    
}
