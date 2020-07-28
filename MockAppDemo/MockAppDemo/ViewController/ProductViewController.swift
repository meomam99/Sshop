//
//  SearchViewController.swift
//  MockAppDemo
//
//  Created by mac on 7/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var products: [Product] = []
    var loadingData = true
    var total = 21
    let limit = 10
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProducts(page: 1, limit: limit)
  
    }
    
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
        if (indexPath.row == products.count-1 && products.count%limit == 0 && products.count < total && loadingData == false) {
            self.perform(#selector(loadMore), with: nil, afterDelay: 1)
        }
    }
    
    @objc func loadMore() {
        let page = products.count/limit + 1
        getAllProducts(page: page, limit: limit)
    }
    
    func updateView() {
        loadingData = false
        btnAdd.layer.cornerRadius = 10
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.reloadData()
    }
       
    
    func getAllProducts(page: Int, limit: Int) {
        
        let session = URLSession(configuration: .default)
        let source = "https://interndev.mysapo.vn/admin/products.json?page=\(page)&limit=\(limit)"
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
                        self.total = rs.metadata.total
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
