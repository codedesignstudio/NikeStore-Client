//
//  extension.swift
//  MAX
//
//  Created by Sagaya Abdulhafeez on 02/01/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ChameleonFramework
extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension UserDefaults {
    static func getThis(defaultString:String)-> String{
        let def = UserDefaults.standard
        let defaultObj = def.string(forKey: defaultString)
        guard let defaultOb = defaultObj else {return ""}
        return defaultOb
    }
}

extension StoreLandingController{
    func getCategories(){
        LLSpinner.spin()
        allCategory = []
        let token = UserDefaults.standard.string(forKey: "token")
        let header:HTTPHeaders = ["token": token!]
        Alamofire.request(CATEGORIES, method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: header).responseJSON { (response) in

            if response.response?.statusCode == 200{
                LLSpinner.stop()
                let jsonObject = JSON(response.result.value!)
                let jsonCategories = jsonObject["categories"].array
                for jsonCategory in jsonCategories!{
                    let name = jsonCategory["name"].string
                    let image_url = jsonCategory["attachment_url"].string
                    let id = jsonCategory["objectId"].string
                    let newCategory = Category(name: name, image: image_url, color:UIColor(randomFlatColorOf:.light), id: id!)
                    self.allCategory.append(newCategory)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }else{
                LLSpinner.stop()
            }
        }
    }
}

extension ProductController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    func getProducts(){
        products = []
        LLSpinner.spin()
        let url = "\(BASE)/categories/\(category_id!)/products"
        let header:HTTPHeaders = ["token": token!]
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: header).responseJSON { (response) in
            print(JSON(response.result.value!))
            if response.response?.statusCode == 200{
                LLSpinner.stop()
                let jsonObject = JSON(response.result.value!)
                let productsArr = jsonObject["products"].array
                for prod in productsArr!{
                    let name = prod["name"].string
                    let price = prod["price"].string
                    let images = prod["images"].arrayObject as! [String]
                    let image = images[0] 
                    let id = prod["objectId"].string
                    let desc = prod["lorem"].string
                    let newProduct = Product(name: name!, image: image, price: price!, images: images,description: desc!,id:id!)
                    self.products.append(newProduct)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }else{
                LLSpinner.stop()
            }
        }
    }
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No product to show here"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    override func viewDidLayoutSubviews() {
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
}



extension RegisterController {
    func handleRegister(){
        LLSpinner.spin()
        guard let email = emailTextField.text, let password = passwordTextField.text, let phone = phoneNumber.text, let fullName = fullName.text else{return print("err")}
        let params:Parameters = ["email": email,"password":password,"full_name": fullName,"phone": phone]
        Alamofire.request(REGISTER, method: .post, parameters: params, encoding: JSONEncoding(options: []), headers: nil).responseJSON { (response) in
            if response.response?.statusCode == 200{
                self.present(SigninController(), animated: true, completion: nil)
                LLSpinner.stop()
            }else{
                LLSpinner.stop()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signUpButton)
        view.addSubview(backButton)
        view.addSubview(fullName)
        view.addSubview(phoneNumber)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            
            fullName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullName.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            fullName.widthAnchor.constraint(equalToConstant: 170),
            
            phoneNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumber.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 20),
            phoneNumber.widthAnchor.constraint(equalToConstant: 170),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: 170),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 170),
            
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 40),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.widthAnchor.constraint(equalToConstant: 190),
            ])
    }
}

extension productDetailViewController{
    func handleAddToCart(){
        LLSpinner.spin()
        let url = "\(BASE)/products/\(product.id!)/addtocart"
        let header:HTTPHeaders = ["token": token!]
        let params: Parameters = ["id": product.id!]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding(options: []), headers: header).responseJSON { (response) in
            print(JSON(response.result.value!))
            if response.response?.statusCode == 200{
                let alert = UIAlertController(title: "Success", message: "\(self.product.name!) Successfully added to cart", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                    self.present(CartController(), animated: true, completion: nil)
                    
                }))
                self.present(alert, animated: true, completion: nil)
                LLSpinner.stop()
            }else{
                let alert = UIAlertController(title: "Error", message: "Unable to add \(self.product.name!) to cart", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                LLSpinner.stop()
            }
        }
    }
    
    func addToFavorite(){
        LLSpinner.spin()
        let url = "\(BASE)/products/\(product.id!)/addtofavorites"
        let header:HTTPHeaders = ["token": token!]
        let params: Parameters = ["id": product.id!]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding(options: []), headers: header).responseJSON { (response) in
            print(JSON(response.result.value!))
            if response.response?.statusCode == 200{
                let alert = UIAlertController(title: "Success", message: "\(self.product.name!) Successfully added to favorites", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                    //GO TO FAVORITE VIEW
                }))
                self.present(alert, animated: true, completion: nil)
                LLSpinner.stop()
            }else{
                let alert = UIAlertController(title: "Error", message: "Unable to add \(self.product.name!) to cart", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                LLSpinner.stop()
            }
        }

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
}

extension SigninController {
    func handleSignIn(){
        LLSpinner.spin()
        guard let email = emailTextField.text?.lowercased(), let password = passwordTextField.text else {return}
        let params:Parameters = ["email": email,"password":password]
        print(params)
        Alamofire.request(LOGIN, method: .post, parameters: params, encoding: JSONEncoding(options: []), headers: nil).responseJSON { (response) in
            if response.response?.statusCode == 200{
                let jsonObj = JSON(response.result.value!)
                print(jsonObj)
                let token = jsonObj["token"].string
                let userId = jsonObj["user"]["objectId"].string
                UserDefaults.standard.setValue(userId, forKey: "userid")
                UserDefaults.standard.setValue(token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                LLSpinner.stop()
                let vc = UINavigationController(rootViewController: StoreLandingController())
                self.present(vc, animated: true, completion: nil)
            }else{
                let jsonObj = JSON(response.result.value!)
                print(jsonObj)
                LLSpinner.stop()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            emailTextField.widthAnchor.constraint(equalToConstant: 170),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 170),
            
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 40),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.widthAnchor.constraint(equalToConstant: 190),
            ])
    }
}

extension CartController{
    func getCartItems(){
        LLSpinner.spin()
        cartItems = []
        let url = "\(BASE)/users/\(userid!)/cart"
        let header:HTTPHeaders = ["token": token!]
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: header).responseJSON { (response) in
            let jsonObject = JSON(response.result.value!)
            print(jsonObject)
            if response.response?.statusCode == 200{
                LLSpinner.stop()
                let cartObject = jsonObject["cart"].array
                for cartObj in cartObject!{
                    let image = cartObj["product"]["images"][0].string
                    let name = cartObj["product"]["name"].string
                    let price = cartObj["product"]["price"].string
                    let productId = cartObj["product"]["objectId"].string
                    
                    let newCart = Cart(image: image!, name: name!, price: price!, productId: productId!)
                    self.cartItems.append(newCart)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }else{
                LLSpinner.stop()
            }
        }
    }
    
    func deleteProduct(sender:UIButton){
        let index: Int = (sender.layer.value(forKey: "index")) as! Int
        let product_id = cartItems[index].productId
        let product_name = cartItems[index].name
        let alert = UIAlertController(title: "", message: "Are you sure you want to remove \(product_name!) from your cart?", preferredStyle: .alert)
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { (alert) in
            LLSpinner.spin()
            let url = "\(BASE)/products/\(product_id!)/removefromcart"
            let header:HTTPHeaders = ["token": self.token!]
            Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding(options: []), headers: header).response { (response) in
                if response.response?.statusCode == 200{
                    LLSpinner.stop()
                    DispatchQueue.main.async {
                        self.viewWillAppear(true)
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(removeAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
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

}
