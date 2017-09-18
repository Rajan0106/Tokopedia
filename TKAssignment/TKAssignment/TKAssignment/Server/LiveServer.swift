//
//  LiveServer.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/16/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LiveServer : Server
{
    func products(from start: Int,
                  count rows: Int,
                  filter: Filter,
                  completion onComplete: @escaping ProductListCompletionHandler)
    {
        var parameters: [String: Any] = [
            "q": kProduct,
            "start": start,
            "rows": rows
        ]
        
        if !filter.allowAll
        {
            parameters["pmin"]      =   filter.priceRange.lowerBound
            parameters["pmax"]      =   filter.priceRange.upperBound
            parameters["wholesale"] =   filter.isWholesaleOnly
            parameters["official"]  =   filter.isOfficialStoreOnly
            if filter.isGoldMerchantOnly
            {
                parameters["fshop"] =   2
            }
        }
        
        Alamofire.request(kSearchProductURL,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON(queue: DispatchQueue.global(qos: .userInitiated), options: []) { response in
                guard response.result.isSuccess, let result = response.result.value else {
                    DispatchQueue.main.async {
                        onComplete(nil)
                    }
                    return
                }
                
                let resultJson = JSON(result)
                guard let data = resultJson["data"].array else {
                    DispatchQueue.main.async {
                        onComplete(nil)
                    }
                    return
                }
                
                var products = [Product]()
                data.forEach({ (productJson) in
                    products.append(Product(json: productJson))
                })
                
                DispatchQueue.main.async {
                    onComplete(products)
                }
        }
    }
}
