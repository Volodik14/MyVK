//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class AllGroupsModuleModule {
    private let presenter = AllGroupsModulePresenter()
    private let view: AllGroupsModuleViewInput

    init(output: AllGroupsModuleModuleOutput, userGroups: [Group]) {
        let interactor = AllGroupsModuleInteractor()
        interactor.output = presenter

        view = AllGroupsModuleViewController.create()
        view.output = presenter

        presenter.output = output
        presenter.view = view
        presenter.router = AllGroupsModuleRouter()
        presenter.interactor = interactor
        presenter.userGroups = userGroups
    }
}

// MARK: AllGroupsModuleModuleInput
extension AllGroupsModuleModule: AllGroupsModuleModuleInput {
    func present(from vc: UIViewController) {
        presenter.present(from: vc)
    }
}
