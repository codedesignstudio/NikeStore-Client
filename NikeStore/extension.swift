//
//  extension.swift
//  MAX
//
//  Created by Sagaya Abdulhafeez on 02/01/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Alamofire

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

extension SigninController {
    func handleSignIn(){
        LLSpinner.spin()
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        let params:Parameters = ["email": email,"password":password]
        Alamofire.request(LOGIN, method: .post, parameters: params, encoding: JSONEncoding(options: []), headers: nil).responseJSON { (response) in
            if response.response?.statusCode == 200{
                LLSpinner.stop()
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                let vc = UINavigationController(rootViewController: StoreLandingController())
                self.present(vc, animated: true, completion: nil)
            }else{
                LLSpinner.stop()
            }
        }
    }
}
