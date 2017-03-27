//
//  RegisterController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 21/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import TransitionAnimation
import TransitionTreasury
class RegisterController: UIViewController {
    weak var modalDelegate: ModalViewControllerDelegate?

    let fullName: SkyFloatingLabelTextField  = {
        let t = SkyFloatingLabelTextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Full Name"
        t.placeholderFont = UIFont.boldSystemFont(ofSize: 18)
        t.lineColor = .gray
        t.selectedLineColor = .gray
        t.textColor = .white
        t.lineHeight = 1.0
        t.tintColor = .white
        t.placeholderColor = .white
        t.selectedTitleColor = .white
        t.selectedLineColor = .white
        return t
    }()

    let phoneNumber: SkyFloatingLabelTextField  = {
        let t = SkyFloatingLabelTextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Phone Number"
        t.placeholderFont = UIFont.boldSystemFont(ofSize: 18)
        t.lineColor = .gray
        t.selectedLineColor = .gray
        t.textColor = .white
        t.lineHeight = 1.0
        t.keyboardType = .phonePad
        t.tintColor = .white
        t.placeholderColor = .white
        t.selectedTitleColor = .white
        t.selectedLineColor = .white
        return t
    }()

    
    let emailTextField: SkyFloatingLabelTextField  = {
        let t = SkyFloatingLabelTextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "E-Mail"
        t.placeholderFont = UIFont.boldSystemFont(ofSize: 18)
        t.lineColor = .gray
        t.selectedLineColor = .gray
        t.textColor = .white
        t.lineHeight = 1.0
        t.tintColor = .white
        t.placeholderColor = .white
        t.selectedTitleColor = .white
        t.selectedLineColor = .white
        return t
    }()
    let passwordTextField: SkyFloatingLabelTextField  = {
        let t = SkyFloatingLabelTextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Password"
        t.placeholderFont = UIFont.boldSystemFont(ofSize: 18)
        t.placeholderColor = .white
        t.lineColor = .gray
        t.selectedLineColor = .gray
        t.textColor = .white
        t.lineHeight = 1.0
        t.isSecureTextEntry = true
        t.tintColor = .white
        t.selectedTitleColor = .white
        t.selectedLineColor = .white
        return t
    }()
    let forgotPasswordButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 25
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return btn
    }()

    
    let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow"), for: .normal)
        btn.addTarget(self, action: #selector(unwindBack), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageview = UIImageView(frame: UIScreen.main.bounds)
        imageview.image = UIImage(named: "signin")
        view.insertSubview(imageview, at: 0)
        
    }
    
    func unwindBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
