//
//  SigninController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 17/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SigninController: UIViewController {
    
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
    
    func unwindBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
