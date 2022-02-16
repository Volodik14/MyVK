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
    private let userId: String
    
    private let baseHeaders: [String: String]
    
    // Основная строка запроса.
    private let baseURL = "https://api.vk.com/method/"
    
    public static var isPaginating = false
    
    private var lastId = ""
    
    init(_ userId: String, _ accessToken: String) {
        self.userId = userId
        baseHeaders = ["access_token": accessToken, "v": "5.131"]
    }
    
    // Загрузка друзей пользовтеля.
    func loadFriendsData(completion: @escaping ([User]) -> Void) {
        // Параметры запроса.
        let friendsParameters = ["user_id": userId,
                                 "fields": "nickname, photo_200_orig",
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
        
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
        let photosParameters = ["owner_id": userId,
                                "album_id": "profile"
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
        
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
        let photosParameters = ["owner_id": userId,
                                "album_id": "profile"
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
        
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
        let groupsParameters = ["group_id": groupId,
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
        // Запрос к VK API.
        let _ = AF.request(baseURL + "groups.join", method: .post, parameters: groupsParameters, encoding: URLEncoding.default)
    }
    
    // Выход из группы. Не работает из-за прав доступа.
    func leaveGroup(groupId: String) {
        // Параметры запроса.
        let groupsParameters = ["group_id": groupId,
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
        // Запрос к VK API.
        let _ = AF.request(baseURL + "groups.leave", method: .post, parameters: groupsParameters, encoding: URLEncoding.default)
    }
    
    // Загрузка групп пользовтеля.
    func loadGroupsData(completion: @escaping ([Group]) -> Void) {
        // Параметры запроса.
        let groupsParameters = ["user_id": userId,
                                "extended": "1",
                                "oauth": "1",
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
        
        
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
        let allGroupsParameters = ["count": "50",
                                   "fields": "members_count",
                                   "q": search
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
        
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
        let addedParameters: [String: String]
        if lastId != "" {
            addedParameters = ["start_from": lastId]
            VKService.isPaginating = true
        } else {
            addedParameters = [:]
        }
        let newsfeedParameters = ["count": "26",
                                  "filters": "post"
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first }).merging(addedParameters, uniquingKeysWith: { (first, _) in first })
        var allNews = [News]()
        // Добавление задачи в глобальную очередь.
        DispatchQueue.global().async { [self] in
            AF.request(baseURL + "newsfeed.get", method: .get, parameters: newsfeedParameters, encoding: URLEncoding.default).responseData { (response) in
                do {
                    let data = try response.result.get()
                    let json = try JSON(data: data)["response"]["items"]
                    let queue = DispatchQueue(label: "GetNews")
                    let group = DispatchGroup()
                        for index in 0..<json.count-1 {
                            queue.async(group: group) {
                                getNamePhotoById(id: json[index]["source_id"].intValue, completion: {namePhoto in
                                    allNews.append(News(json: json[index], name: namePhoto.name, photoURL: namePhoto.photo))
                                    print(json[index])
                                    if allNews.count == 25 {
                                        VKService.isPaginating = false
                                        completion(allNews)
                                        lastId = json[25]["post_id"].stringValue
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
            let parameters = ["user_ids": String(id),
                              "fields": "photo_200_orig",
            ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
                AF.request(self.baseURL + "groups.getById", method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { (response) in
                    do {
                        let data = try response.result.get()
                        let json = try JSON(data: data)["response"][0]
                        print(json)
                        let name = json["first_name"].stringValue + json["last_name"].stringValue
                        let photo = json["photo_200"].stringValue
                        completion((name, photo))
                    } catch {
                        print("Error: download exception!")
                    }
                    
                }
        } else {
            let parameters = ["group_id": String(id * (-1)),
            ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
                AF.request(baseURL + "groups.getById", method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { (response) in
                    do {
                        let data = try response.result.get()
                        let json = try JSON(data: data)["response"][0]
                        print(json)
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
        let parameters = ["group_id": String(id),
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
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
        let parameters = ["user_ids": String(id),
                          "fields": "photo_200_orig",
        ].merging(baseHeaders, uniquingKeysWith: { (first, _) in first })
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
