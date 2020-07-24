//
//  ViewController.swift
//  MockAppDemo
//
//  Created by mac on 7/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var result: Result = Result(products: [])
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var productTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return result.products.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
 
        let p = self.result.products[indexPath.row]
        cell.p = p
        
        cell.lbPrice.text = Contants.shared.showPrice(price: (Int) (p.variants[0].variant_retail_price))
        cell.lbName.text = "\(p.name)"
        if(p.images.count != 0) {
           let url = URL(string: p.images[0].full_path)!
            Contants.shared.setImageFromInternet(img: cell.img, url: url)
        } else {
            cell.img.image = UIImage(named: "iconProduct")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.5
        UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProduct()
     //   dismisKeyboard()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func update(_ sender: Any) {
            getAllProduct()
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
        txtSearch.resignFirstResponder()
        if txtSearch.text != nil {
            Current.shared.currentKeyWord = txtSearch.text!
        }
    }
    
    
    
    func dismisKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func updateView() {
        
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.reloadData()
    }
    
    func getAllProduct() {
        
        let session = URLSession(configuration: .default)
        let source = "https://interndev.mysapo.vn/admin/products.json"
        guard let url = URL(string: source) else {
                   print("Error building URL")
                   return
               }
               
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue( "919b6923dae8421cfda6dffdc5a669f7", forHTTPHeaderField:"X-Sapo-SessionId")

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
                            self.result = try JSONDecoder().decode(Result.self, from: data)
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
    
    var p = Product(name: "", description: "", options: [], images: [], variants: [])
    
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
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
