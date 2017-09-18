//
//  Wholesale.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import SwiftyJSON

class Wholesale
{
    var countRange: ClosedRange<Int>?
    var price: Currency?
    
    init(json: JSON) {
        if let minCount = json["count_min"].int,
            let maxCount = json["count_max"].int {
            countRange = ClosedRange<Int>(uncheckedBounds: (minCount, maxCount))
        }
        if let priceSpec = json["price"].string {
            price = Currency(string: priceSpec)
        }
    }
}
