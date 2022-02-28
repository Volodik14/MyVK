//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class GroupsModuleModule {
    private let presenter = GroupsModulePresenter()

    func configuredFiewController() -> UIViewController {
        let interactor = GroupsModuleInteractor()
        interactor.output = presenter

        let view = GroupsModuleViewController.create()
        view.output = presenter

        //presenter.output = output
        presenter.view = view
        presenter.router = GroupsModuleRouter()
        presenter.interactor = interactor
        return view
    }
}

// MARK: GroupsModuleModuleInput
extension GroupsModuleModule: GroupsModuleModuleInput {
    func presentAsNavController(from vc: UIViewController) {
        presenter.presentAsNavController(from: vc)
    }
    
    func present(from vc: UIViewController) {
        presenter.present(from: vc)
    }
}
