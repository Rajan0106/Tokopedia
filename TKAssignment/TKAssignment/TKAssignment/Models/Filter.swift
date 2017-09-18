//
//  Filter.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import Foundation

class Filter : NSObject
{
    static let kTitleIsGoldMerchant    =   NSLocalizedString("Gold Merchant", comment: "Gold Merchant")
    static let kTitleIsOfficialStore   =   NSLocalizedString("Official Store", comment: "Official Store")
    
    var priceRange = Range<Double>(uncheckedBounds: (100.0, 10000.0)) {
        didSet {
            allowAll    =   false
        }
    }
    var isWholesaleOnly = false {
        didSet {
            allowAll    =   false
        }
    }
    var isGoldMerchantOnly = false {
        didSet {
            allowAll    =   false
        }
    }
    var isOfficialStoreOnly = false {
        didSet {
            allowAll    =   false
        }
    }
    
    var allowAll        =   true
    
    func clear()
    {
        priceRange          =   Range<Double>(uncheckedBounds: (100.0, 10000.0))
        isWholesaleOnly     =   false
        isGoldMerchantOnly  =   false
        isOfficialStoreOnly =   false
        allowAll = true
    }
}

extension Filter: NSMutableCopying
{
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let copy                    =   Filter()
        copy.allowAll               =   self.allowAll
        copy.priceRange             =   self.priceRange
        copy.isWholesaleOnly        =   self.isWholesaleOnly
        copy.isGoldMerchantOnly     =   self.isGoldMerchantOnly
        copy.isOfficialStoreOnly    =   self.isOfficialStoreOnly
        return copy
    }
}
