
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
    let name: String
    let _colors: [[Float]]
    let products: [Product]?
    
    var DBdescription: String?
    
    init(identifier: String, name: String, _colors: [[Float]], products: [Product]?) {
        self.name = name
        self._colors = _colors
        self.products = products
        
        super.init(identifier: identifier)
    }
    
    private static func parse(json: JSON) -> Brand {
        let identifier = json["_id"].stringValue
        
        let name = json["name"].stringValue
        
        var popularProducts = [Product]()
        
        for eachObject in json["popularProducts"] {
            //  Create products and assign them.
        }
        
        var colors = [[Float]]()
        
        if let colorArray = json["colors"].array {
            for eachObject in colorArray {
                var floats = [Float]()
                
                floats.append(eachObject["red"].floatValue / 256)
                floats.append(eachObject["green"].floatValue / 256)
                floats.append(eachObject["blue"].floatValue / 256)
                
                colors.append(floats)
            }
        }
        
        let brand = Brand(identifier: identifier, name: name, _colors: colors, products: popularProducts)
        
        brand.DBdescription = json["description"].string
        
        return brand
    }
    
    static public func index(callback: ([Brand]?, NSError?) -> Void) {
        Alamofire.request(.GET, "http://localhost:9000/api/brands")
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
    
    static public func show(callback: (Brand?, NSError?) -> Void) {
        Alamofire.request(.GET, "http://localhost:9000/api/brands")
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        callback(parse(JSON(value)), nil)
                    }
                case .Failure(let error):
                    callback(nil, error)
                }
        }
    }
    
    override func synchronize() {
        //  refetch json.
    }
}



















