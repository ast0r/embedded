//
//  ItemModel.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

struct ItemModel:Decodable {
    
    let data: [User]
}

class User:Decodable {
    
    var id: Int?
    var email: String?
    var first_name: String?
    var last_name: String?
    var avatar: String?
}
