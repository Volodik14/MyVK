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

fileprivate enum Config {
    static let baseURL = "https://api.vk.com/method/"
    //static let baseHeaders = ["access_token": accessToken, "v": "5.131"]
}

class VKService {
    let userId: String
    let accessToken: String
    
    // Основная строка запроса.
    let baseURL = "https://api.vk.com/method/"
    
    
    init(_ userId: String, _ accessToken: String) {
        self.userId = userId
        self.accessToken = accessToken
    }
    
    // Загрузка друзей пользовтеля.
    func loadFriendsData(completion: @escaping ([User]) -> Void) {
        // Параметры запроса.
        let friendsParameters = ["access_token": accessToken,
                                 "user_id": userId,
                                 "fields": "nickname, photo_200_orig",
                                 "v": "5.131"
        ]
        
        var friends = [User]()
        // Запрос к VK API.
        AF.request(baseURL + "friends.get", method: .get, parameters: friendsParameters, encoding: URLEncoding.default).responseData { (response) in
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    friends.append(User(json: json[index]))
                }
            } catch {
                print("Error: download exception!")
            }
            self.saveUserData(friends)
            completion(friends)
        }
    }
    
    // Загрузка фото пользовтеля. На данный момент не используется.
    func loadPhotosData(completion: @escaping ([Photo]) -> Void) {
        // Параметры запроса.
        let photosParameters = ["access_token": accessToken,
                                "owner_id": userId,
                                "v": "5.131",
                                "album_id": "profile"
        ]
        
        var photos = [Photo]()
        // Запрос к VK API.
        AF.request(baseURL + "photos.get", method: .get, parameters: photosParameters, encoding: URLEncoding.default).responseData { (response) in
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    photos.append(Photo(json: json[index]))
                }
            } catch {
                print("Error: download exception!")
            }
            
            completion(photos)
        }
    }
    
    // Загрузка фото профиля пользовтеля.
    func loadUserProfilePhotos(userId: String, completion: @escaping ([Photo]) -> Void) {
        // Параметры запроса.
        let photosParameters = ["access_token": accessToken,
                                "owner_id": userId,
                                "v": "5.131",
                                "album_id": "profile"
        ]
        
        var photos = [Photo]()
        // Запрос к VK API.
        AF.request(baseURL + "photos.get", method: .get, parameters: photosParameters, encoding: URLEncoding.default).responseData { (response) in
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    photos.append(Photo(json: json[index]["sizes"][0]))
                }
            } catch {
                print("Error: download exception!")
            }
            completion(photos)
        }
    }
    
    // Присоединение к группе. Не работает из-за прав доступа.
    func joinGroup(groupId: String) {
        // Параметры запроса.
        let groupsParameters = ["access_token": accessToken,
                                "group_id": groupId,
                                "v": "5.131"
        ]
        // Запрос к VK API.
        let _ = AF.request(baseURL + "groups.join", method: .post, parameters: groupsParameters, encoding: URLEncoding.default)
    }
    
    // Выход из группы. Не работает из-за прав доступа.
    func leaveGroup(groupId: String) {
        // Параметры запроса.
        let groupsParameters = ["access_token": accessToken,
                                "group_id": groupId,
                                "v": "5.131"
        ]
        // Запрос к VK API.
        let _ = AF.request(baseURL + "groups.leave", method: .post, parameters: groupsParameters, encoding: URLEncoding.default)
    }
    
    // Загрузка групп пользовтеля.
    func loadGroupsData(completion: @escaping ([Group]) -> Void) {
        // Параметры запроса.
        let groupsParameters = ["access_token": accessToken,
                                "user_id": userId,
                                "extended": "1",
                                "oauth": "1",
                                "v": "5.131"
        ]
        
        
        var groups = [Group]()
        // Запрос к VK API.
        AF.request(baseURL + "groups.get", method: .get, parameters: groupsParameters, encoding: URLEncoding.default).responseData { (response) in
            
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    groups.append(Group(json: json[index]))
                }
            } catch {
                print("Error: download exception!")
            }
            
            self.saveGroupsData(groups)
            completion(groups)
        }
        
    }
    
    func loadGroupsDataBySearch(search: String = "Группа", completion: @escaping ([Group]) -> Void) {
        // Параметры запроса.
        let allGroupsParameters = ["access_token": accessToken,
                                   "count": "50",
                                   "v": "5.131",
                                   "fields": "members_count",
                                   "q": search
        ]
        
        var allGroups = [Group]()
        // Запрос к VK API.
        AF.request(baseURL + "groups.search", method: .get, parameters: allGroupsParameters, encoding: URLEncoding.default).responseData { (response) in
            do {
                let data = try response.result.get()
                let json = try JSON(data: data)["response"]["items"]
                for index in 0..<json.count {
                    allGroups.append(Group(json: json[index]))
                }
                
            } catch {
                print("Error: download exception!")
            }
            completion(allGroups)
            
        }
    }
    
    func loadNewsfeed(completion: @escaping ([News]) -> Void) {
        let newsfeedParameters = ["access_token": accessToken,
                                   "count": "5",
                                   "v": "5.131"
        ]
        var allNews = [News]()
        // Добавление задачи в глобальную очередь.
        DispatchQueue.global().async { [self] in
            AF.request(baseURL + "newsfeed.get", method: .get, parameters: newsfeedParameters, encoding: URLEncoding.default).responseData { (response) in
                do {
                    let data = try response.result.get()
                    let json = try JSON(data: data)["response"]["items"]
                    
                    let queue = DispatchQueue(label: "GetNews")
                    let group = DispatchGroup()
                        for index in 0..<json.count {
                            queue.async(group: group) {
                                getNamePhotoById(id: json[index]["source_id"].intValue, completion: {namePhoto in
                                    print(namePhoto)
                                    allNews.append(News(json: json[index], name: namePhoto.name, photoURL: namePhoto.photo))
                                    if allNews.count == 5 {
                                        completion(allNews)
                                    }
                                    
                                })
                            }
                        }
                    
                    
                } catch {
                    print("Error: download exception!")
                }
                
                
            }
        }
        
    }
    
    func getNamePhotoById(id: Int, completion: @escaping ((name: String, photo: String)) -> Void) {
        
        if id > 0 {
            let parameters = ["access_token": accessToken,
                                       "user_ids": String(id),
                              "fields": "photo_200_orig",
                                       "v": "5.131"
            ]
                AF.request(self.baseURL + "groups.getById", method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { (response) in
                    do {
                        let data = try response.result.get()
                        let json = try JSON(data: data)["response"][0]
                        //print(json)
                        let name = json["first_name"].stringValue + json["last_name"].stringValue
                        let photo = json["photo_200"].stringValue
                        completion((name, photo))
                    } catch {
                        print("Error: download exception!")
                    }
                    
                }
        } else {
            let parameters = ["access_token": accessToken,
                              "group_id": String(id * (-1)),
                                       "v": "5.131"
            ]
                AF.request(baseURL + "groups.getById", method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { (response) in
                    do {
                        let data = try response.result.get()
                        let json = try JSON(data: data)["response"][0]
                        //print(json)
                        let name = json["name"].stringValue
                        let photo = json["photo_200"].stringValue
                        completion((name, photo))
                    } catch {
                        print("Error: download exception!")
                    }
                    
                }
        }
    }
    
    func getNamePhotoGroup(id: String, completion: @escaping ((name: String, photo: String)) -> Void) {
        let parameters = ["access_token": accessToken,
                                   "group_id": String(id),
                                   "v": "5.131"
        ]
        DispatchQueue.global().async { [self] in
            AF.request(baseURL + "groups.getById", method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { (response) in
                do {
                    let data = try response.result.get()
                    let json = try JSON(data: data)["response"][0]
                    completion((json["name"].stringValue, json["photo_200"].stringValue))
                } catch {
                    print("Error: download exception!")
                }
                
            }
        }
    }
    
    func getNamePhotoUser(id: String, completion: @escaping ((name: String, photo: String)) -> Void) {
        let parameters = ["access_token": accessToken,
                                   "user_ids": String(id),
                          "fields": "photo_200_orig",
                                   "v": "5.131"
        ]
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            AF.request(self.baseURL + "groups.getById", method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { (response) in
                do {
                    let data = try response.result.get()
                    let json = try JSON(data: data)["response"][0]
                    completion((json["first_name"].stringValue + json["last_name"].stringValue, json["photo_200_orig"].stringValue))
                    print(json)
                } catch {
                    print("Error: download exception!")
                }
                
            }
        }
    }
    
    // Сохранение друзей в БД.
    func saveUserData(_ data: [User]) {
        do {
            let realm = try Realm()
            // Начинаем изменять хранилище.
            realm.beginWrite()
            // Добавляем только уникальные данные пользователей.
            realm.add(data, update: .modified)
            // Завершаем изменять хранилище
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
    }

    // Сохранение групп в БД.
    func saveGroupsData(_ data: [Group]) {
        do {
            let realm = try Realm()
            // Получаем старые данные групп.
            let oldGroupsData = realm.objects(Group.self)
            realm.beginWrite()
            // Удаляем старые.
            realm.delete(oldGroupsData)
            // Добавляем новые.
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}
