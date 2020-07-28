//
//  AddProductViewController.swift
//  MockAppDemo
//
//  Created by mac on 7/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {
    
    var name: String = ""
    var productToAdd = ProductToAdd(product: ProductField(name: ""))
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        btnAdd.layer.cornerRadius = 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if txtName.text != nil {
            self.name = txtName.text!
            self.productToAdd.product.name = self.name
            addProduct()
        }
        txtName.text = ""
        
    }
    
    func addProduct() {
        
        let source = "https://interndev.mysapo.vn/admin/products.json"
        guard let url = URL(string: source) else {
            print("Error building URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("919b6923dae8421cfda6dffdc5a669f7", forHTTPHeaderField:"X-Sapo-SessionId")
        request.setValue("314486", forHTTPHeaderField: "X-Sapo-LocationId")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let jsonProduct = try? JSONEncoder().encode(self.productToAdd) else {
            print("Error on encode")
            return
        }
        request.httpBody = jsonProduct
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonProduct) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            DispatchQueue.main.async {
                if let res = response  as? HTTPURLResponse  {
                    
                    if res.statusCode == 201 {
                        self.showMessage(true)
                    } else {
                        self.showMessage(false)
                    }
                }
            }
        }
        task.resume()
    }

    func  showMessage(_ state: Bool) {
        var mess = "Có lỗi xảy ra, hãy thử lại sau !"
        if state {
            mess = "Đã thêm \(self.name) !"
        }
        
        let alert: UIAlertController = UIAlertController(title: "Thông báo", message: mess, preferredStyle: .alert)
         let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (btn) in
         }
         
         alert.addAction(btnOK)
         present(alert, animated: true, completion: nil)
        
    }
    
}


