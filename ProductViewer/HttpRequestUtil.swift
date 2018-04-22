//
//  httpRequest.swift
//  ProductViewer
//  Generic http requestion utility class implementing basic REST operations.
//
//  Created by Terry Yan on 4/20/18.
//  Copyright © 2018 Terry Yan. All rights reserved.
//

import Foundation
import UIKit

class HttpRequestUtil {
    
    static func makeGETRequest(url: URL, completionHandler: @escaping (([String: Any]!) -> Void)) -> Void {
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) { (data, response, error) -> Void in
            guard error == nil else {
                print("Error: GET request failed")
                return completionHandler(nil)
            }
            guard let responseData = data else {
                print("Error: GET did not receive data")
                return completionHandler(nil)
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        return completionHandler(nil)
                }
                return completionHandler(json as [String: Any]!)
            } catch {
                print("Error: can not convert data to JSON")
                return completionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    static func retrievePicture(url: URL, completionHandler: @escaping ((UIImage!) -> Void)) -> Void {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                print("getting picture...")
                return completionHandler(UIImage(data: data!))
            }
        }
    }

}
