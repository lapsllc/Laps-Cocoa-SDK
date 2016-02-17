
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

/**
 An abstract class referring to users of the application.
 - note: **Swift** does not handle abstract-typed classes, but in general, the instances of this class should be neither copied nor created.
*/
public class Human {
    public enum Gender {
        case Male
        case Female
    }
    
    /**
    The database identifier of product.
    - note: The general persistence of the objects living in database will be assumed to be permanent. However, in production, you should not rely on this assumption. Additional checks on ODM had better be performed.
    */
    var identifier: String
    
    //  Names, identity
    internal(set) public var name: String?
    internal(set) public var surname: String?
    internal(set) public var middleName: String?
    internal(set) public var nickname: String?
    
    //  Personal information
    internal(set) public var age: UInt?
    internal(set) public var gender: Gender?
    internal(set) public var image: NSData?
    
    init(identifier: String) {
        self.identifier = identifier
    }
}
