//
//  VKService.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.02.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class VKService {
    let userId: String
    let accessToken: String
    let baseURL = "https://api.vk.com/method/"
    
    
    init(_ userId: String, _ accessToken: String) {
        self.userId = userId
        self.accessToken = accessToken
    }
    
    func loadFriendsData(completion: @escaping ([User]) -> Void) {
        let friendsParameters = ["access_token": accessToken,
                                 "user_id": userId,
                                 "fields": "nickname, photo_200_orig",
                                 "v": "5.131"
        ]
        
        var friends = [User]()
        
        AF.request(baseURL + "friends.get", method: .get, parameters: friendsParameters, encoding: URLEncoding.default).responseData { (response) in
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    friends.append(User(json: json[index]))
                }
                print(friends.count)
            } catch {
                print("Error: download exception!")
            }
            MyData.shared.users = friends
            completion(friends)
            //print(response)
        }
    }
    
    func loadPhotosData(completion: @escaping ([Photo]) -> Void) {
        let photosParameters = ["access_token": accessToken,
                                "owner_id": userId,
                                "v": "5.131",
                                "album_id": "profile"
        ]
        
        var photos = [Photo]()
        
        AF.request(baseURL + "photos.get", method: .get, parameters: photosParameters, encoding: URLEncoding.default).responseData { (response) in
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    photos.append(Photo(json: json[index]))
                }
                print(photos.count)
            } catch {
                print("Error: download exception!")
            }
            
            //print(response)
        }
        MyData.shared.photo = photos
        print("\(MyData.shared.photo.count) + photos")
        completion(photos)
    }
    
    func loadGroupsData(completion: @escaping ([Group]) -> Void) {
        let groupsParameters = ["access_token": accessToken,
                                "user_id": userId,
                                "extended": "1",
                                "oauth": "1",
                                "v": "5.131"
        ]
        
        
        var groups = [Group]()
        
        AF.request(baseURL + "groups.get", method: .get, parameters: groupsParameters, encoding: URLEncoding.default).responseData { (response) in
            
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    groups.append(Group(json: json[index]))
                }
                
                print(groups.count)
            } catch {
                print("Error: download exception!")
            }
            
            
            //print(response)
        }
        MyData.shared.groups = groups
        completion(groups)
    }
    
    func loadGroupsDataBySearch(search: String = "Группа", completion: @escaping ([Group]) -> Void) {
        let allGroupsParameters = ["access_token": accessToken,
                                   "count": "50",
                                   "v": "5.131",
                                   "q": search
        ]
        
        var allGroups = [Group]()
        
        AF.request(baseURL + "groups.search", method: .get, parameters: allGroupsParameters, encoding: URLEncoding.default).responseData { (response) in
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    allGroups.append(Group(json: json[index]))
                }
                
                print(allGroups.count)
            } catch {
                print("Error: download exception!")
            }
            
            //print(response)
        }
        MyData.shared.searchGroups = allGroups
        completion(allGroups)
    }
    
}
