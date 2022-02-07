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
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var photos = [Photo]()
    
    init(json: JSON, photos: [Photo]) {
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photos = photos
    }
    
    init(json: JSON) {
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photos = [Photo(url: json["photo_200_orig"].stringValue)]
    }
}
