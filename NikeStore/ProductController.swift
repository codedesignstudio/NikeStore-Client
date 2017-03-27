//
//  shoesController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 17/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Kingfisher
import TransitionTreasury
import TransitionAnimation

struct Product{
    var name:String?
    var image:String?
    var price: String?
    var images: [String]?
    var description:String
    var id:String?
}

class ProductController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NavgationTransitionable {
    var category_id:String?
    var category_name:String?
    var token:String?
    
    var tr_pushTransition: TRNavgationTransitionDelegate?

    
    let topCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        flow.scrollDirection = .horizontal
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.isScrollEnabled = true
        collection.flashScrollIndicators()
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        token = UserDefaults.standard.string(forKey: "token")
        
        title = category_name!.uppercased()
        self.navigationController?.navigationBar.topItem?.title = " "
        view.backgroundColor = .white
        topCollection.delegate = self
        topCollection.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        topCollection.register(TopCell.self, forCellWithReuseIdentifier: "top")
        collectionView.register(ShoeCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(topCollection)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            topCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topCollection.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            topCollection.widthAnchor.constraint(equalTo: view.widthAnchor),
            topCollection.heightAnchor.constraint(equalToConstant: 200),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProducts()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollection{
            return 3
        }else{
            return products.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "top", for: indexPath) as! TopCell
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShoeCell
            cell.shoe = products[indexPath.row]

            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollection{
            return CGSize(width: view.frame.width, height: collectionView.frame.height)
        }else{
            var screenRect: CGRect = UIScreen.main.bounds
            var screenWidth: Double = Double(screenRect.size.width)
            var cellWidth: Double = screenWidth / 3.0
            var size = CGSize(width: CGFloat(cellWidth), height: CGFloat(cellWidth))
            return size
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topCollection{
            return CGFloat(2)
        }else{
            return CGFloat(0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topCollection{
            return CGFloat(2)
        }else{
            return CGFloat(0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var vc = productDetailViewController()
        
        vc.product = self.products[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class TopCell: UICollectionViewCell{
    
    let topButtonView: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "slider")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
   override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        addSubview(topButtonView)
        NSLayoutConstraint.activate([
            topButtonView.centerYAnchor.constraint(equalTo: centerYAnchor),
            topButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topButtonView.heightAnchor.constraint(equalTo: heightAnchor),
            topButtonView.widthAnchor.constraint(equalTo: widthAnchor),
            
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShoeCell: UICollectionViewCell{
    
    var shoe: Product?{
        didSet{
            var strUrl = shoe?.image!
            let beforeIndex = strUrl?.index((strUrl?.endIndex)!, offsetBy: -4)
            let characterToAppend:Character = "t"
            strUrl?.insert(characterToAppend, at: beforeIndex!)
            let imgUrl = URL(string: strUrl!)
            imageV.kf.setImage(with: imgUrl)
            shoeName.text = shoe?.name!
            guard let price = shoe?.price else {return}
            shoePrice.text = "₦\(price)"
        }
    }
    
    let imageV: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        return img
    }()
    
    let shoeName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    let shoePrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        addSubview(imageV)
        addSubview(shoeName)
        addSubview(shoePrice)
        
        NSLayoutConstraint.activate([
            imageV.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageV.bottomAnchor.constraint(equalTo: shoeName.topAnchor, constant: -4),
            imageV.heightAnchor.constraint(equalTo: heightAnchor, constant: -50),
            imageV.widthAnchor.constraint(equalTo: widthAnchor),
            
            shoePrice.centerXAnchor.constraint(equalTo: centerXAnchor),
            shoePrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            shoeName.centerXAnchor.constraint(equalTo: centerXAnchor),
            shoeName.bottomAnchor.constraint(equalTo: shoePrice.topAnchor, constant: -1),
            
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
