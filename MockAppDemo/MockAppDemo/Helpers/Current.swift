//
//  File.swift
//  MockAppDemo
//
//  Created by mac on 7/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class Current {
    static let shared = Current()
    
    init() {
       
    }
    
    var CurrentProduct: Product = Product(name: "", description: "", options: [], images: [], variants: [])
    
    var currentKeyWord: String = ""
    
}
