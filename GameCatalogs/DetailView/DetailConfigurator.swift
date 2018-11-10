//
//  DetailConfigurator.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 25/10/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import Foundation

protocol DetailConfiguratorProtocol: class {
    func configure(with viewController: DetailViewController)
}

class DetailConfigurator: DetailConfiguratorProtocol {
    func configure(with viewController: DetailViewController) {
        let presenter = DetailPresenter(view: viewController as DetailViewProtocol)
        let interactor = DetailInteractor(presenter: presenter)
        let router = DetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
