//
//  LiverServerTest.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/17/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import XCTest
@testable import TKAssignment
class LiverServerTest: XCTestCase
{
    
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
    
    func testNotNilProductList()
    {
        let server                      =   MockLiveServer()
        server.shouldProvideProductList =   true
        
        server.products(from: 0, count: 10) { (products) in
            
            XCTAssertNotNil(products)
        }
    }
    
    func testNilProductList()
    {
        let server                           =   MockLiveServer()
        server.shouldProvideNilProductList  =   true
        
        server.products(from: 0, count: 10) { (products) in
            XCTAssertNil(products)
        }
    }
}
