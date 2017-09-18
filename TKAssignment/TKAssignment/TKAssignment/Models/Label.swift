//
//  Label.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import SwiftyJSON

class Label
{
    var title: String?
    var color: String?
    
    init(json: JSON) {
        title = json["title"].string
        color = json["color"].string
    }
}
