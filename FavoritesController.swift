//
//  FavoritesController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 26/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit


class FavoritesController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let col = UICollectionView(frame: .zero, collectionViewLayout: flow)
        col.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        return col
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FAVORITES"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close.png"), style: .plain, target: self, action: #selector(goBack))

        view.addSubview(collectionView)
        view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: collectionView)
        view.addConstraintsWithFormat("V:|-8-[v0]|", views: collectionView)
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: "fav")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)

    }
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fav", for: indexPath) as! FavoriteCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds
        let width = screenWidth.width
        return CGSize(width: width, height: 75)
    }
    
}
class FavoriteCell: UICollectionViewCell {
    
    let imageV: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "1")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        return img
    }()
    let nameLabel: UILabel = {
        let l = UILabel()
        l.text = "wffw"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(imageV)
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            imageV.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            imageV.topAnchor.constraint(equalTo: topAnchor),
            imageV.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            imageV.heightAnchor.constraint(equalTo: heightAnchor),
            
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
