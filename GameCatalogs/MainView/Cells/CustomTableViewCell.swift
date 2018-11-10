//
//  CustomTableViewCell.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 08/11/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import UIKit

class CustomTableViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(textLabel)
    }
    
    static var className : String {
        return String(describing: self)
    }
    
    lazy var imageView: SmartImageView = {
        let image = SmartImageView.init(frame: CGRect.init(x: UIScreen.main.bounds.width * 0.02,y: UIScreen.main.bounds.height * 0.02, width: UIScreen.main.bounds.width * 0.45,height: UIScreen.main.bounds.height * 0.19))
        image.contentMode = .scaleAspectFit
        image.topAnchor.constraint(equalTo: self.topAnchor)
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.03, width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.03))
        label.font = UIFont.appRegularFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height * 0.15, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.03))
        label.font = UIFont.appRegularFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.04, width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.15))
        label.font = UIFont.appRegularFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
