
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
    
    var DBdescription: String?
    
    init(identifier: String, name: String, _colors: [Color], products: [Product]?) {
        self.name = name
        self._colors = _colors
        self.products = products
        
        super.init(identifier: identifier)
    }
    
    static private func parse(json: JSON) -> Brand {
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
        
        let brand = Brand(identifier: identifier, name: name, _colors: colors, products: popularProducts)
        
        brand.DBdescription = json["description"].string
        
        return brand
    }
    
    static public func feed(limit: Int? = nil, offset: Int? = nil, callback: ([Brand]?, NSError?) -> Void) {
        var params = [String : String]()
        
        params["ref"] = "latest"
        
        func load(param: Int?, var into dictionary: [String: String], key: String, fallback: Int) {
            if let paramValue = param {
                dictionary[key] = String(paramValue)
            } else {
                dictionary[key] = String(fallback)
            }
        }
        
        load(limit, into: params, key: "limit", fallback: 8)
        load(offset, into: params, key: "offset", fallback: 0)
        
        if let limitValue = limit {
            params["limit"] = String(limitValue)
        }
        
        if let offsetValue = offset {
            params["offset"] = String(offsetValue)
        }
        
        Alamofire.request(.GET, "http://localhost:9000/api/brands", parameters: params)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        var brands = [Brand]()
                        
                        if let array = JSON(value).array {
                            for eachBrandJSON in array {
                                brands.append(parse(eachBrandJSON))
                            }
                            
                            callback(brands, nil)
                        } else {
                            callback(nil, NSError(domain: "LapsKit", code: 100, userInfo: ["description": "Malformed JSON"]))
                        }
                    }
                case .Failure(let error):
                    callback(nil, error)
                }
        }
    }
    
//    static public func show(callback: (Brand?, NSError?) -> Void) {
//        Alamofire.request(.GET, "http://localhost:9000/api/brands")
//            .responseJSON { response in
//                switch response.result {
//                case .Success:
//                    if let value = response.result.value {
//                        callback(parse(JSON(value)), nil)
//                    }
//                case .Failure(let error):
//                    callback(nil, error)
//                }
//        }
//    }
    
    override func synchronize() {
        //  refetch json.
    }
}



















