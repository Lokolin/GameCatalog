//
//  DetailInteractor.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 25/10/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import Foundation

protocol DetailInteractorProtocol: class {}

class DetailInteractor: DetailInteractorProtocol {
    
    weak var presenter: DetailPresenterProtocol!
    
    required init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
    }

}
