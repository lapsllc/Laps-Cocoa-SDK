
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

public class Bag<T: PersistentContext> : CustomStringConvertible {
    private var storage = Dictionary<T, Int>()
    
    init(_ items : T ...) {
        for item in items {
            self.addItem(item)
        }
    }
    
    func addItem(item : T) {
        if let count = storage[item] {
            storage[item] = count + 1
        } else {
            storage[item] = 1
        }
    }
    
    func removeItem(item: T) {
        if let count = storage[item] {
            if (count > 1) {
                storage[item] = count - 1
            } else {
                storage.removeValueForKey(item)
            }
        }
    }
    
    public var description : String {
        return storage.description
    }
    
    func updateAll() {
        for (eachObject, _) in storage {
            eachObject.synchronize()
        }
    }
}
















