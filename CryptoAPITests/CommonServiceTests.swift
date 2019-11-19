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
    let testTimeout: TimeInterval = 10

    func testRates() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testRates")
        //act
        api.common.rates { result in
            switch result {
            case let .success(rates):
                //assert
                XCTAssertTrue(rates.eth.usd > 0)
            case let .failure(error):
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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testRatesHistory")
        let coin = "eth"
        //act
        api.common.ratesHistory(coin: coin) { result in
            switch result {
            case let .success(history):
                //assert
                XCTAssertTrue(!history.isEmpty)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testRatesHistoryFailed() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testRatesHistoryFailed")
        let coin = "invalid coin"
        //act
        api.common.ratesHistory(coin: coin) { result in
            switch result {
            case .success:
                //assert
                XCTFail()
            case .failure:
                break
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testCoins() {
        //arrange
        let api = CtyptoAPI.default
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

