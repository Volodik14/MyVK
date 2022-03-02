//
//  FriendPhotosModuleViewInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol FriendPhotosModuleViewInput: AnyObject, Presentable, Loadable {
    var output: FriendPhotosModuleViewOutput? { get set }

    func setupNavigationBar(title: String, leftButtonImage: UIImage?)
}
