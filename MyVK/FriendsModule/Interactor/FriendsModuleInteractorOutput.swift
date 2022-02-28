//
//  FriendsModuleInteractorOutput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation
import RealmSwift

protocol FriendsModuleInteractorOutput: AnyObject {
    func getFriendsListSuccess(model: [User])
    func getFriendsListFail(error: String)
    func subscribeToChangesSuccess()
    func subscribeToChangesFail(error: String)
}
