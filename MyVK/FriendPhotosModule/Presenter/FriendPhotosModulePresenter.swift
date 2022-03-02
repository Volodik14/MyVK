//
//  FriendPhotosModulePresenter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendPhotosModulePresenter {
    weak var view: FriendPhotosModuleViewInput!
    weak var output: FriendPhotosModuleModuleOutput?
    var interactor: FriendPhotosModuleInteractorInput!
    var router: FriendPhotosModuleRouterInput!

    private var closeView: (() -> ())?
    private var closeImage: UIImage?
}

// MARK: - Present
extension FriendPhotosModulePresenter {
    func present(from vc: UIViewController) {
        closeImage = UIImage(named: "back_arrow_black")
        closeView = { [weak self] in
            self?.view.viewController.navigationController?.popViewController(animated: true)
        }
        view.present(from: vc)
    }

    func presentAsNavController(from vc: UIViewController) {
        closeImage = UIImage(named: "close_black")
        closeView = { [weak self] in
            self?.view.viewController.navigationController?.dismiss(animated: true)
        }
        view.presentAsNavController(from: vc)
    }
}

// MARK: - FriendPhotosModuleViewOutput
extension FriendPhotosModulePresenter: FriendPhotosModuleViewOutput {
    func viewIsReady() {
        view.setupNavigationBar(title: "FriendPhotosModule", leftButtonImage: closeImage)
    }
    
    func tapNavigationLeftBarButton() {
        closeView?()
    }
}

// MARK: - FriendPhotosModuleInteractorOutput
extension FriendPhotosModulePresenter: FriendPhotosModuleInteractorOutput {

}
