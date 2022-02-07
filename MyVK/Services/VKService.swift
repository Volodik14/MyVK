//
//  VKService.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.02.2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class VKService {
    let userId: String
    let accessToken: String
    let baseURL = "https://api.vk.com/method/"
    //var friends = [User]()
    //var photos = [Photo]()
    //var groups = [Group]()
    //var searchGroups = [Group]()
    
    
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
            self.saveUserData(friends)
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
            completion(photos)
        }
        //self.savePhotoData(photos)
        
    }
    
    func loadUserProfilePhotos(userId: String, completion: @escaping ([Photo]) -> Void) {
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
                print(json)
                for index in 0..<json.count {
                    photos.append(Photo(json: json[index]["sizes"][0]))
                }
                print(photos.count)
                print(photos)
            } catch {
                print("Error: download exception!")
            }
            
            //print(response)
            completion(photos)
        }
        //self.savePhotoData(photos)
        
    }
    
    func joinGroup(groupId: String) {
        let groupsParameters = ["access_token": accessToken,
                                "group_id": groupId,
                                "v": "5.131"
                                ]
        AF.request(baseURL + "groups.join", method: .get, parameters: groupsParameters, encoding: URLEncoding.default)
    }
    
    func leaveGroup(groupId: String) {
        let groupsParameters = ["access_token": accessToken,
                                "group_id": groupId,
                                "v": "5.131"
                                ]
        AF.request(baseURL + "groups.leave", method: .get, parameters: groupsParameters, encoding: URLEncoding.default)
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
            self.saveGroupsData(groups)
            completion(groups)
        }
        
    }
    
    func loadGroupsDataBySearch(search: String = "Группа", completion: @escaping ([Group]) -> Void) {
        let allGroupsParameters = ["access_token": accessToken,
                                   "count": "50",
                                   "v": "5.131",
                                   "fields": "members_count",
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
                
                print("\(allGroups.count) groups")
            } catch {
                print("Error: download exception!")
            }
            
            //print(response)
            completion(allGroups)
        }
    }
    
    func saveUserData(_ data: [User]) {
        do {
            let realm = try Realm()
                       
           // все старые погодные данные для текущего города
            let oldUserData = realm.objects(User.self)
                       
           // начинаем изменять хранилище
            realm.beginWrite()
                       
           // удаляем старые данные
            realm.delete(oldUserData)
                       
           // кладем все объекты класса погоды в хранилище
            realm.add(data)
                       
           // завершаем изменять хранилище
            try realm.commitWrite()

        } catch {
            print(error)
        }
    }
    
    func savePhotoData(_ data: [Photo]) {
        do {
            let realm = try Realm()
                       
           // все старые погодные данные для текущего города
            let oldPhotoData = realm.objects(Photo.self)
                       
           // начинаем изменять хранилище
            realm.beginWrite()
                       
           // удаляем старые данные
            realm.delete(oldPhotoData)
                       
           // кладем все объекты класса погоды в хранилище
            realm.add(data)
                       
           // завершаем изменять хранилище
            try realm.commitWrite()

        } catch {
            print(error)
        }
    }
    
    func saveGroupsData(_ data: [Group]) {
        do {
            let realm = try Realm()
                       
           // все старые погодные данные для текущего города
            let oldGroupsData = realm.objects(Group.self)
                       
           // начинаем изменять хранилище
            realm.beginWrite()
                       
           // удаляем старые данные
            realm.delete(oldGroupsData)
                       
           // кладем все объекты класса погоды в хранилище
            realm.add(data)
                       
           // завершаем изменять хранилище
            try realm.commitWrite()

        } catch {
            print(error)
        }
    }
    
}
