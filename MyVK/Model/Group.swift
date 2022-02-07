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
    @objc dynamic var name = ""
    @objc dynamic var id = ""
    @objc dynamic var countMembers = ""
    @objc dynamic var photo: Photo? = nil
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].stringValue
        self.countMembers = json["members_count"].stringValue
        self.name = json["name"].stringValue
        self.photo = Photo(url: json["photo_200"].stringValue)
    }
}
