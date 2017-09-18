//
//  Product.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import SwiftyJSON

class Product
{
    var id: Int64?
    var name: String?
    var uri: URL?
    var thumbnailUri: URL?
    var fullImageUri: URL?
    var price: Currency?
    var shop: Shop?
    var wholesales: [Wholesale]?
    var condition: Int?
    var isPreorder: Bool?
    var departmentId: Int64?
    var labels: [Label]?
    var badges: [Badge]?
    var originalPrice: Currency?
    var hasDiscountExpired: Bool?
    var discountPercentage: Double?
    
    init() {
        
    }
    
    init(json: JSON) {
        id = json["id"].int64
        name = json["name"].string
        uri = json["uri"].url
        thumbnailUri = json["image_uri"].url
        fullImageUri = json["image_uri_700"].url
        
        if let priceSpec = json["price"].string {
            price = Currency(string: priceSpec)
        }
        
        shop = Shop(json: json["shop"])
        
        wholesales = [Wholesale]()
        if let wholesaleJsonArray = json["wholesale_price"].array {
            wholesaleJsonArray.forEach({ (wholesaleJson) in
                wholesales?.append(Wholesale(json: wholesaleJson))
            })
        }
        
        condition = json["condition"].int
        isPreorder = json["preorder"].int != 0
        departmentId = json["department_id"].int64
        
        labels = [Label]()
        if let labelJsonArray = json["labels"].array {
            labelJsonArray.forEach({ (labelJson) in
                labels?.append(Label(json: labelJson))
            })
        }
        
        badges = [Badge]()
        if let badgeJsonArray = json["badges"].array {
            badgeJsonArray.forEach({ (badgeJson) in
                badges?.append(Badge(json: badgeJson))
            })
        }
        
        if let priceSpec = json["original_price"].string {
            originalPrice = Currency(string: priceSpec)
        }
        
        hasDiscountExpired = json["discount_expired"].int != 0
        discountPercentage = json["discount_percentage"].double
   }
}
