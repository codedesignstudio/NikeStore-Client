//
//  StoreLandingController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 17/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Kingfisher

struct Category {
    var name:String?
    var image: String?
    var color: UIColor?
}

class StoreLandingController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let colection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        colection.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        return colection
    }()
    
    var allCategory = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "bag"), style: .plain, target: self, action: nil),UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: self, action: nil)]
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]
        title = "Nike Store"
        collectionView.delegate = self
        getCategories()
        collectionView.dataSource = self
        collectionView.register(ColCell.self, forCellWithReuseIdentifier: "cell")
 

        
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") != true{
            self.present(LandingViewController(), animated: false, completion: nil)
        }

    }
    override func viewWillLayoutSubviews() {
        view.addSubview(collectionView)
        view.addConstraintsWithFormat("H:|-15-[v0]-15-|", views: collectionView)
        view.addConstraintsWithFormat("V:|-20-[v0]-10-|", views: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: collectionView.frame.width, height: 100)
        }else if indexPath.row == 1{
            return CGSize(width: collectionView.frame.width, height: 100)
        }
        
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColCell
        cell.category = allCategory[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.navigationController?.pushViewController(shoesController(), animated: true)
        }
    }
}

class ColCell:UICollectionViewCell{
    
    var category:Category?{
        didSet{
            guard let catText = category?.name?.uppercased(), let bgColor = category?.color, let image = category?.image else{return}
            categoryText.text = catText
            backgroundColor = bgColor
            let url = URL(string: (category?.image)!)
            imageV.kf.setImage(with: url)
        }
    }
    
    let categoryText: UILabel = {
        let ab = UILabel()
        ab.translatesAutoresizingMaskIntoConstraints = false
        ab.numberOfLines = 2
        ab.font = UIFont.boldSystemFont(ofSize: 12)
        return ab
    }()
    let imageV: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(categoryText)
        addSubview(imageV)
        NSLayoutConstraint.activate([
            categoryText.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            categoryText.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            
            imageV.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            imageV.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageV.heightAnchor.constraint(equalTo: heightAnchor),
            imageV.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2)
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
