//
//  FriendPhotosModuleViewOutput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol FriendPhotosModuleViewOutput: AnyObject {
    var itemsCount: Int { get }
    func viewIsReady()
    func getItem(row: Int) -> Photo
}
