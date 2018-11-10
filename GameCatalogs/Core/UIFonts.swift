//
//  UIFonts.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 09/11/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import UIKit

extension UIFont {
    static func appRegularFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func appMediumFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func appLightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func appThinFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Thin", size: size) ?? UIFont.systemFont(ofSize: size, weight: .thin)
    }
}
