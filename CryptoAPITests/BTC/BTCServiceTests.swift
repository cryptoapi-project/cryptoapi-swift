//
//  BTCServiceTests.swift
//  CryptoAPITests
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import XCTest
@testable import CryptoAPI

class BTCServiceTests: XCTestCase {
    let btcAddressWithBalance = BTCTestConstants.btcAddressWithBalance
    let btcAddressWithBalance2 = BTCTestConstants.btcAddressWithBalance2
    let transactionHash = BTCTestConstants.btcTransactionHash
    let authToken = AuthorizationToken(value: BTCTestConstants.authToken)
    let testTimeout = BTCTestConstants.timeout
    let btcInvalidAddress = BTCTestConstants.btcInvalidAddress
    let blockHash = BTCTestConstants.btcBlockHash
    let blockHeight = BTCTestConstants.btcBlockHeight
    
    func testNetworkTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testNetworkTest")
        
        //act
        api.btc.network { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
//    func testSendRawTransactionTest() {
//        //arrange
//        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
//        let expectation = XCTestExpectation(description: "testSendRawTransactionTest")
//        let tx = "0100000001b78d508a74d6554ebebbc8b3d96b9fac9219cf4afdbf0737c245aec70340a4cd010000006a4730440220738c2fe3674666555fafb43db61e6892e1ac771d350324f1622c4d2766850881022040739dc8479bb12ba0fc7531e1387719df436b2b504192c237bf4b595d118e2f01210256459852d8a18ffcd7fb5560d0186b59c1d3051bac69875f23f5a3af52c42983ffffffff01fc530000000000001976a9142b3aa4e75216d6fa15687fc221e28d974545b56588ac00000000"
//        //act
//        api.btc.sendRaw(transaction: tx) { result in
//            switch result {
//            case .success:
//                break
//            case let .failure(error):
//                //asserts
//                XCTAssertThrowsError(error)
//            }
//            expectation.fulfill()
//        }
//
//        //assert
//        wait(for: [expectation], timeout: testTimeout)
//    }
    
    func testSendRawTransactionFailedTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testSendRawTransactionTest")
        let tx = "invalid transaction hash"
        //act
        api.btc.sendRaw(transaction: tx) { result in
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
    
    func testDecodeRawTransactionTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testDecodeRawTransactionTest")
        let tx = "0100000001b78d508a74d6554ebebbc8b3d96b9fac9219cf4afdbf0737c245aec70340a4cd010000006a4730440220738c2fe3674666555fafb43db61e6892e1ac771d350324f1622c4d2766850881022040739dc8479bb12ba0fc7531e1387719df436b2b504192c237bf4b595d118e2f01210256459852d8a18ffcd7fb5560d0186b59c1d3051bac69875f23f5a3af52c42983ffffffff01fc530000000000001976a9142b3aa4e75216d6fa15687fc221e28d974545b56588ac00000000"
        //act
        api.btc.decodeRaw(transaction: tx) { result in
            switch result {
            case let .success(result):
                //assert
                XCTAssertTrue(!result.inputs.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }
        
        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testDecodeRawTransactionFailedTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testDecodeRawTransactionTest")
        let tx = "invalid transaction"
        //act
        api.btc.decodeRaw(transaction: tx) { result in
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
    
    func testGetBlockByHeight() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testGetBlockByNumber")
        let height = blockHeight
        let hash = blockHash
        print(hash)
        //act
        api.btc.block(numberOrHash: String(height), completion: { result in
            switch result {
            case let .success(result):
                //assert
                XCTAssertTrue(result.hash == hash)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        })
        
        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testGetBlockByHash() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testGetBlockByNumber")
        let height = blockHeight
        let hash = blockHash
        print(hash)
        //act
        api.btc.block(numberOrHash: hash, completion: { result in
            switch result {
            case let .success(result):
                //assert
                XCTAssertTrue(result.height == height)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        })
        
        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testGetBlocks() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testGetBlocks")
        let skip = 0
        let limit = 2
        
        //act
        api.btc.blocks(skip: skip, limit: limit, completion: { result in
            switch result {
            case let .success(result):
                //assert
                XCTAssertTrue(!result.items.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        })
        
        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTransactionTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testTransactionTest")
        let hash = transactionHash
        
        //act
        api.btc.transactionBy(hash: hash) { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTransactionFailedTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testTransactionFailedTest")
        let hash = "invalid hash"
        
        //act
        api.btc.transactionBy(hash: hash) { result in
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
    
    func testTransactionsTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let fromAddress = btcAddressWithBalance
        let toAddress = btcAddressWithBalance2
        let blockHeight = 1664129
        let skip = 0
        let limit = 10
        
        //act
        api.btc.transactions(blockHeightOrHash: String(blockHeight), skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress) { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTransactionsFailedTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testTransfersFailedTest")
        let fromAddress = btcInvalidAddress
        let toAddress = btcAddressWithBalance2
        let blockHeight = 1664129
        let skip = 0
        let limit = 10
        
        //act
        api.btc.transactions(blockHeightOrHash: String(blockHeight), skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress) { result in
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
    
    func testAddressesOutputsTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let address = btcAddressWithBalance
        let skip = 0
        let limit = 10
        
        //act
        api.btc.addressesOutputs(addresses: [address], status: "spent", skip: skip, limit: limit) { result in
            switch result {
            case let .success(outs):
                //assert
                XCTAssertTrue(!outs.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }
        
        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testAddressesUxtoInfoTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let address = btcAddressWithBalance
        
        //act
        api.btc.addressesUxtoInfo(addresses: [address]) { result in
            switch result {
            case let .success(outs):
                //assert
                XCTAssertTrue(!outs.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }
        
        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testAddressesTransactionsHistoryTest() {
        //arrange
        let api = CryptoAPI(settings: Settings(authorizationToken: authToken, isNeedLogs: true))
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let address = btcAddressWithBalance
        let skip = 0
        let limit = 10
        
        //act
        api.btc.addressesTransactionsHistory(addresses: [address], skip: skip, limit: limit) { result in
            switch result {
            case let .success(outs):
                //assert
                XCTAssertTrue(!outs.items.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }
        
        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
}
