//
//  Brand.swift
//  LapsKit
//
//  Created by Buğra Ekuklu on 20.02.2016.
//  Copyright © 2016 The Digital Warehouse. All rights reserved.
//

import XCTest
@testable import LapsKit

class Brand: XCTestCase {

    override func setUp() {
        super.setUp()
        
        try! LapsKit.Brand.feed() { _,_ in }
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBrandDefault() {
        let expectation = self.expectationWithDescription("Testing -index method")
        
        do {
            try LapsKit.Brand.feed() { brands, error in
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
    
    func testBrandWithLimit() {
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
    
    func testBrandWithOffset() {
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
