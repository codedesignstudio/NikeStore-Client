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
                print(jsonObject)
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
}

