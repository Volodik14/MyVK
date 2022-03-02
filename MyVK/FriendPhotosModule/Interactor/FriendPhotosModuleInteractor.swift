//
//  FriendPhotosModuleInteractor.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation

class FriendPhotosModuleInteractor {
    weak var output: FriendPhotosModuleInteractorOutput?
    var userId: String = ""
    var accessToken: String = ""
    
    init(userId: String) {
        self.userId = userId
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            self.accessToken = accessToken
        } else {
            print("Cannot get data, cannot get access token!")
        }
    }
}

// MARK: - FriendPhotosModuleInteractorInput
extension FriendPhotosModuleInteractor: FriendPhotosModuleInteractorInput {
    func getPhotos() {
        let vkService = VKService(userId, accessToken)
        vkService.loadUserProfilePhotos(userId: userId, completion: {photos in
            self.output?.getPhotosSuccess(model: photos)
        })
    }
    

}
