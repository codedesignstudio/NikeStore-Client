//
//  shoesController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 17/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit

struct Product{
    var name:String?
    var image:String?
    var price: String?
}

class shoesController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let topCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        flow.scrollDirection = .horizontal
        return collection
    }()
    
    let collectionView: UICollectionView = {
//        let flow1 = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var shoes = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shoes"
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
            topCollection.topAnchor.constraint(equalTo: view.topAnchor),
            topCollection.widthAnchor.constraint(equalTo: view.widthAnchor),
            topCollection.heightAnchor.constraint(equalToConstant: 200),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: topCollection.bottomAnchor, constant: 20),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),

        ])
        
        shoes.append(Product(name: "Hyper Dunk 2016 fly", image: "1", price: "17000"))
        shoes.append(Product(name: "Kyrie 2", image: "2", price: "16000"))
        shoes.append(Product(name: "Zoom Lebron soldier", image: "3", price: "18000"))
        shoes.append(Product(name: "Hyper Dunk 2016", image: "5", price: "11000"))
        shoes.append(Product(name: "Hyper Dunk 2016", image: "6", price: "20000"))
        shoes.append(Product(name: "Lebron x11 limited", image: "7", price: "19000"))

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollection{
            return 3
        }else{
            return shoes.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "top", for: indexPath) as! TopCell
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShoeCell
            cell.shoe = shoes[indexPath.row]

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
        
        vc.product = self.shoes[indexPath.row]
        
        self.navigationController?.pushViewController(productDetailViewController(), animated: true)
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
            guard let img = shoe?.image, let name = shoe?.name?.capitalized,let price = shoe?.price else{ return }
            imageV.image = UIImage(named: img)
            shoeName.text = name
            shoePrice.text = "₦ \(price)"
        }
    }
    
    let imageV: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
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
            imageV.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageV.heightAnchor.constraint(equalTo: heightAnchor),
            imageV.widthAnchor.constraint(equalTo: widthAnchor),
            
            shoePrice.centerXAnchor.constraint(equalTo: centerXAnchor),
            shoePrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            shoeName.centerXAnchor.constraint(equalTo: centerXAnchor),
            shoeName.bottomAnchor.constraint(equalTo: shoePrice.topAnchor, constant: -8),
            
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
