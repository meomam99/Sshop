//
//  ViewController.swift
//  MockAppDemo
//
//  Created by mac on 7/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var products: [Product] = []
    var page = 1
    var loadingData: Bool = true
    @IBOutlet weak var btnViewProduct: UIButton!
    @IBOutlet weak var btnViewCart: UIButton!
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var productTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.p = self.products[indexPath.row]
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == products.count-1 && products.count%6 == 0 && loadingData == false) {
          
            let page = products.count/6 + 1
            getNewProducts(page: page, limit: 6)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getNewProducts(page: 1, limit: 6)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func update(_ sender: Any) {
        products = []
        getNewProducts(page: 1, limit: 6)
    }
    
    func setupView() {
        btnViewProduct.layer.borderWidth = 1
        btnViewProduct.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 1, alpha: 1)
        
        btnViewProduct.layer.cornerRadius = 5
        
        btnViewCart.layer.borderWidth = 1
        btnViewCart.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 1, alpha: 1)
        
        btnViewCart.layer.cornerRadius = 5
        
        btnViewProfile.layer.borderWidth = 1
        btnViewProfile.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 1, alpha: 1)
        
        btnViewProfile.layer.cornerRadius = 5
    }
    
    func updateView() {
        loadingData = false
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.reloadData()
    }
    
    
    
    func getNewProducts(page: Int, limit: Int) {
        
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

class ProductCell: UITableViewCell {
    
    var p = Product(name: "", description: "", options: [], images: [], variants: [Variant(variant_whole_price: 0, variant_retail_price: 0)])
    
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        
        lbName.text = p.name
        lbPrice.text = p.getPriceInString(mode: 1)

        if p.images.count != 0 {
            img.setImageFromInternet(urlString: p.images[0].full_path)
        } else {
            img.image = UIImage(named: "iconProduct")
        }
        lbName.numberOfLines = 2
        lbPrice.layer.borderWidth = 1
        lbPrice.layer.borderColor = CGColor(srgbRed: 237/255, green: 157/255, blue: 38/255, alpha: 1)
        lbPrice.layer.cornerRadius = 3
        
        img.layer.cornerRadius = 10
        img.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 1, alpha: 0.7)
        img.layer.borderWidth = 1
        

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        Current.shared.CurrentProduct = p
        
    }
    
}
