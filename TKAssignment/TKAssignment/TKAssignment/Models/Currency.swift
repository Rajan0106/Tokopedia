//
//  Currency.swift
//  TKAssignment
//
//  Created by Sanyal, Suman on 9/17/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import SwiftyJSON

class Currency : NSObject
{
    let defaultSymbol = "Rp"
    let defaultValue = Double(0)
    
    var value: Double
    var symbol: String
    
    override init() {
        value = defaultValue
        symbol = defaultSymbol
    }
    
    convenience init(value: Double) {
        self.init()
        self.value = value
    }
    
    convenience init(string: String) {
        self.init()
        
        let tokens = string.components(separatedBy: " ")
        symbol = tokens[0]
        
        var valueSpec = tokens[1]
        if let lastIndexOfDot = valueSpec.range(of: ".", options: .backwards)?.lowerBound {
            valueSpec = valueSpec.substring(to: lastIndexOfDot).replacingOccurrences(of: ".", with: "")
        }
        value = Double(valueSpec) ?? Double(0)
    }
    
    override var description: String {
        return "\(symbol) \(String(format: "%.3f", value))"
    }
}

extension Currency : Comparable
{
    public static func <(lhs: Currency, rhs: Currency) -> Bool
    {
        return lhs.value < rhs.value
    }
}
