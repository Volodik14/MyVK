//
//  AllGroupsModuleViewOutput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol AllGroupsModuleViewOutput: AnyObject {
    func viewIsReady()
    var itemsCount: Int { get }
    func getItem(row: Int) -> Group
    func addGroup(sender: UIViewController, row: Int)
}
