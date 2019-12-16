//
//  FetchData.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/2/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

//MARK: - Get data From Network
class FetchData {
    class func fetch(completion: @escaping(ItemModel)->()) {        
        guard let url = RequestFabric.getUserUrl(itemCount: "12") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            guard let users = try? JSONDecoder().decode(ItemModel.self, from: data) else { return }
            completion(users)            
        }
        task.resume()
    }
}
