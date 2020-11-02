//
//  NetworkService.swift
//  News
//
//  Created by Diana Agapkina on 10/30/20.
//

import Foundation

class NetworkService {
    
    func getDataFromRequest(_ request: URLRequest, callback: @escaping (_ data: Data?, _ error: NSError?) -> ()) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            callback(data, error as NSError?)
        }
        
        dataTask.resume()
    }
    
}
