//
//  MockLiveServer.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/17/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import Foundation

class MockLiveServer: Server
{
    var shouldProvideProductList:Bool       =   false
    var shouldProvideNilProductList:Bool    =   false
    
    func products(from _: Int, count rows: Int, filter: Filter, completion onComplete: @escaping ([Product]?) -> Void)
    {
        if shouldProvideProductList == true
        {
            onComplete(self.getMockedProductList())
        }
        else if shouldProvideNilProductList == true
        {
            onComplete(nil)
        }
    }
    
    func getMockedProductList() -> [Product]
    {
        let p1                  =   Product()
        p1.name                 =   "Ultrathin Softcase Samsung J1 / ultra thin soft case jely"
        p1.thumbnailUri         =   URL(string: "https://ecs7.tokopedia.net/img/cache/200-square/product-1/2016/8/17/9670946/9670946_b6fd4b9d-035f-4677-a825-82703ba33520.jpg")
        p1.price?.value         =   54.0
        
        let p2                  =   Product()
        p2.name                 =   "Ultrathin Softcase Samsung J1 / ultra thin soft case jely"
        p2.thumbnailUri         =   URL(string: "https://ecs7.tokopedia.net/img/cache/200-square/product-1/2016/8/17/9670946/9670946_b6fd4b9d-035f-4677-a825-82703ba33520.jpg")
        p2.price?.value         =   64.0
        
        let p3                  =   Product()
        p3.name                 =   "Ultrathin Softcase Samsung J1 / ultra thin soft case jely"
        p3.thumbnailUri         =   URL(string: "https://ecs7.tokopedia.net/img/cache/200-square/product-1/2016/8/17/9670946/9670946_b6fd4b9d-035f-4677-a825-82703ba33520.jpg")
        p3.price?.value         =   74.0
        
        let p4                  =   Product()
        p4.name                 =   "Ultrathin Softcase Samsung J1 / ultra thin soft case jely"
        p4.thumbnailUri         =   URL(string: "https://ecs7.tokopedia.net/img/cache/200-square/product-1/2016/8/17/9670946/9670946_b6fd4b9d-035f-4677-a825-82703ba33520.jpg")
        p4.price?.value         =   84.0
        
        return [p1, p2, p3, p4]
    }
}
