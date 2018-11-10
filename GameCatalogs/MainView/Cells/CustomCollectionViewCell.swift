//
//  CustomCollectionViewCell.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 08/11/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
    }
    
    static var className : String {
        return String(describing: self)
    }
    
    lazy var imageView: SmartImageView = {
        var currentWidth: Int
        if (UIScreen.main.bounds.width < 500){
            currentWidth = Int(UIScreen.main.bounds.width * 0.45)
        } else {
            currentWidth = Int(UIScreen.main.bounds.width * 0.29)
        }
        let image = SmartImageView.init(frame: CGRect.init(x: 0,y: 0, width: currentWidth,height: Int(UIScreen.main.bounds.height * 0.17)))
        image.contentMode = .scaleAspectFit
        image.topAnchor.constraint(equalTo: self.topAnchor)
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        var currentWidth: Int
        if (UIScreen.main.bounds.width < 500){
            currentWidth = Int(UIScreen.main.bounds.width * 0.45)
        } else {
            currentWidth = Int(UIScreen.main.bounds.width * 0.29)
        }
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: currentWidth, height: Int(UIScreen.main.bounds.height * 0.02)))
        label.font = UIFont.appRegularFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var categoryLabel : UILabel = {
        var currentWidth: Int
        if (UIScreen.main.bounds.width < 500){
            currentWidth = Int(UIScreen.main.bounds.width * 0.45)
        } else {
            currentWidth = Int(UIScreen.main.bounds.width * 0.29)
        }
        let label = UILabel.init(frame: CGRect.init(x: 0, y: Int(UIScreen.main.bounds.height * 0.15), width: currentWidth, height: Int(UIScreen.main.bounds.height * 0.02)))
        label.font = UIFont.appRegularFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
