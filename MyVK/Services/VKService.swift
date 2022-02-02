//
//  VKService.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.02.2022.
//

import Foundation
import Alamofire

class VKService {
    // базовый url сервиса
        let baseUrl = "http://api.openweathermap.org"
        // ключ для доступа к сервису
        let apiKey = "92cabe9523da26194b02974bfcd50b7e"
        
        // метод для загрузки данных, в качестве аргументов получает город
        func loadWeatherData(city: String){
            
        // путь для получения погоды за 5 дней
            let path = "/data/2.5/forecast"
            
            struct Parameters: Encodable {
                let q: String
                let units: String
                let appid: String
            }
            
            let parameters = Parameters(q: city, units: "metric", appid: apiKey)
        // параметры, город, единицы измерения градусы, ключ для доступа к сервису

        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
            let url = baseUrl+path
            
        // делаем запрос
            AF.request(url, method: .get, parameters: parameters, encoder: JSONParameterEncoder.default).response { repsonse in
                debugPrint(repsonse)
            }
            
            struct Login: Encodable {
                let email: String
                let password: String
            }

            let login = Login(email: "test@test.test", password: "testPassword")

            AF.request("https://httpbin.org/post",
                       method: .post,
                       parameters: login,
                       encoder: JSONParameterEncoder.default).response { response in
                debugPrint(response)
            }
            
        }

}
