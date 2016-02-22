
// Copyright (c) 2016 Laps Foundation
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
import Alamofire
import SwiftyJSON

/**
 A delegate class to observe the authentication session.
 */
public protocol AuthenticationSessionDelegate {
    /**
     A protocol method dispatched when authentication is completed.
     - parameter user: The user object retrieved if authentication is completed with success.
     - parameter error: The error object created during authentication session. See more on **Alamofire** error handling.
     */
    func didFinishAuthenticating(user: User?, error: NSError?)
}

public class AuthenticationSession {
    /**
     A delegate object to observe session.
     */
    public var delegate: AuthenticationSessionDelegate?
    
    /**
     Challenges access token taken from social media APIs to the web service.
     - parameter accessToken: A JWT or Base64 encoded string access token retrieved previously from a social media API.
     */
    public func challenge(accessToken: String) {
        Alamofire.request(.POST, "http://54.93.111.103:8080" + "/auth/", parameters: [ "accessToken": accessToken ], encoding: .URL)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        let user = User(identifier: json["_id"].string!)
                        
                        user.name = json["profile"]["name"].string
                        user.surname = json["profile"]["surname"].string
                        user.middleName = json["profile"]["middleName"].string
                        user.nickname = json["profile"]["nickname"].string
                        
                        user.age = json["profile"]["age"].uInt
                        
                        if let isMale = json["profile"]["gender"].bool {
                            user.gender = isMale ? .Male:.Female
                        }
                        
                        //  TODO: user.image should be mapped
                        
                        self.delegate!.didFinishAuthenticating(user, error: nil)
                    } else {
                        self.delegate!.didFinishAuthenticating(nil, error: NSError(domain: NSCocoaErrorDomain, code: 100, userInfo: [ "description": "Server successfully responded but there was no payload." ]))
                    }
                case .Failure(let error):
                    self.delegate!.didFinishAuthenticating(nil, error: error)
                }
        }
    }
}