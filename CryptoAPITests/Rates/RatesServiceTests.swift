//
//  RatesServiceTests.swift
//  CryptoAPITests
//
//  Created by Alexander Eskin on 4/3/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import XCTest
@testable import CryptoAPI

class RatesServiceTests: XCTestCase {
    let authToken = ETHTestConstants.authToken
    let testTimeout: TimeInterval = 10
            
    var api: CryptoAPI {
        let settings = Settings(authorizationToken: authToken) { configurator in
            configurator.debugEnabled = true
            configurator.networkType = .testnet
        }
        return CryptoAPI(settings: settings)
    }
    
    func testRates() {
        //arrange
        let coins = ["BTC", "ETH", "BCH"]
        let expectation = XCTestExpectation(description: "testRates")
        
        //act
        api.rates.rates(coins: coins) { result in
            switch result {
            case .success(let rates):
                //assert
                XCTAssertFalse(rates.isEmpty)
                
            case .failure(let error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testRatesHistory() {
        //arrange
        let coins = ["BTC", "ETH", "BCH"]
        let expectation = XCTestExpectation(description: "testRatesHistory")
        
        //act
        api.rates.ratesHistory(coins: coins) { result in
            switch result {
            case .success(let rates):
                //assert
                XCTAssertFalse(rates.isEmpty)
                
            case .failure(let error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
}
