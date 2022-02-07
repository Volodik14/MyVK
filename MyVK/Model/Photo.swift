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
    dynamic var height = 0
    dynamic var width = 0
    dynamic var url = ""
    
    init(json: JSON) {
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.url = json["url"].stringValue
    }
    
    init(url: String) {
        self.url = url
        self.width = 200
        self.height = 200
    }
}
