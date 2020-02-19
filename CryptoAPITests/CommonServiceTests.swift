//
//  CommonServiceTests.swift
//  CryptoAPITests
//
//  Created by Fedorenko Nikita on 11/19/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import XCTest
@testable import CryptoAPI

class CommonServiceTests: XCTestCase {
    let authToken = ETHTestConstants.authToken
    let testTimeout: TimeInterval = 10
            
    var api: CryptoAPI {
        let settings = Settings(authorizationToken: authToken) { configurator in
            configurator.debugEnabled = true
            configurator.networkType = .testnet
        }
        return CryptoAPI(settings: settings)
    }
    
    func testCoins() {
        //arrange
        let expectation = XCTestExpectation(description: "testCoins")
        //act
        api.common.coins { result in
            switch result {
            case let .success(coins):
                //assert
                XCTAssertTrue(!coins.isEmpty)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
}

