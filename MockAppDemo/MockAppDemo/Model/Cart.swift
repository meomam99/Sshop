//
//  Cart.swift
//  MockAppDemo
//
//  Created by mac on 7/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class User {
    static let shared = User()
    
    var orders = [Cart]()
    
    func add(c: Cart) {
        orders.append(c)
    }
}

class Cart {
    static let shared = Cart()
    
    var products = [Order]()
    
    func add(p: Product, quantity: Int, price: Int) {
        
        products.append(Order(product: p, quantity: quantity, price: price))
    }
    func showInfo() {
        for p in products {
            print("\(p.product.name)   \(p.price)x\(p.quantity)")
        }
    }
}
