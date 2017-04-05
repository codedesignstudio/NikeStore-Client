//
//  FavoritesController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 26/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class FavoritesController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    var userid: String?
    var token:String?
    let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let col = UICollectionView(frame: .zero, collectionViewLayout: flow)
        col.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        return col
    }()
    var favorite = [Favorite]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FAVORITES"
        token = UserDefaults.standard.string(forKey: "token")
        userid = UserDefaults.standard.string(forKey: "userid")
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close.png"), style: .plain, target: self, action: #selector(goBack))
        view.addSubview(collectionView)
        view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: collectionView)
        getFavorites()
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
        return favorite.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fav", for: indexPath) as! FavoriteCell
        cell.favorites = favorite[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds
        let width = screenWidth.width
        return CGSize(width: width, height: 75)
    }
    func getFavorites(){
        LLSpinner.spin()
        let url = "\(BASE)/users/\(userid!)/favorites"
        let header:HTTPHeaders = ["token": token!]

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: header).responseJSON { (response) in
            if response.response?.statusCode == 200{
                let jsonObject = JSON(response.result.value)
                let favoritesArr = jsonObject["favorites"].array
                print(jsonObject)
                for favs in favoritesArr!{
                    let name = favs["product"]["name"].string
                    let image = favs["product"]["images"][0].string
                    let price = favs["product"]["price"].string
                    let id = favs["product"]["objectId"].string
                    print(name)
                    let newFav = Favorite(image: image!, id: id!, name: name!, price: price!)
                    self.favorite.append(newFav)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                LLSpinner.stop()
            }else{
                LLSpinner.stop()
            }
        }
    }
    
}
class FavoriteCell: UICollectionViewCell {
    
    var favorites:Favorite?{
        didSet{
            let imgUrl = URL(string: (favorites?.image)!)
            imageV.kf.setImage(with: imgUrl)
            nameLabel.text = favorites?.name!
            priceLabel.text = "₦\(favorites!.price!)"
        }
    }
    
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
    let priceLabel: UILabel = {
       let lab = UILabel()
        lab.text = "₦500"
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont.systemFont(ofSize: 11)
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(imageV)
        addSubview(nameLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            imageV.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            imageV.topAnchor.constraint(equalTo: topAnchor),
            imageV.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            imageV.heightAnchor.constraint(equalTo: heightAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: imageV.rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            priceLabel.leftAnchor.constraint(equalTo: imageV.rightAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
