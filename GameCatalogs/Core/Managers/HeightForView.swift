//
//  heightForView.swift
//  GameCatalogs
//
//  Created by Дмитрий Евсюков on 08/11/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import UIKit
import Foundation

extension  String{
    
    func heightForView(font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
