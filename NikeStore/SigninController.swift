//
//  SigninController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 17/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import TransitionAnimation
import TransitionTreasury

class SigninController: UIViewController {
    weak var modalDelegate: ModalViewControllerDelegate?

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
        btn.setTitle("Forgot Password?", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let signInButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 25
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
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
