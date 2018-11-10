//
//  MainScreenController.swift
//  GameCatalogs
//
//  Created by Dmitriy Korkin on 02/11/2018.
//  Copyright © 2018 Дмитрий Евсюков. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    var gameArray = [Game]()
    var collectionView: UICollectionView!
    var tableView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameArray = DataLoad.loadDataFromPlist(gameArray: &gameArray)
        layout = layoutSetup()
        self.view.addSubview(collectionViewSetup())
        self.view.addSubview(segmentControll)
    }
    
    func layoutSetup() -> UICollectionViewFlowLayout {
        var currentWidth: CGFloat
        if (UIScreen.main.bounds.width < 500){
            currentWidth = UIScreen.main.bounds.width * 0.45
        } else {
            currentWidth = UIScreen.main.bounds.width * 0.29
        }
        layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: currentWidth, height: UIScreen.main.bounds.height * 0.17)
        return layout
    }
    
    func collectionViewSetup() -> UICollectionView {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.className)
        collectionView.register(CustomTableViewCell.self, forCellWithReuseIdentifier: CustomTableViewCell.className)
        collectionView.backgroundColor = .white
        return collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameArray.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController(game : gameArray[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    lazy var segmentControll: UISegmentedControl = {
        let items = [NSLocalizedString("tile", comment: ""), NSLocalizedString("table", comment: "")]
        let segmentedControl = UISegmentedControl(items : items)
        segmentedControl.frame = CGRect.init(x: (UIScreen.main.bounds.width/2) - 100, y: 00, width: 200, height: 40)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MainScreenViewController.indexChanged(_:)), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 7.0
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .white
        return segmentedControl
    }()
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            layout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
            if (UIScreen.main.bounds.width < 500){
                layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2) - UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.2)
            } else{
                layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3) - UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.2)
            }
            self.collectionView.reloadData()
        case 1:
            layout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.17)
            self.collectionView.reloadData()
        default:
            break
        }
    }
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout { }

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentControll.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.className, for: indexPath) as! CustomCollectionViewCell
            cell.imageView.imageURI = gameArray[indexPath.row].image[0]
            cell.nameLabel.text = gameArray[indexPath.row].name
            cell.categoryLabel.text = NSLocalizedString("category", comment: "") + ": " + gameArray[indexPath.row].category.rawValue
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTableViewCell.className, for: indexPath) as! CustomTableViewCell
            cell.imageView.imageURI = gameArray[indexPath.row].image[0]
            cell.nameLabel.text = gameArray[indexPath.row].name
            cell.categoryLabel.text = NSLocalizedString("category", comment: "") + ": " + gameArray[indexPath.row].category.rawValue
            cell.textLabel.text = gameArray[indexPath.row].note
            return cell
        }
    }
}
