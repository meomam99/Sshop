//
//  File.swift
//  MockAppDemo
//
//  Created by mac on 7/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class Contants {
    static let shared = Contants()
}

extension Contants {
    func setImageFromInternet(img: UIImageView, url: URL) {
        
        let dataTask = URLSession.shared.dataTask(with: url) {  (data, _, _) in
                        if let data = data {
                            DispatchQueue.main.async {
                               img.image = UIImage(data: data)
                              
                            }
                        }
                    }
                  dataTask.resume()
    }
    
    func showPrice(price: Int)-> String {
        
        var p: String = ""
        for i in 0..<"\(price)".count  {
               
            if(i != 0 && i%3 == 0) {
                p.append(".")
            }
            
             p.append("\(price)".reversed()[i])
        }
        let rs: String = (String) (p.reversed())
        return " \(rs) đ "
    }
    
}

/*
 
 {
     "id": 25545815,
     "tenant_id": 308781,
     "created_on": "2020-06-14T02:58:52Z",
     "modified_on": "2020-07-14T03:00:37Z",
     "status": "active",
     "brand": null,
     "description": "- Thành phần: Bơ, đường, trứng, bột mì\n\n- Trọng lượng: 300g \n\n- Xuất xứ: Việt Nam \n\n- Sản phẩm dùng ăn liền\n\n- Bảo quản nơi khô ráo, thoáng mát",
     "image_path": null,
     "image_name": null,
     "name": "Bánh sampa (champagne) Hoàng Mỹ Gia 300g",
     "opt1": "Kích thước",
     "opt2": null,
     "opt3": null,
     "category_id": 715999,
     "category": "Đồ ăn",
     "category_code": "PGN00002",
     "tags": "",
     "product_type": "normal",
     "variants": [
         {
             "id": 38689611,
             "tenant_id": 308781,
             "location_id": 314486,
             "created_on": "2020-06-14T02:58:52Z",
             "modified_on": "2020-07-14T03:00:37Z",
             "category_id": 715999,
             "brand_id": null,
             "product_id": 25545815,
             "composite": false,
             "init_price": 0.000,
             "init_stock": 0.000,
             "variant_retail_price": 32000.0000,
             "variant_whole_price": 25000.0000,
             "variant_import_price": 20000.0000,
             "image_id": 13402826,
             "description": null,
             "name": "Bánh sampa (champagne) Hoàng Mỹ Gia 300g",
             "opt1": "Mặc định",
             "opt2": null,
             "opt3": null,
             "product_name": "Bánh sampa (champagne) Hoàng Mỹ Gia 300g",
             "product_status": null,
             "status": "active",
             "sellable": true,
             "sku": "PVN05",
             "barcode": "NL01009",
             "taxable": true,
             "weight_value": null,
             "weight_unit": null,
             "unit": null,
             "packsize": false,
             "packsize_quantity": null,
             "packsize_root_id": null,
             "product_type": "normal",
             "variant_prices": [
                 {
                     "id": 123105776,
                     "value": 25000.0000,
                     "name": "Giá bán buôn",
                     "price_list_id": 939260,
                     "price_list": {
                         "id": 939260,
                         "tenant_id": 308781,
                         "created_on": "2020-07-14T02:58:52Z",
                         "modified_on": "2020-07-14T02:58:52Z",
                         "code": "BANBUON",
                         "currency_id": 308780,
                         "name": "Giá bán buôn",
                         "is_cost": false,
                         "currency_symbol": "đ",
                         "currency_iso": "VND",
                         "status": "active",
                         "init": true
                     }
                 },
                 {
                     "id": 123105777,
                     "value": 32000.0000,
                     "name": "Giá bán lẻ",
                     "price_list_id": 939262,
                     "price_list": {
                         "id": 939262,
                         "tenant_id": 308781,
                         "created_on": "2020-07-14T02:58:52Z",
                         "modified_on": "2020-07-14T02:58:52Z",
                         "code": "BANLE",
                         "currency_id": 308780,
                         "name": "Giá bán lẻ",
                         "is_cost": false,
                         "currency_symbol": "đ",
                         "currency_iso": "VND",
                         "status": "default",
                         "init": true
                     }
                 },
                 {
                     "id": 123105778,
                     "value": 20000.0000,
                     "name": "Giá nhập",
                     "price_list_id": 939261,
                     "price_list": {
                         "id": 939261,
                         "tenant_id": 308781,
                         "created_on": "2020-07-14T02:58:52Z",
                         "modified_on": "2020-07-14T02:58:52Z",
                         "code": "GIANHAP",
                         "currency_id": 308780,
                         "name": "Giá nhập",
                         "is_cost": true,
                         "currency_symbol": "đ",
                         "currency_iso": "VND",
                         "status": "default",
                         "init": true
                     }
                 }
             ],
             "inventories": [
                 {
                     "location_id": 314486,
                     "variant_id": 38689611,
                     "mac": 0.0000,
                     "amount": 0,
                     "on_hand": 194.0000,
                     "available": 194.0000,
                     "committed": 0.0000,
                     "incoming": 0.0000,
                     "onway": 0.0000,
                     "min_value": 0.0000,
                     "max_value": 0.0000,
                     "bin_location": null,
                     "wait_to_pack": 0.0000
                 }
             ],
             "images": [
                 {
                     "id": 13402826,
                     "size": 188977.0,
                     "created_on": "2020-07-14T03:00:37Z",
                     "modified_on": "2020-07-14T03:00:37Z",
                     "path": "100/308/781/variants/5f299170-153d-48d6-aee9-1737156372ef.jpg",
                     "full_path": "https://sapo.dktcdn.net/100/308/781/variants/5f299170-153d-48d6-aee9-1737156372ef.jpg",
                     "file_name": "5f299170-153d-48d6-aee9-1737156372ef.jpg",
                     "is_default": true,
                     "position": 1
                 }
             ],
             "composite_items": null,
             "warranty": false,
             "warranty_term_id": null
         }
     ],
     "options": [
         {
             "id": 25303938,
             "name": "Kích thước",
             "position": 1,
             "values": [
                 "Mặc định"
             ]
         }
     ],
     "images": [
         {
             "id": 13402826,
             "size": 188977.0,
             "created_on": "2020-07-14T03:00:37Z",
             "modified_on": "2020-07-14T03:00:37Z",
             "path": "100/308/781/variants/5f299170-153d-48d6-aee9-1737156372ef.jpg",
             "full_path": "https://sapo.dktcdn.net/100/308/781/variants/5f299170-153d-48d6-aee9-1737156372ef.jpg",
             "file_name": "5f299170-153d-48d6-aee9-1737156372ef.jpg",
             "position": 1
         }
     ]
 }
 */
