//
//  CurrencyTest.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/17/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import XCTest
@testable import TKAssignment
class CurrencyTest: XCTestCase {
    
    //This method is called before the invocation of each test method in the class.
    override func setUp()
    {
        super.setUp()
    }
    
    //This method is called after the invocation of each test method in the class.
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testCurrencyDescriptionForValidInput()
    {
        let currency:Currency   =   Currency()
        currency.symbol         =   "Rp"
        currency.value          =   5.0
        
        let expectedDescription =   "Rp 5.000"
        XCTAssertEqual(currency.description.lowercased(), expectedDescription.lowercased() )
        
    }
    
    func testCurrencyDescriptionForInvalidInput()
    {
        let currency:Currency   =   Currency()
        
        let expectedDescription =   "Rp 0.000"
        XCTAssertEqual(currency.description.lowercased(), expectedDescription.lowercased() )
    }
    
    func testCurrencyValueFromGivenDiscription()
    {
        let currency:Currency   =   Currency(string:"Rp 5.000")
        let expectedValue       =   5.000
        
        if let currencyValue = currency.value
        {
            XCTAssertLessThanOrEqual (currencyValue, expectedValue)
        }
    }
    
    func testCurrencySymbolFromGivenDiscription()
    {
        let currency:Currency   =   Currency(string:"Rp 5.000")
        let expectedSymbol      =   "Rp"
        
        if let currencySymbol = currency.symbol
        {
            XCTAssertEqual(currencySymbol.lowercased(), expectedSymbol.lowercased() )
        }
    }
    
}
