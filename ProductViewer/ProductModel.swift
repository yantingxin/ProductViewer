//
//  ProductModel.swift
//  ProductViewer
//
//  Created by Terry Yan on 4/21/18.
//  Copyright © 2018 Terry Yan. All rights reserved.
//

import UIKit

extension String {
    var htmlToAttributedText: NSAttributedString? {
        guard let data = data(using: .utf16) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
}

extension Double {
    func format(format: String) -> String {
        return String(format: "%\(format)f", self)
    }
}

var brightBlue = UIColor(red:0.10, green:0.78, blue:0.85, alpha:1.0)

class ProductModel {
    let rootUrl = "https://mobile-tha-server.appspot.com"
    let path = "walmartproducts"
    let noDescString = "<p>no description</p>"
    
    let batchSize = 3
    let pageSize  = 15  // max = 30
    
    var currentPage = 1
    var totalPages :Int?
    
    
    private func makeGETRequest(url: URL, completionHandler: @escaping (([Product])!) -> Void) -> Void {
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
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    return completionHandler(nil)
                }
                self.parseProduct(data: json as [String: Any]!, completionHandler: completionHandler)
            } catch {
                print("Error: can not convert data to JSON")
                return completionHandler(nil)
            }
        }
        task.resume()
    }
    
    public func fetchImage(url: URL, index: Int, completionHandler: @escaping ((Int, UIImage?) -> Void)) -> Void {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                let image :UIImage? = UIImage(data: data!)
                return completionHandler(index, image)
            }
        }
    }
    
    private func parseProduct(data: [String: Any]!, completionHandler: @escaping (([Product])!) -> Void) -> Void {
        if self.totalPages == nil {
            self.totalPages = setTotalPages(total: data["totalProducts"] as! Int, size: self.pageSize)
            print("total pages = \(self.totalPages!)")
        }
        
        let products:[[String: Any]] = data["products"] as! [[String: Any]]
        var productArray = [Product]()
        
        for product in products {
            let id = product["productId"] as! String
            let name  = product["productName"] as! String
            let price = parsePrice(raw: product["price"] as! String)!
            let imageUrl = generateImageUrl(imageUrl: product["productImage"] as! String)
            let rating = product["reviewRating"] as! Double
            let count = product["reviewCount"] as! Int
            let status = product["inStock"] as! Bool
            var shortDesc = noDescString
            if product["shortDescription"] != nil {
                shortDesc = (product["shortDescription"] as! String)//.htmlToAttributedText
            }
            var longDesc = noDescString
            if product["longDescription"] != nil {
                longDesc = (product["longDescription"] as! String)//.htmlToAttributedText
            }
        
            let newProduct = Product(id: id, name: name, status: status, price: price, review: rating, reviewCount: count, shortDesc: shortDesc, longDesc: longDesc, imageUrl: imageUrl)
            productArray.append(newProduct)
        }
        completionHandler(productArray)
        self.currentPage += 1;
        if self.currentPage < self.totalPages! {
            self.fetchProduct(completionHandler: completionHandler) // keep fetching product info.
        }
    }
   
    // fetch 2 pages at a time.
    public func fetchProduct(completionHandler: @escaping (([Product])!) -> Void) -> Void {
        let url = generateProductUrl()
        self.makeGETRequest(url: url, completionHandler: completionHandler)
    }
    
    /* --- private utility functions --- */
    
    private func generateProductUrl() -> URL{
        return URL(string: String("\(rootUrl)/\(path)/\(currentPage)/\(pageSize)"))!
    }
    
    private func generateImageUrl(imageUrl: String) -> URL{
        return URL(string: String("\(rootUrl)\(imageUrl)"))!
    }
    
    private func setTotalPages(total: Int, size: Int) -> Int {
        return Int(ceil(Double(total) / Double(size)))
    }
    
    private func parsePrice(raw: String) -> Double? {
        return Double(raw.replacingOccurrences(of: ",", with: "").dropFirst())
    }
}
