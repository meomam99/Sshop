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
    var state: Bool = false
    var productToAdd = ProductToAdd(product: ProductField(name: "Bánh rán"))
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lbMess: UILabel!
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
            
            if let res = response  as? HTTPURLResponse  {
                
                if res.statusCode == 201 {
                    self.updateState(true)
                } else {
                    self.updateState(false)
                }
            }
            
            
        }
        task.resume()
    }
        
    func updateState(_ state: Bool) {
        self.state = state
    }
    func  showMessage() {
            let alert: UIAlertController = UIAlertController(title: "Thành công", message: "Đã thêm thành công sản phẩm: \(self.name)", preferredStyle: .alert)
            let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (btn) in
                       
                       }
            
            alert.addAction(btnOK)
                      
            present(alert, animated: true, completion: nil)
                   
        }
       
}
    

