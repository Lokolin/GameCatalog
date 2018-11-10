//
//  DataLoad.swift
//  GameCatalogs
//
//  Created by Дмитрий Евсюков on 08/11/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import Foundation
class DataLoad {
    
    class func loadDataFromPlist( gameArray: inout [Game]) ->[Game]{
        let path = Bundle.main.path(forResource: "GameCatalog", ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        let dictArray = plist as? [[String:Any]]
        for item in dictArray!{
            gameArray.append(Game(name: item["Title"] as! String, category: .vr, image: item["Image"] as! [String], note: item["Note"] as! String, url: item["URL"] as! String))
        }
        return gameArray
    }
}


