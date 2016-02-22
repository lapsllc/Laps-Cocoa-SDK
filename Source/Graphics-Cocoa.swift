
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

import Cocoa

func colorMapper(colors: [Color]) -> [NSColor] {
    return colors.map() { color in
        return NSColor(
            red: CGFloat(color.red),
            green: CGFloat(color.green),
            blue: CGFloat(color.blue),
            alpha: CGFloat(color.alpha))
    }
}

extension Brand {
    /**
     The colors of brand.
     - note: This method is a virtual method automatically changes based on platform, iOS or OS X.
     - returns: An array of colors.
     */
    var colors: [NSColor] {
        return colorMapper(_colors)
    }
}

extension Product {
    /**
     The colors of product.
     - note: This method is a virtual method automatically changes based on platform, iOS or OS X.
     - returns: An array of colors.
     */
    var colors: [NSColor] {
        return colorMapper(_colors)
    }
    
    /**
     Returns a thumbnail image of the product.
     - parameter size: Size of the image. If **NSZeroSize** is set, same size of the raw image fetched from the server will be returned.
     - returns: A thumbnail image of the product.
    */
    func thumbnail(size size: NSSize) -> NSImage? {
        if let image = _thumbnail {
            return NSImage(CGImage: image, size: size)
        } else {
            return nil
        }
    }
}
