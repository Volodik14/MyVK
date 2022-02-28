//
//  TabBarModuleInteractorInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation

protocol TabBarModuleInteractorInput: AnyObject {
    var output: TabBarModuleInteractorOutput? { get set }
}
