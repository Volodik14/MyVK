//
//  FriendPhotosModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendPhotosModuleViewController: UIViewController {

    var output: FriendPhotosModuleViewOutput?
    @IBOutlet private var navigationView: UIView!
    @IBOutlet private var navigationViewHeightConstraint: NSLayoutConstraint!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
}

// MARK: - FriendPhotosModuleViewInput
extension FriendPhotosModuleViewController: FriendPhotosModuleViewInput {
    static func create() -> FriendPhotosModuleViewController {
        let view = FriendPhotosModuleViewController()
        return view
    }
    
}

// MARK: - ViewControllerable
extension FriendPhotosModuleViewController: ViewControllerable {
    static func storyBoardName() -> String {
        return "FriendPhotosModule"
    }
}
