//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendPhotosModuleModule {
    private let presenter = FriendPhotosModulePresenter()
    private let view: FriendPhotosModuleViewInput

    init(output: FriendPhotosModuleModuleOutput) {
        let interactor = FriendPhotosModuleInteractor()
        interactor.output = presenter

        view = FriendPhotosModuleViewController.create()
        view.output = presenter

        presenter.output = output
        presenter.view = view
        presenter.router = FriendPhotosModuleRouter()
        presenter.interactor = interactor
    }
}

// MARK: FriendPhotosModuleModuleInput
extension FriendPhotosModuleModule: FriendPhotosModuleModuleInput {
    func presentAsNavController(from vc: UIViewController) {
        presenter.presentAsNavController(from: vc)
    }
    
    func present(from vc: UIViewController) {
        presenter.present(from: vc)
    }
}
