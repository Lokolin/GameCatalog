//
//  DetailViewController.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 24/10/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import UIKit
import WebKit
import TTTAttributedLabel

protocol DetailViewProtocol: class {}

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol!
    let configurator: DetailConfiguratorProtocol = DetailConfigurator()
    var game = Game(name: "не задано", category: .vr, image: ["",""], note: "",url: "link")
    var headerView = UIView()
    var mainView: UIView!
    let scrollContentView = UIView()
    var attributedLable: TTTAttributedLabel!

    convenience init(game: Game) {
        self.init(nibName: nil, bundle: nil)
        self.game = game
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewSetup()
        scrollViewSetup()
        imageCollectionSetup()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backScrollView.contentSize = self.scrollContentView.bounds.size
    }
    
    func mainViewSetup() {
        mainView = UIView.init(frame: UIScreen.main.bounds)
        mainView.addSubview(labelTitle)
        mainView.addSubview(labelCategory)
        mainView.addSubview(labelNote)
        mainView.addSubview(tttAtributelabel())
    }
    
    func scrollViewSetup() {
        scrollContentView.frame = self.view.bounds
        scrollContentView.backgroundColor = .white
        self.view.addSubview(backScrollView)
        backScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(mainView)
        scrollContentView.addSubview(imageCollection)
    }
    
    func imageCollectionSetup() {
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.className)
    }

    func tttAtributelabel() -> TTTAttributedLabel {
        attributedLable = TTTAttributedLabel(frame: CGRect.init(x: 0, y: mainView.bounds.height * 0.28, width: UIScreen.main.bounds.width, height: mainView.bounds.height * 0.03))
        attributedLable.numberOfLines = 0;
        let steamURL = "Steam"
        let string = NSLocalizedString("link", comment: "") + "\(steamURL)"
        let nsString = string as NSString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        let fullAttributedString = NSAttributedString(string:string, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: UIColor.black.cgColor,
            ])
        attributedLable.textAlignment = .center
        attributedLable.attributedText = fullAttributedString;
        let rangeTC = nsString.range(of: steamURL)
        let ppLinkAttributes: [String: Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: UIColor.blue.cgColor,
            NSAttributedString.Key.underlineStyle.rawValue: false,
            ]
        let ppActiveLinkAttributes: [String: Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: UIColor.blue.cgColor,
            NSAttributedString.Key.underlineStyle.rawValue: false,
            ]
        attributedLable.activeLinkAttributes = ppActiveLinkAttributes
        attributedLable.linkAttributes = ppLinkAttributes
        let urlTC = URL(string: "Steam")!
        attributedLable.addLink(to: urlTC, with: rangeTC)
        attributedLable.textColor = UIColor.black;
        attributedLable.delegate = self ;
        return attributedLable
    }
    
    lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        return collection
    }()
    
    lazy var labelTitle: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: mainView.bounds.height * 0.23, width: UIScreen.main.bounds.width, height: mainView.bounds.height * 0.03))
        label.font = UIFont.appRegularFont(ofSize: 30)
        label.text = game.name
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var labelCategory: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: mainView.bounds.height * 0.25, width: UIScreen.main.bounds.width, height: mainView.bounds.height * 0.04))
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.appRegularFont(ofSize: 20)
        label.text = NSLocalizedString("category", comment: "") + ": " + game.category.rawValue
        return label
    }()
    
    lazy var labelNote: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: mainView.bounds.height * 0.32, width: UIScreen.main.bounds.width - 10, height: game.note.heightForView(font: UIFont(name: "HelveticaNeue", size: 20)!, width: UIScreen.main.bounds.width - 10)))
        label.textColor = .black
        label.font = UIFont.appRegularFont(ofSize: 20)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text = game.note
        return label
    }()
    
    lazy var backScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .white
        return scrollView
    }()
}

extension DetailViewController: DetailViewProtocol { }

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: CustomCell.className, for: indexPath ) as! CustomCell
        cell.url = game.image[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
}

extension DetailViewController: UICollectionViewDelegate { }

extension DetailViewController: UICollectionViewDelegateFlowLayout { }

extension DetailViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if url.absoluteString == "Steam" {
            let url = URL(string: game.url)
            if #available(iOS 10.0, *){
                UIApplication.shared.open(url!, options: [:])
            } else {
                UIApplication.shared.openURL(url!)
            }
        }
    }
}

