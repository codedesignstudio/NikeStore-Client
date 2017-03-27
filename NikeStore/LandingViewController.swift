//
//  ViewController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 16/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import Alamofire
import TransitionTreasury
import TransitionAnimation

class LandingViewController: UIViewController, ModalTransitionDelegate {
    var tr_presentTransition: TRViewControllerTransitionDelegate?

    let signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = UIColor(red:0.95, green:0.87, blue:0.79, alpha:1.0)
        btn.setTitleColor(UIColor(red:0.64, green:0.55, blue:0.46, alpha:1.0), for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "landing")
        view.insertSubview(imageView, at: 0)
        
    }
    func goToSignIn(){
        let vc = SigninController()
        vc.modalDelegate = self
        tr_presentViewController(vc, method: TRPresentTransitionMethod.fade)
    }
    func goToRegister(){
        let vc = RegisterController()
        vc.modalDelegate = self
        tr_presentViewController(vc, method: TRPresentTransitionMethod.fade)
    }
    override func viewWillLayoutSubviews() {
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.widthAnchor.constraint(equalToConstant: 190),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.widthAnchor.constraint(equalToConstant: 190),
        ])
    }
    
}

