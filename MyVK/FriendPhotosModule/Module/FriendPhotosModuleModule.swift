//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendPhotosModuleModule {
    private let presenter = FriendPhotosModulePresenter()
    private let view: FriendPhotosModuleViewInput

    // Задаём id пользователя, чьи фотографии нужно отображать.
    init(userId: String) {
        let interactor = FriendPhotosModuleInteractor(userId: userId)
        interactor.output = presenter

        view = FriendPhotosModuleViewController.create()
        view.output = presenter

         //presenter.output = output
        presenter.view = view
        presenter.router = FriendPhotosModuleRouter()
        presenter.interactor = interactor
    }
}

// MARK: FriendPhotosModuleModuleInput
extension FriendPhotosModuleModule: FriendPhotosModuleModuleInput {
    func present(from vc: UIViewController) {
        presenter.present(from: vc)
    }
}
