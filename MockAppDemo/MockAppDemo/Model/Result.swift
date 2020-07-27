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

struct ProductToAdd: Codable {
    var product: ProductField
}

struct ProductField: Codable {
    var name: String
}

extension Product {
    func getPriceInString(mode: Int) -> String {
        var price = 0
        if mode == 1 {
            price = Int(self.variants[0].variant_retail_price)
        } else {
            price = Int(self.variants[0].variant_whole_price)
        }
        var p: String = ""
        for i in 0..<"\(price)".count  {
               
            if(i != 0 && i%3 == 0) {
                p.append(".")
            }
            
             p.append("\(price)".reversed()[i])
        }
        let rs: String = (String) (p.reversed())
        return " \(rs) đ "
    }
    
    func getDescription() -> String {
        if let desc = self.description {
            return desc
        } else {
            return "Chưa có mô tả cho sản phẩm này !"
        }
    }
    
}
