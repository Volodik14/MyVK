//
//  Data.swift
//  MyVK
//
//  Created by Владимир Моторкин on 04.02.2022.
//

import Foundation

// Временный костыль для хранения данных.
public struct MyData {
    public var accessToken = ""
    public var userId = ""
}

var myData = MyData.self(accessToken: "", userId: "")
