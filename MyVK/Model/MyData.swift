//
//  Data.swift
//  MyVK
//
//  Created by Владимир Моторкин on 04.02.2022.
//

import Foundation

// Временный костыль для хранения данных.
public class MyData {
    var users: [User]
    var photo: [Photo]
    var groups: [Group]
    var searchGroups: [Group]
    
    func loadData(users: [User], photo: [Photo], groups: [Group], searchGroups: [Group]) {
        self.users = users
        self.photo = photo
        self.groups = groups
        self.searchGroups = searchGroups
    }
    
    public static let shared = MyData()
    
    private init() {
        self.users = [User]()
        self.photo = [Photo]()
        self.groups = [Group]()
        self.searchGroups = [Group]()
    }
}


