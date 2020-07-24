//
//  Product.swift
//  MockAppDemo
//
//  Created by mac on 7/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Result: Codable {
    var products: [Product]
}

struct Product: Codable {
    var name: String
    var description: String?
    var options: [Option]
    var images: [Image]
    var variants: [Variant]
}

struct Option: Codable {
    var name: String
    var values: [String]
}

struct Image: Codable {
    var full_path: String
}

struct Variant: Codable{
    var variant_whole_price: Double
    var variant_retail_price: Double
    
}

struct Order: Codable {
    var product: Product
    var quantity: Int
    var price: Int
}

struct ResultSearch: Codable {
    var product: Product
}


struct ProductToAdd: Codable {
    var product: ProductField
}

struct ProductField: Codable {
    var name: String
}

