//
//  AllGroupsModulePresenter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class AllGroupsModulePresenter {
    weak var view: AllGroupsModuleViewInput!
    weak var output: AllGroupsModuleModuleOutput?
    var interactor: AllGroupsModuleInteractorInput!
    var router: AllGroupsModuleRouterInput!

    private var closeView: (() -> ())?
    private var closeImage: UIImage?
}

// MARK: - Present
extension AllGroupsModulePresenter {
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

// MARK: - AllGroupsModuleViewOutput
extension AllGroupsModulePresenter: AllGroupsModuleViewOutput {
    func viewIsReady() {
        view.setupNavigationBar(title: "AllGroupsModule", leftButtonImage: closeImage)
    }
    
    func tapNavigationLeftBarButton() {
        closeView?()
    }
}

// MARK: - AllGroupsModuleInteractorOutput
extension AllGroupsModulePresenter: AllGroupsModuleInteractorOutput {

}
