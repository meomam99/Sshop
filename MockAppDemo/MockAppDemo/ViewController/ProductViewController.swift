//
//  SearchViewController.swift
//  MockAppDemo
//
//  Created by mac on 7/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductCell
        cell.p = products[indexPath.row]
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.2,
            delay: 0.02*Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
        
        if (indexPath.row == products.count-1 && products.count%20 == 0 && loadingData == false) {
            let page = products.count/20 + 1
            getAllProducts(page: page)
        }
    }
    
    var products: [Product] = []
    var loadingData = true
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProducts(page: 1)
  
    }
    
    func updateView() {
        loadingData = false
        btnAdd.layer.cornerRadius = 10
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.reloadData()
    }
       
    
    func getAllProducts(page: Int) {
        
        let session = URLSession(configuration: .default)
        let source = "https://interndev.mysapo.vn/admin/products.json?page=\(page)&limit=20"
        guard let url = URL(string: source) else {
            print("Error building URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue( "919b6923dae8421cfda6dffdc5a669f7", forHTTPHeaderField:"X-Sapo-SessionId")
        loadingData = true
        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    print("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let rs: Result = try JSONDecoder().decode(Result.self, from: data)
                        if(rs.products.count != 0) {
                            self.products.append(contentsOf: rs.products)
                        }
                        self.updateView()
                    } else {
                        print("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        
        task.resume()
    }
    
}
