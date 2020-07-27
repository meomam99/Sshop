//
//  InfoViewController.swift
//  MockAppDemo
//
//  Created by mac on 7/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var p: Product = Current.shared.CurrentProduct
    
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var lbPrice2: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNode()
    }
    
    func setupNode() {
        lbName.text = p.name
        lbPrice.text = p.getPriceInString(mode: 1)
        lbPrice2.text = p.getPriceInString(mode: 2)
        lbDesc.text = p.getDescription()
        if(p.images.count != 0) {
            self.imgMain.setImageFromInternet(urlString: p.images[0].full_path)
        }
    }
    
    func setupView() {
        lbName.numberOfLines = 2
        lbPrice.layer.borderWidth = 1
        lbPrice.layer.borderColor = CGColor(srgbRed: 237/255, green: 157/255, blue: 38/255, alpha: 1)
        
        lbPrice2.layer.borderWidth = 1
        lbPrice2.layer.borderColor = CGColor(srgbRed: 219/255, green: 179/255, blue: 35/255, alpha: 1)
        
        lbDesc.numberOfLines = 10
        btnBuy.layer.cornerRadius = 10
    }


}
