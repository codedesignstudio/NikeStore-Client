//
//  models.swift
//  NikeStore
//
//  Created by Sagaya Abdulhafeez on 27/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//


struct Product{
    var name:String?
    var image:String?
    var price: String?
    var images: [String]?
    var description:String
    var id:String?
}

struct Cart {
    var image: String?
    var name:String?
    var price:String?
    var productId:String?
}

struct Favorite {
    var name:String?
    var image:String?
    var price: String?
    var images: [String]?
    var description:String
    var id:String?
}

struct Category {
    var name:String?
    var image: String?
    var color: UIColor?
    var id:String?
}

