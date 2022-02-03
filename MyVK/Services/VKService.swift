//
//  VKService.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.02.2022.
//

import Foundation
import Alamofire

class VKService {
    let userId: String
    let accessToken: String
    let baseURL = "https://api.vk.com/method/"
    
    
    init(_ userId: String, _ accessToken: String) {
        self.userId = userId
        self.accessToken = accessToken
    }
    
    
    // метод для загрузки данных, в качестве аргументов получает город
    func loadUserData(){
        //AF.request(url, method: .get, parameters: parameters, encoder: JSONParameterEncoder.default).response { repsonse in
        //    debugPrint(repsonse)
        //}
        
        struct VKRequest: Encodable {
            let access_token: String
            let oauth: Bool
            let user_id: String
            let extended: Bool
            let v: String
        }
        
        struct Temp: Encodable {
            
        }
        
        let groupsParameters = ["access_token": accessToken,
                                "user_id": userId,
                                "extended": "1",
                                "oauth": "1",
                                "v": "5.131"
        ]
        
        let friendsParameters = ["access_token": accessToken,
                                 "user_id": userId,
                                 "v": "5.131"
        ]
        
        let photosParameters = ["access_token": accessToken,
                                "owner_id": userId,
                                "v": "5.131",
                                "album_id": "profile"
        ]
        
        let allGroupsParameters = ["access_token": accessToken,
                                   "count": "50",
                                   "v": "5.131",
                                   "q": "Группа"
        ]
        
        let groupsRequest = AF.request(baseURL + "groups.get", method: .get, parameters: groupsParameters, encoding: URLEncoding.default).responseJSON { (response) in
            print(response)
        }
        
        let allGroupsRequest = AF.request(baseURL + "groups.search", method: .get, parameters: allGroupsParameters, encoding: URLEncoding.default).responseJSON { (response) in
            print(response)
        }
        
        let photosRequest = AF.request(baseURL + "photos.get", method: .get, parameters: photosParameters, encoding: URLEncoding.default).responseJSON { (response) in
            print(response)
        }
        
        let friendsRequest = AF.request(baseURL + "friends.get", method: .get, parameters: friendsParameters, encoding: URLEncoding.default).responseJSON { (response) in
            print(response)
        }
        
        
        
        
        
        
        //request.response { response in debugPrint(response) }
        
        let request2 = URLRequest(url: URL(string: baseURL + "groupds.get/access_token=" + accessToken)!)
        //print(request2.response)
    }
    
}
