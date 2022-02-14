//
//  User.swift
//  MyVK
//
//  Created by Владимир Моторкин on 03.02.2022.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var photo: Photo? = nil
    
    convenience init(json: JSON, photo: Photo) {
        self.init()
        self.id = json["id"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo = photo
    }
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo = Photo(url: json["photo_200_orig"].stringValue)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
