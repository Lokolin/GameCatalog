//
//  DetailRouter.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 25/10/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import Foundation

protocol DetailRouterProtocol: class {
    func closeCurrentViewController()
}
class DetailRouter: DetailRouterProtocol {
    
    weak var viewController: DetailViewController!
    
    init(viewController: DetailViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }

}
