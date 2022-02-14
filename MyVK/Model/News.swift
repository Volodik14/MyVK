//
//  News.swift
//  MyVK
//
//  Created by Владимир Моторкин on 10.02.2022.
//

import Foundation
import SwiftyJSON

class News {
    var id = ""
    var authorName = ""
    var authorImageURL = ""
    var commentsCount = ""
    var likesCount = ""
    var viewsCount = ""
    var repostsCount = ""
    var postText = ""
    var postImageURL = ""
    
    init(json: JSON, name: String, photoURL: String) {
        self.id = json["post_id"].stringValue
        self.viewsCount = jsonToStringParameter(json: json["views"]["count"])
        self.likesCount = jsonToStringParameter(json: json["likes"]["count"])
        self.commentsCount = jsonToStringParameter(json: json["comments"]["count"])
        self.repostsCount = jsonToStringParameter(json: json["reposts"]["count"])
        self.postText = json["text"].stringValue
        self.postImageURL = json["attachments"][0]["photo"]["sizes"].arrayValue.last?["url"].stringValue ?? ""
        self.authorName = name
        self.authorImageURL = photoURL
    }
    
    private func jsonToStringParameter(json: JSON) -> String {
        return json.intValue > 0 ? json.stringValue : ""
    }
}
