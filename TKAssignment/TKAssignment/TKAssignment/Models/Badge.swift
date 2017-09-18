//
//  Badge.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import SwiftyJSON

class Badge
{
    var title: String?
    var imageUrl: URL?
    
    init(json: JSON) {
        title = json["title"].string
        imageUrl = json["image_url"].url
    }
}
