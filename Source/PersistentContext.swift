
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
public class PersistentContext : Hashable, CustomStringConvertible {
    /**
     The database identifier of persistent object.
     - note: The general persistence of the objects living in database will be assumed to be permanent. However, in production, you should not rely on this assumption. Additional checks on ODM had better be performed.
     */
    let identifier: String
    
    /**
     The validity of persistent object.
     - note: The general persistence of the objects living in database will be assumed to be permanent. If this property is invalid, it is more likely to be inconsistent because the changes will not affect database.
     */
    private(set) public var valid = true
    
    public var hashValue: Int {
        return identifier.hashValue
    }
    
    public var description: String {
        return "PersistentContext: Database identifier:\(identifier), valid:\(valid)"
    }
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    public enum PersistentContextError : ErrorType {
        case InvalidContext
    }
    
    public func invalidate() throws {
        guard valid else {
            throw PersistentContextError.InvalidContext
        }
        
        valid = false
    }
    
    static func fetchAll() {
        
    }
    
    /**
     Asynchronously synchronizes the object with database.
     - parameter callback: A callback passed to the asynchronous function to be executed in the end. *optional*
     - note: This method works non-blocking whether it takes callback argument, or not.
     */
    func synchronize(callback: (NSError? -> Void)? = nil) {
        //  no context
    }
}

public func ==(lhs: PersistentContext, rhs: PersistentContext) -> Bool {
    return lhs.identifier == rhs.identifier
}








