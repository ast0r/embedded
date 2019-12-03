//
//  RequestFabric.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

let serverHost = "reqres.in"
let serverPath = "/api/users/"

class RequestFabric {
    
    class func getUserUrl(itemCount: String) -> URL? {
        
        let params = ["per_page" : itemCount]
        var components = URLComponents()
        components.scheme = "https"
        components.host = serverHost
        components.path = serverPath
        components.queryItems = params.map {
            URLQueryItem(name: $0, value: $1 as String)
        }
        
        return components.url
    }
}
