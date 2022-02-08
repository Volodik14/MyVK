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
    // Основная строка запроса.
    let baseURL = "https://api.vk.com/method/"
    
    
    init(_ userId: String, _ accessToken: String) {
        self.userId = userId
        self.accessToken = accessToken
    }
    
    // Загрузка друзей пользовтеля.
    func loadFriendsData() {
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
    
    // Присоединение к группе.
    func joinGroup(groupId: String) {
        // Параметры запроса.
        let groupsParameters = ["access_token": accessToken,
                                "group_id": groupId,
                                "v": "5.131"
        ]
        // Запрос к VK API.
        let _ = AF.request(baseURL + "groups.join", method: .get, parameters: groupsParameters, encoding: URLEncoding.default)
    }
    
    // Выход из группы.
    func leaveGroup(groupId: String) {
        // Параметры запроса.
        let groupsParameters = ["access_token": accessToken,
                                "group_id": groupId,
                                "v": "5.131"
        ]
        // Запрос к VK API.
        let _ = AF.request(baseURL + "groups.leave", method: .get, parameters: groupsParameters, encoding: URLEncoding.default)
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
