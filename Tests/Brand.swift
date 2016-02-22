
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

import XCTest
@testable import LapsKit

class BrandTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    enum ValidationError : ErrorType {
        case InvalidIdentifier(identifier: String)
        case InvalidColor
    }

    func testFetchDefault() {
        func validate(brand: Brand) throws {
            for color in brand._colors {
                guard color.red <= 1 && color.green <= 1 && color.blue <= 1 && color.alpha <= 1 else {
                    throw ValidationError.InvalidColor
                }
            }
        }
        
        let expectation = self.expectationWithDescription("Testing -index method with nil arguments")
        
        do {
            try LapsKit.Brand.feed() { brands, error in
                if let brandsArray = brands {
                    for eachBrand in brandsArray {
                        try! validate(eachBrand)
                        
                        debugPrint("Brand with identifier \(eachBrand.identifier) is fetched:")
                        debugPrint("\(eachBrand.name): \(eachBrand.information)")
                    }
                    
                    expectation.fulfill()
                }
            }
        } catch LapsKit.Brand.FeedError.UnexpectedLimitValue(let limit) {
            debugPrint("Limit value is too high: \(limit)")
        } catch LapsKit.Brand.FeedError.NoPreviousFetch {
            debugPrint("Attempted pagination but there was no previous request.")
        } catch {
            debugPrint("Unexpected error occurred.")
        }
        
        self.waitForExpectationsWithTimeout(25.0) { error in
            if (error != nil) {
                XCTFail("Expectation failed with error")
            }
        }
    }
    
    func testFetchWithLimit() {
        let limit: UInt = 1
        
        let expectation = self.expectationWithDescription("Testing -index method")
        
        do {
            try LapsKit.Brand.feed(limit: limit) { brands, error in
                if let brandsArray = brands {
                    for eachBrand in brandsArray {
                        debugPrint("Brand with identifier \(eachBrand.identifier) is fetched:")
                        debugPrint("\(eachBrand.name): \(eachBrand.information)")
                    }
                    
                    XCTAssert(brandsArray.count == 1, "Expected \(limit) brands.")
                    expectation.fulfill()
                }
            }
        } catch LapsKit.Brand.FeedError.UnexpectedLimitValue(let limit) {
            debugPrint("Limit value is too high: \(limit)")
        } catch LapsKit.Brand.FeedError.NoPreviousFetch {
            debugPrint("Attempted pagination but there was no previous request.")
        } catch {
            debugPrint("Unexpected error occurred.")
        }
        
        self.waitForExpectationsWithTimeout(25.0) { error in
            if (error != nil) {
                XCTFail("Expectation failed with error")
            }
        }
    }
    
    func testFetchWithOffset() {
        let offset: UInt = 1
        
        let expectation = self.expectationWithDescription("Testing -index method")
        
        do {
            try LapsKit.Brand.feed(offset: offset) { brands, error in
                if let brandsArray = brands {
                    for eachBrand in brandsArray {
                        debugPrint("Brand with identifier \(eachBrand.identifier) is fetched:")
                        debugPrint("\(eachBrand.name): \(eachBrand.information)")
                    }
                    
                    
                    expectation.fulfill()
                }
            }
        } catch LapsKit.Brand.FeedError.UnexpectedLimitValue(let limit) {
            debugPrint("Limit value is too high: \(limit)")
        } catch LapsKit.Brand.FeedError.NoPreviousFetch {
            debugPrint("Attempted pagination but there was no previous request.")
        } catch {
            debugPrint("Unexpected error occurred.")
        }
        
        self.waitForExpectationsWithTimeout(25.0) { error in
            if (error != nil) {
                XCTFail("Expectation failed with error")
            }
        }
    }

}
