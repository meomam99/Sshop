//
//  SearchViewController.swift
//  MockAppDemo
//
//  Created by mac on 7/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfResult
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductCell
        cell.lbName.text = productsSearch[indexPath.row].name
        cell.lbPrice.text = Contants.shared.showPrice(price:(Int) (productsSearch[indexPath.row].variants[0].variant_retail_price))
        cell.p = productsSearch[indexPath.row]
        return cell
    }
    
    var result: ResultSearch!
    var productsSearch = [Product]()
    var numberOfResult = 0
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var lbResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProduct()
        btnAdd.layer.cornerRadius = 10
        updateNode()
        updateView()
    }

    
    func getAllProduct() {
        
        
           }
    
    func updateNode() {
        lbResult.text = "Có \(numberOfResult) kết quả phù hợp với '\(Current.shared.currentKeyWord)'"
    }
    
    func updateView() {
        updateNode()
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.reloadData()
    }
       
}
