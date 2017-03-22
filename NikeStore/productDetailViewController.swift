//
//  productDetailViewController.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 18/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit

class productDetailViewController: UIViewController {
    var product: Product!
    
    let label: UILabel = {
       let l = UILabel()
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        view.addSubview(label)
        view.addConstraintsWithFormat("H:|[v0]|", views: label)
        view.addConstraintsWithFormat("V:|[v0]|", views: label)
    }
    override func viewWillAppear(_ animated: Bool) {
        print(product?.name)
    }
}
