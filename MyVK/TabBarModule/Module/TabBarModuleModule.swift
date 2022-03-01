//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class TabBarModuleModule {
    private let presenter = TabBarModulePresenter()
    private let view: TabBarModuleViewInput

    init() {
        view = TabBarModuleViewController.create()
    }
}

// MARK: TabBarModuleModuleInput
extension TabBarModuleModule: TabBarModuleModuleInput {
    func present(from vc: UIViewController) {
        if let viewController = UIStoryboard(name: "TabBarModule", bundle: nil).instantiateViewController(withIdentifier: "TabBarModuleViewController") as? TabBarModuleViewController {
            viewController.modalPresentationStyle = .fullScreen
            vc.present(viewController, animated: true)
        }
    }
}
