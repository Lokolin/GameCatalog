//
//  CustomCell.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 08/11/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import UIKit
import YoutubeKit

class CustomCell: UICollectionViewCell {
    private var player: YTSwiftyPlayer!
    
    override init(frame: CGRect) {
        imageView = SmartImageView.init(frame: CGRect.init(x: 0,y: 0, width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.2))
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    static var className: String {
        return String(describing: self)
    }
    
    var url: String="default" {
        didSet{
            if (url.range(of: "https") != nil){
                imageView.isHidden = false
                imageView.imageURI=url
            }else{
                imageView.isHidden = true
                player = YTSwiftyPlayer(
                    frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.2),
                    playerVars: [.videoID(url)])
                print(url)
                player.autoplay = false
                player.delegate = self as? YTSwiftyPlayerDelegate
                player.loadPlayer()
                addSubview(player)
            }
        }
    }
    
    var imageView: SmartImageView {
        didSet{
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.clipsToBounds = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
