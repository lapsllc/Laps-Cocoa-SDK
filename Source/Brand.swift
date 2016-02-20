
// Copyright (c) 2016 The Digital Warehouse (http://www.thedigitalwarehouse.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import CoreGraphics
import Alamofire
import SwiftyJSON

public class Brand : PersistentContext {
    //  Identity
    var name: String
    
    var _colors: [Color]
    var products: [Product]?
    
    var information: String?
    
    init(identifier: String, name: String, _colors: [Color], products: [Product]?, information: String? = nil) {
        self.name = name
        self._colors = _colors
        self.products = products
        self.information = information
        
        super.init(identifier: identifier)
    }
    
    static private func parse(json: JSON) -> Brand {
        //  Assign the real database identifier to the object.
        let identifier = json["_id"].stringValue
        let name = json["name"].stringValue
        
        var popularProducts = [Product]()
        
        for eachObject in json["popularProducts"] {
            //  Create products and assign them.
        }
        
        var colors = [Color]()
        
        if let colorArray = json["colors"].array {
            colors = colorArray.map() { object in
                return Color(
                    red: object["red"].floatValue / 256,
                    green: object["green"].floatValue / 256,
                    blue: object["blue"].floatValue / 256,
                    alpha: object["alpha"].float != nil ? object["alpha"].float!:256 / 256)
            }
        }
        
        //  Create brand object with collected information.
        let brand = Brand(identifier: identifier, name: name, _colors: colors, products: popularProducts)
        
        //  Assign
        brand.information = json["description"].string
        
        return brand
    }
    
    static private var fetchDates = [String: NSDate]()
    
    //  MARK: - Web Service Outlets
    
    public enum FeedError : ErrorType {
        case UnexpectedLimitValue(limit: UInt)
        case NoPreviousFetch
    }
    
    /**
     Fetches brand feed from the web service.
     - parameter limit: The limit of quantity of brands fetched. The default value is 8, which is the highest value. If higher value is given, this will throw an exception. *optional*
     - parameter offset: The offset of quantity of brands fetched. This is likely used in pagination. If no value is given, no objects will be skipped. *optional*
     - parameter callback: The callback of the asynchronous operation.
     */
    static public func feed(limit limit: UInt = 8, offset: UInt = 0, callback: ([Brand]?, NSError?) -> Void) throws {
        var parameters = [String : String]()
        
        //  The user is not an admin, give a referrer.
        parameters["ref"] = "latest"
        
        //  Pagination Control
        guard offset == 0 || fetchDates["feed"] != nil else {
            //  There was no previous fetch.
            throw FeedError.NoPreviousFetch
        }
        
        //  Set offset
        if offset == 0 {
            //  Set the lastFetched to the date, because it is a refresh.
            fetchDates["feed"] = NSDate()
        } else {
            //  Set the after parameter to the date stored, because it is a pagination
            //  The date will be in the form of "2016-02-20 18:34:19 +0000".
            parameters["after"] = fetchDates.description
        }
        
        parameters["offset"] = String(offset)
        
        //  Set limit
        guard limit <= 8 else {
            throw FeedError.UnexpectedLimitValue(limit: limit)
        }
        
        parameters["limit"] = String(limit)
        
        //  Fire the HTTP request to the web server.
        Alamofire.request(.GET, "http://localhost:9000/api/brands", parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        //  Map them into objects.
                        var brands = [Brand]()
                        
                        if let array = JSON(value).array {
                            for eachBrandJSON in array {
                                brands.append(parse(eachBrandJSON))
                            }
                            
                            callback(brands, nil)
                        } else {
                            //  Response have no payload.
                            callback(nil, NSError(domain: "LapsKit", code: 100, userInfo: ["description": "Malformed JSON"]))
                        }
                    }
                case .Failure(let error):
                    //  Oops, there was an error.
                    callback(nil, error)
                }
        }
    }
    
    public func products(callback: (Brand?, NSError?) -> Void) {
        var parameters = [String : String]()
        
        parameters["brand"] = identifier
        
        Alamofire.request(.GET, "http://localhost:9000/api/products", parameters: parameters)
    }
    
    override func synchronize() {
        //  refetch json.
    }
}



















