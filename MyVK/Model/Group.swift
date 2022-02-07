//
//  Group.swift
//  MyVK
//
//  Created by Владимир Моторкин on 03.02.2022.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object {
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.name == rhs.name
    }
    
    dynamic var name = ""
    dynamic var photo: Photo
    
    init(json: JSON) {
        self.name = json["height"].stringValue
        self.photo = Photo(url: json["photo_200"].stringValue)
    }
}
