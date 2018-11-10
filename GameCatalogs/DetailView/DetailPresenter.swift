//
//  DetailPresenterProtocol.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 25/10/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import Foundation

protocol DetailPresenterProtocol: class {
    var router: DetailRouterProtocol! { set get }
    func configureView()
    func closeButtonClicked()
}

class DetailPresenter: DetailPresenterProtocol {
    
    func configureView() {}
    var router: DetailRouterProtocol!
    weak var view: DetailViewProtocol!
    var interactor: DetailInteractorProtocol!
    required init(view: DetailViewProtocol) {
        self.view = view
    }

    func closeButtonClicked() {
        router.closeCurrentViewController()
    }
    
}

