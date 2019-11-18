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
    
    let ethAddressWithBalance = "0x141d5937C7b0e4fB4C535c900C0964B4852007eA"
    let ethAddressWithBalance2 = "0xb0202eBbF797Dd61A3b28d5E82fbA2523edc1a9B"
    let ethContractAddress = "0xf36c145eff2771ea22ece5fd87392fc8eeae719c"
    let ethInvalidAddress = "invalid address"

    func testGetBalance() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testGetBalance")
        let address = ethAddressWithBalance
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
        let address = ethInvalidAddress
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
        let fromAddress = ethAddressWithBalance
        let toAddress = ethAddressWithBalance2
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
        let fromAddress = ethInvalidAddress
        let toAddress = ethInvalidAddress
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
        let address = ethAddressWithBalance

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
        let address = ethContractAddress

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
        let address = ethInvalidAddress

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
        let address = ethAddressWithBalance
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
        let expectation = XCTestExpectation(description: "testHistoryAddressFailedTest")
        let address = ethInvalidAddress
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
        let address = ethAddressWithBalance
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
        let address = ethInvalidAddress
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
        let fromAddress = ethAddressWithBalance
        let toAddress = ethAddressWithBalance2
        let skip = 0
        let limit = 10

        //act
        api.eth.transactions(skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress) { result in
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
        let expectation = XCTestExpectation(description: "testTransfersFailedTest")
        let fromAddress = ethInvalidAddress
        let toAddress = ethAddressWithBalance2
        let skip = 0
        let limit = 10

        //act
        api.eth.transactions(skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress) { result in
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
    
    func testTransactionTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testTransactionTest")
        let hash = "0xaa70e870c45862a9881d44bb4f3f5e47ec986dc6d6cb5b10d553587ecd9e4fd4"

        //act
        api.eth.transaction(hash: hash) { result in
            switch result {
            case let .success(item):
                //assert
                XCTAssertTrue(!item.hash.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testTransactionFailedTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testTransactionFailedTest")
        let hash = ethInvalidAddress

        //act
        api.eth.transaction(hash: hash) { result in
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
    
    func testContractInfoTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testContractInfoTest")
        let address = ethContractAddress

        //act
        api.eth.contractInfo(address: address) { result in
            switch result {
            case let .success(info):
                //assert
                XCTAssertTrue(!info.bytecode.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testContractInfoFailedTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testContractInfoFailedTest")
        let address = ethInvalidAddress

        //act
        api.eth.contractInfo(address: address) { result in
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
    
    func testTokensBalanceTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testTokensBalanceTest")
        let address = ethContractAddress
        let skip = 0
        let limit = 10
        //act
        api.eth.tokensBalance(address: address, skip: skip, limit: limit) { result in
            switch result {
            case let .success(balances):
                //assert
                XCTAssertTrue(!balances.items.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testTokensBalanceFailedTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testTokensBalanceFailedTest")
        let address = ethInvalidAddress
        let skip = 0
        let limit = 10
        //act
        api.eth.tokensBalance(address: address, skip: skip, limit: limit) { result in
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
