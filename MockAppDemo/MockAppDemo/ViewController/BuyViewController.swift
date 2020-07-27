//
//  BuyViewController.swift
//  MockAppDemo
//
//  Created by mac on 7/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var p: Product = Current.shared.CurrentProduct
    var quantity: Int = 1
    var price: Int = 0
    var options = [Option(name: "", values: [])]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == self.pvOption1) {
            return options[0].values.count
        } else {
            return options[1].values.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == self.pvOption1) {
            return options[0].values[row]
        } else {
            return options[1].values[row]
        }
    }
    
    
    @IBOutlet weak var pvOption2: UIPickerView!
    @IBOutlet weak var lbOption2: UILabel!
    @IBOutlet weak var pvOption1: UIPickerView!
    @IBOutlet weak var lbOption1: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var stpQuantity: UIStepper!
    @IBOutlet weak var btnOK: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPickerView()
        setupNode()
        setupPrice()
        showQuantity()
        
    }
    
    func setPickerView() {
        pvOption1.dataSource = self
        pvOption1.delegate = self
        options = p.options
        lbOption1.text = options[0].name
        if options.count > 1 {
            lbOption2.text = options[1].name
            pvOption2.dataSource = self
            pvOption2.delegate = self
        }
    }
    
    func showQuantity() {
        lbQuantity.text = " \(quantity) "
        if(quantity < 5) {
            lbPrice.text = p.getPriceInString(mode: 1)
        } else {
            lbPrice.text = p.getPriceInString(mode: 2)
        }
    }
    
    func setupPrice() {
        if(quantity < 5) {
            price = (Int) (p.variants[0].variant_retail_price)
        } else {
            price = (Int) (p.variants[0].variant_whole_price)
        }
    }
    
    @IBAction func btnOKTapped(_ sender: Any) {
        
        Cart.shared.add(p: p, quantity: quantity, price: price)
        
        let alert: UIAlertController = UIAlertController(title: "Xin cảm ơn", message: "Đã thêm \(p.name) vào giỏ hàng !", preferredStyle: .alert)
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (btn) in
        }
        
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
    
    func setupNode() {
        lbName.text = p.name
        if(p.images.count != 0) {
            self.img.setImageFromInternet(urlString: p.images[0].full_path)
        }
        
        btnOK.layer.cornerRadius = 10
        stpQuantity.wraps = true
        stpQuantity.autorepeat = true
        stpQuantity.minimumValue = 1
        stpQuantity.maximumValue = 50
    }
    
    @IBAction func stpQuantityChanged(_ sender: UIStepper) {
        quantity = Int(sender.value)
        
        setupPrice()
        showQuantity()
    }
    
    
}
