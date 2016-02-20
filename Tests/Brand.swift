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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIndex() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = self.expectationWithDescription("Testing -index method")
        
        LapsKit.Brand.feed() { brands, error in
            if let brandsArray = brands {
                for eachBrand in brandsArray {
                    debugPrint("Brand with identifier \(eachBrand.identifier) is fetched:")
                    debugPrint("\(eachBrand.name): \(eachBrand.DBdescription)")
                }
                
                expectation.fulfill()
            }
        }
        
        self.waitForExpectationsWithTimeout(5.0) { error in
            if (error != nil) {
                XCTFail("Expectation failed with error")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
