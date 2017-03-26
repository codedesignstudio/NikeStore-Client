//
//  productDetailViewController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 18/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Kingfisher

class productDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var token:String?
    var product: Product!
    var images = [String]()
    var productCollection: UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let col = UICollectionView(frame: .zero, collectionViewLayout: lay)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.backgroundColor = .clear
        lay.scrollDirection = .horizontal
        return col
    }()
    let priceLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        return l
    }()
    let nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        return l

    }()
    let descriptionText: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 13)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        return l
        
    }()
    
    
    var addToFavoriteButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Add to favorites", for: .normal)
        btn.setTitleColor(UIColor(red:0.49, green:0.49, blue:0.49, alpha:1.0), for: .normal)
        btn.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.clear.cgColor
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        return btn
    }()
    var addToCartButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Add to cart", for: .normal)
        btn.setTitleColor(UIColor(red:0.49, green:0.49, blue:0.49, alpha:1.0), for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.clear.cgColor
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleAddToCart), for: .touchUpInside)
        return btn
    }()
    let containerView: UIView = {
       let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
        title = product.name
        images = product.images!
        token = UserDefaults.standard.string(forKey: "token")
        priceLabel.text = "₦\(product.price!)"
        nameLabel.text = product.name!
        descriptionText.text = product.description
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        productCollection.register(ProductImageCol.self, forCellWithReuseIdentifier: "img")
        productCollection.delegate = self
        productCollection.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {
        view.addSubview(productCollection)
        view.addSubview(priceLabel)
        view.addSubview(nameLabel)
        view.addSubview(descriptionText)
        view.addSubview(containerView)
        containerView.addSubview(addToCartButton)
        containerView.addSubview(addToFavoriteButton)
        NSLayoutConstraint.activate([
            productCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            productCollection.widthAnchor.constraint(equalTo: view.widthAnchor),
            productCollection.heightAnchor.constraint(equalToConstant: 250),
            productCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: productCollection.bottomAnchor, constant: 13),
            priceLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 17),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 17),
            descriptionText.widthAnchor.constraint(equalTo: view.widthAnchor),
            descriptionText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            containerView.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 18),
            containerView.heightAnchor.constraint(equalToConstant: 90),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addToFavoriteButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            addToFavoriteButton.topAnchor.constraint(lessThanOrEqualTo: containerView.topAnchor, constant: 15),
            addToFavoriteButton.heightAnchor.constraint(equalToConstant: 50),
            addToFavoriteButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            
            addToCartButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            addToCartButton.topAnchor.constraint(lessThanOrEqualTo: containerView.topAnchor, constant: 15),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as! ProductImageCol
        cell.image = images[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: CGFloat(productCollection.frame.width), height: CGFloat(productCollection.frame.height))
        return size
    }
}
class ProductImageCol: UICollectionViewCell {
    
    var image: String?{
        didSet{
            let url = URL(string: image!)
            imageView.kf.setImage(with: url)
        }
    }
    
    let imageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views: imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
