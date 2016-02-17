
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

public class PersistentContext : Equatable {
    /**
     The database identifier of persistent object.
     - note: The general persistence of the objects living in database will be assumed to be permanent. However, in production, you should not rely on this assumption. Additional checks on ODM had better be performed.
     */
    let identifier: String
    private(set) public var valid = true
    
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
    
    func synchronize() {
        //  some synchronization code
    }
}

public func ==(lhs: PersistentContext, rhs: PersistentContext) -> Bool {
    return lhs.identifier == rhs.identifier
}








