//
//  CartController.swift
//  Pods
//
//  Created by Sagaya Abdulhafeez on 26/03/2017.
//
//

import UIKit
import Kingfisher
import TransitionTreasury
import TransitionAnimation

struct Cart {
    var image: String?
    var name:String?
    var price:String?
    var productId:String?
}

class CartController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var token:String?
    weak var modalDelegate: ModalViewControllerDelegate?

    var userid: String?
    let topContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let collectionView:UICollectionView = {
       let flow = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        return collection
    }()
    let numberOfitems: UILabel = {
        let l = UILabel()
        l.text = "7 items"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let totatlCost: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Total Cost: 1000"
        return l
    }()
    
    let checkoutButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Proceed to Make Payment", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.alpha = 1
        btn.addTarget(self, action: #selector(checkoutBtn), for: .touchUpInside)
        return btn
    }()
    var cartItems = [Cart]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MY CART"
        token = UserDefaults.standard.string(forKey: "token")
        userid = UserDefaults.standard.string(forKey: "userid")
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close.png"), style: .plain, target: self, action: #selector(goBack))
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        collectionView.delegate = self
        collectionView.dataSource  = self
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: "cart")
        topContainerView.isHidden = true
        checkoutButton.isHidden = true
    }
    override func viewDidLayoutSubviews() {
        view.addSubview(topContainerView)
        topContainerView.addSubview(numberOfitems)
        topContainerView.addSubview(totatlCost)
        view.addSubview(collectionView)
        view.addSubview(checkoutButton)
        var screenRect = UIScreen.main.bounds
        var screenWidth = screenRect.size.width
        var cellWidth = screenWidth / 2.0
        var collectionHeight = cellWidth * 2.0
        
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            topContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topContainerView.heightAnchor.constraint(equalToConstant: 50),
            topContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            numberOfitems.leftAnchor.constraint(equalTo: topContainerView.leftAnchor, constant: 10),
            numberOfitems.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 15),
            numberOfitems.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5),
            
            totatlCost.rightAnchor.constraint(equalTo: topContainerView.rightAnchor, constant: 10),
            totatlCost.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 15),
            totatlCost.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5),
            
            collectionView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 17),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: collectionHeight),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 60),
            checkoutButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        getCartItems()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cart", for: indexPath) as! CartCell
        if cartItems.count != 0{
            checkoutButton.isHidden = false
            topContainerView.isHidden = false
        }
        cell.cart = cartItems[indexPath.row]
        getTotalPrice()
        getTotalItemInCart()
        //saving the value of the index in 'index'
        cell.closeButton.layer.setValue(indexPath.row, forKey: "index")
        cell.closeButton.addTarget(self, action: #selector(deleteProduct), for: .touchUpInside)
        return cell
    }
    
    func getTotalItemInCart(){
        var total = cartItems.count
        var attrStr = NSMutableAttributedString(string: "\(total) ", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 13)])
        attrStr.append(NSAttributedString(string: "Items", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13),NSForegroundColorAttributeName: UIColor(red:0.69, green:0.68, blue:0.73, alpha:1.0)]))
            numberOfitems.attributedText = attrStr
    }
    
    func getTotalPrice()
    {
        var totalPrice = 0
        for i in cartItems{
            var price = Int(i.price!)
            totalPrice += price!
        }
        var attrStr = NSMutableAttributedString(string: "Total Cost: ", attributes: [NSForegroundColorAttributeName: UIColor(red:0.69, green:0.68, blue:0.73, alpha:1.0),NSFontAttributeName: UIFont.systemFont(ofSize: 13)])
        attrStr.append(NSAttributedString(string: "₦\(totalPrice)", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 13)]))
        totatlCost.attributedText = attrStr
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var screenRect = UIScreen.main.bounds
        var screenWidth = screenRect.size.width
        var cellWidth = screenWidth / 2.0
        var size = CGSize(width: cellWidth, height: cellWidth)
        
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return CGFloat(0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    func checkoutBtn(){
        var alert = UIAlertController(title: "", message: "Feature Coming soon", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
class CartCell: UICollectionViewCell {
    
    var cart:Cart?{
        didSet{
            let url = URL(string: (cart?.image!)!)
            imageV.kf.setImage(with: url)
            let attrString = NSMutableAttributedString(string: (cart?.name!)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)])
            attrString.append(NSAttributedString(string: " \n₦\(cart!.price!)", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 13)]))
            detailLabel.attributedText = attrString
        }
    }
    
    let containerV: UIView = {
       let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let imageV: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let detailLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    let closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(containerV)
        containerV.addSubview(imageV)
        containerV.addSubview(detailLabel)
        containerV.addSubview(closeButton)
        containerV.addConstraintsWithFormat("H:|-8-[v0]", views: closeButton)
        containerV.addConstraintsWithFormat("V:|-8-[v0]", views: closeButton)
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: containerV)
        addConstraintsWithFormat("V:|-10-[v0]-10-|", views: containerV)
        
        NSLayoutConstraint.activate([
            imageV.topAnchor.constraint(equalTo: containerV.topAnchor),
            imageV.centerXAnchor.constraint(equalTo: containerV.centerXAnchor),
            imageV.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            imageV.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 0.7),
            
            detailLabel.bottomAnchor.constraint(equalTo: containerV.bottomAnchor),
            detailLabel.centerXAnchor.constraint(equalTo: containerV.centerXAnchor),
            detailLabel.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 0.3),
            detailLabel.widthAnchor.constraint(equalTo: containerV.widthAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






















