//
//  FriendsModuleInteractorInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation
import UIKit

protocol FriendsModuleInteractorInput: AnyObject {
    var output: FriendsModuleInteractorOutput? { get set }
    func getFriendsList()
    func subscribeToChanges(tableView: UITableView)
}
