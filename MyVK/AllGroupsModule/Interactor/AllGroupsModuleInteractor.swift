//
//  AllGroupsModuleInteractor.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation

class AllGroupsModuleInteractor {
    weak var output: AllGroupsModuleInteractorOutput?
    var userId: String = ""
    var accessToken: String = ""
    
    init() {
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
                self.userId = userId
                self.accessToken = accessToken
            } else {
                print("Cannot get data, cannot get access token!")
            }
        } else {
            print("Cannot get data, cannot get user id!")
        }
    }
    
}

// MARK: - AllGroupsModuleInteractorInput
extension AllGroupsModuleInteractor: AllGroupsModuleInteractorInput {
    func getAllGroups(search: String, userGroups: [Group]) {
        let vkService = VKService(userId, accessToken)
        vkService.loadGroupsDataBySearch(search: search, completion: { searchGroups in
            let groupsWithoutUserGroups = searchGroups.filter( { (searchGroup) -> Bool in
                for userGroup in userGroups  {
                    if searchGroup == userGroup  {
                        return false
                    }
                }
                return true
            })
            self.output?.getAllGroupsSuccess(model: groupsWithoutUserGroups)
        })
    }
}
