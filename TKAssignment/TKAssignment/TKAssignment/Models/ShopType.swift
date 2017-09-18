//
//  ShopType.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import Foundation

enum ShopType
{
    case GoldMerchant
    case OfficialStore
    
    var title:String {
        switch (self)
        {
            case .GoldMerchant:
                return NSLocalizedString("Gold Merchant", comment: "Gold Merchant")
            case .OfficialStore:
                return NSLocalizedString("Official Store", comment: "Official Store")
        }
    }
    
    init?(raw: Int) {
        switch raw
        {
            case 0: self    =   .GoldMerchant
            case 1: self    =   .OfficialStore
            default: self   =   .GoldMerchant
        }
    }
}
