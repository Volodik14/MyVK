//
//  FriendsModuleInteractor.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation

class FriendsModuleInteractor {
    weak var output: FriendsModuleInteractorOutput?
}

// MARK: - FriendsModuleInteractorInput
extension FriendsModuleInteractor: FriendsModuleInteractorInput {
    func getFriendsList() {
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
                let vkService = VKService(userId, accessToken)
                vkService.loadFriendsData( completion: {friends in
                    
                })
            } else {
                output?.getFriendsListFail(error: "Cannot get friends")
            }
        }
        
    }
    
    
}
