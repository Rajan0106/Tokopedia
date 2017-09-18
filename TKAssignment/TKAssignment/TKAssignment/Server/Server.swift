//
//  Server.swift
//  TKAssignment
//
//  Created by Sanyal, Suman on 9/16/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import Foundation

protocol Server
{
    func products(from _: Int, count rows: Int, filter: Filter, completion _: @escaping ([Product]?) -> Void)
}
