//
//  APIManager.swift
//  MyVK
//
//  Created by Владимир Моторкин on 16.02.2022.
//

import Foundation

// Не стал использовать...
struct APIManager {
    static func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    static func getToken() -> String {
       return UserDefaults.standard.object(forKey: "userSecret") as? String ?? ""
    }
    
}
