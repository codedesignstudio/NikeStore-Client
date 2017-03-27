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
    
    func unwindBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
