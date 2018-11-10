//
//  Game.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 25/10/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import Foundation
import UIKit

public class Game {
    let name: String
    let image: [String]
    let category: GameType
    let note: String
    let url: String
    
    init(name: String, category: GameType, image: [String], note: String, url: String) {
        self.name = name
        self.category = category
        self.image = image
        self.note = note
        self.url = url
    }
}

enum GameType: String {
    case shooter = "Shooter"
    case racing = "Racing"
    case vr = "VR"
}
