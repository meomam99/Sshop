//
//  Utilities.swift
//  MockAppDemo
//
//  Created by mac on 7/25/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromInternet(urlString: String) {
    
        let url = URL(string: urlString)
        
        let dataTask = URLSession.shared.dataTask(with: url!) {  (data, _, _) in
                    if let data = data {
                        DispatchQueue.main.async {
                           self.image = UIImage(data: data)
                          
                        }
                    }
                }
        dataTask.resume()
    }
}
