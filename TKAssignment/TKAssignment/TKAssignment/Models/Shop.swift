//
//  Shop.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import SwiftyJSON

class Shop
{
    var id: Int64?
    var name: String?
    var uri: URL?
    var isGold: Bool?
    var rating: Double?
    var location: String?
    var reputationImageUri: URL?
    var luckyShopUri: URL?
    var city: String?
    
    init(json: JSON) {
        id = json["id"].int64
        name = json["name"].string
        uri = json["uri"].url
        isGold = json["is_gold"] != 0
        rating = json["rating"].double // TODO: Always null - check if used
        location = json["location"].string
        reputationImageUri = json["reputation_image_uri"].url
        luckyShopUri = json["shop_lucky"].url
        city = json["city"].string
    }
}
