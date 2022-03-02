//
//  FriendsModuleViewOutput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol FriendsModuleViewOutput: AnyObject {
    var itemsCount: Int { get }
    func viewIsReady(tableView: UITableView)
    func showFriendsPhoto(sender: UIViewController, row: Int)
    func getItem(row: Int) -> User
}
