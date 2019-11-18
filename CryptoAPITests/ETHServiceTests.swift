//
//  ETHServiceTests.swift
//  CryptoAPITests
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import XCTest
@testable import CryptoAPI

class ETHServiceTests: XCTestCase {
    func testGetBalance() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testGetBalance")
        let address = "0x141d5937C7b0e4fB4C535c900C0964B4852007eA"
        //act
        api.eth.balance(address: address) { result in
            switch result {
            case let .success(balances):
                //assert
                XCTAssertTrue(!balances.isEmpty)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetBalanceFailed() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testGetBalance")
        let address = "invalida address"
        //act
        api.eth.balance(address: address) { result in
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
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testEstimateSendAmountTransaction() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testEstimateSendAmountTransaction")
        let fromAddress = "0x141d5937C7b0e4fB4C535c900C0964B4852007eA"
        let toAddress = "0xb0202eBbF797Dd61A3b28d5E82fbA2523edc1a9B"
        let amount = "10"
        let data = ""

        //act
        api.eth.estimateGas(fromAddress: fromAddress, toAddress: toAddress, data: data, value: amount) { result in
            switch result {
            case let .success(estimate):
                //assert
                XCTAssertTrue(!estimate.gasPrice.isEmpty)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testEstimateSendAmountTransactionFailed() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testEstimateSendAmountTransaction")
        let fromAddress = "invalida address"
        let toAddress = "invalida address"
        let amount = "10"
        let data = ""

        //act
        api.eth.estimateGas(fromAddress: fromAddress, toAddress: toAddress, data: data, value: amount) { result in
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
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNetworkTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testNetworkTest")

        //act
        api.eth.network { result in
            switch result {
            case let .success(network):
                //assert
                XCTAssertTrue(!network.countTransactions.isEmpty)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testInfoTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testInfoTest")
        let address = "0x141d5937C7b0e4fB4C535c900C0964B4852007eA"

        //act
        //act
        api.eth.info(address: address) { result in
            switch result {
            case let .success(infos):
                //assert
                XCTAssertTrue(!infos.isEmpty)
                XCTAssertFalse(infos.first!.isContract)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testInfoContractTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testInfoContractTest")
        let address = "0xf36c145eff2771ea22ece5fd87392fc8eeae719c"

        //act
        //act
        api.eth.info(address: address) { result in
            switch result {
            case let .success(infos):
                //assert
                XCTAssertTrue(!infos.isEmpty)
                XCTAssertTrue(infos.first!.isContract)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testInfoFailedTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testInfoFailedTest")
        let address = "invalid address"

        //act
        api.eth.info(address: address) { result in
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
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testHistoryAddressTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testHistoryAddressTest")
        let address = "0x141d5937C7b0e4fB4C535c900C0964B4852007eA"
        let skip = 0
        let limit = 10
        let positive = ""

        //act
        api.eth.transfers(skip: skip, limit: limit, addresses: address, positive: positive) { result in
            switch result {
            case let .success(history):
                //assert
                XCTAssertTrue(!history.items.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testHistoryAddressFailedTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testHistoryAddressTest")
        let address = "invalid address"
        let skip = 0
        let limit = 10
        let positive = ""

        //act
        api.eth.transfers(skip: skip, limit: limit, addresses: address, positive: positive) { result in
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
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testExternalHistoryAddressTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressTest")
        let address = "0x141d5937C7b0e4fB4C535c900C0964B4852007eA"
        let skip = 0
        let limit = 10

        //act
        api.eth.externalTransfers(skip: skip, limit: limit, addresses: address) { result in
            switch result {
            case let .success(history):
                //assert
                XCTAssertTrue(!history.items.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testExternalHistoryAddressFailedTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressFailedTest")
        let address = "invalid address"
        let skip = 0
        let limit = 10

        //act
        api.eth.externalTransfers(skip: skip, limit: limit, addresses: address) { result in
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
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testTransfersTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let fromAddress = "0x141d5937C7b0e4fB4C535c900C0964B4852007eA"
        let toAddress = "0xb0202eBbF797Dd61A3b28d5E82fbA2523edc1a9B"
        let skip = 0
        let limit = 10

        //act
        api.eth.transfers(skip: skip, limit: limit, addresses: fromAddress, positive: toAddress) { result in
            switch result {
            case let .success(history):
                //assert
                XCTAssertTrue(!history.items.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testTransfersFailedTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressFailedTest")
        let fromAddress = "invalid address"
        let toAddress = "0xb0202eBbF797Dd61A3b28d5E82fbA2523edc1a9B"
        let skip = 0
        let limit = 10

        //act
        api.eth.transfers(skip: skip, limit: limit, addresses: fromAddress, positive: toAddress) { result in
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
        wait(for: [expectation], timeout: 10.0)
    }
}
