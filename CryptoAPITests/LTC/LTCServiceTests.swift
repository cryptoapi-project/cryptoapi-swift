//
//  LTCServiceTests.swift
//  CryptoAPITests
//
//  Created by Alexander Eskin on 5/15/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import XCTest
@testable import CryptoAPI

class LTCServiceTests: XCTestCase {
    let ltcAddressWithBalance = LTCTestConstants.ltcAddressWithBalance
    let ltcAddressWithBalance2 = LTCTestConstants.ltcAddressWithBalance2
    let transactionHash = LTCTestConstants.ltcTransactionHash
    let authToken = LTCTestConstants.authToken
    let testTimeout = LTCTestConstants.timeout
    let ltcInvalidAddress = LTCTestConstants.ltcInvalidAddress
    let blockHash = LTCTestConstants.ltcBlockHash
    let blockHeight = LTCTestConstants.ltcBlockHeight
    let firebaseToken = LTCTestConstants.firebaseToken
    
    var api: CryptoAPI {
        let settings = Settings(authorizationToken: authToken) { configurator in
            configurator.debugEnabled = true
            configurator.networkType = .testnet
        }
        return CryptoAPI(settings: settings)
    }
    
    func testNetworkTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testNetworkTest")
        
        //act
        api.ltc.network { result in
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
    
    func testEstimateFeeTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testNetworkTest")
        
        //act
        api.ltc.feePerKb { result in
            switch result {
            case let .success(feePerKb):
                //assert
                XCTAssertTrue(!feePerKb.isEmpty)
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
//        let tx = "010000000166599dd32af5aa39733f4f738f6d7651c53652015f42e5d9e8510ce8fffa88ff010000006b483045022100baff19c9e5367f4b33b019eff78184049204148c394d95e9147908883fb7109802206a82ca3a149c7d2a5e0b003d34e9399770079714b0e2a57c02e032f87648bcd10121033f5339fa89934154beb1c25e50b63fddc248078cd9dfcbca703ee3ff430f519effffffff02a00f0000000000001976a914895628eee760f90bcd3869655a9a99a9598dff0388ac48170f00000000001976a914126c30c1498be36ed69f6dbbc70a7608f749656788ac00000000"
//        //act
//        api.ltc.sendRaw(transaction: tx) { result in
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
        let expectation = XCTestExpectation(description: "testSendRawTransactionTest")
        let tx = "invalid transaction hash"
        //act
        api.ltc.sendRaw(transaction: tx) { result in
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
        let expectation = XCTestExpectation(description: "testDecodeRawTransactionTest")
        let tx = "01000000014368d74c6a7b118610b325389613acff68a324eb86caf61e1494d1ff6bcb07e9010000006a4730440220463a47bd9ba114ba919b7bb6fc4f9e97754fb1e8eb78c5d4803cb3208fea7c8c0220271174def0bf6499b09b48fa87ad6f3ae8e3f16217228ed5c722aa9a4e1180fd01210309a18fa38989b25a7cc4f66fb193a9a26842113874908c430a25d65f66e4e5fbffffffff0101000000000000001976a91492bf5261a59bd600825dc81cfee868b7f123b97288ac00000000"
        //act
        api.ltc.decodeRaw(transaction: tx) { result in
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
        let expectation = XCTestExpectation(description: "testDecodeRawTransactionTest")
        let tx = "invalid transaction"
        //act
        api.ltc.decodeRaw(transaction: tx) { result in
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
        let expectation = XCTestExpectation(description: "testGetBlockByNumber")
        let height = blockHeight
        let hash = blockHash
        print(hash)
        //act
        api.ltc.block(numberOrHash: String(height), completion: { result in
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
        let expectation = XCTestExpectation(description: "testGetBlockByNumber")
        let height = blockHeight
        let hash = blockHash
        print(hash)
        //act
        api.ltc.block(numberOrHash: hash, completion: { result in
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
        let expectation = XCTestExpectation(description: "testGetBlocks")
        let skip = 0
        let limit = 2
        
        //act
        api.ltc.blocks(skip: skip, limit: limit, completion: { result in
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
        let expectation = XCTestExpectation(description: "testTransactionTest")
        let hash = transactionHash
        
        //act
        api.ltc.transactionBy(hash: hash) { result in
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
        let expectation = XCTestExpectation(description: "testTransactionFailedTest")
        let hash = "invalid hash"
        
        //act
        api.ltc.transactionBy(hash: hash) { result in
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
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let fromAddress = "QaAqKiTwm5qpYyjuSLRXhuAHtpBuWn6vFU"
        let toAddress = "QYjjEaX6BdkGR9omQGRXLF7MR1oPrP8C3k"
        let blockHeight = 1400000
        let skip = 0
        let limit = 10
        
        //act
        api.ltc.transactions(blockHeightOrHash: String(blockHeight), skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress) { result in
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
        let expectation = XCTestExpectation(description: "testTransfersFailedTest")
        let fromAddress = ltcInvalidAddress
        let toAddress = ltcAddressWithBalance2
        let blockHeight = 1664129
        let skip = 0
        let limit = 10
        
        //act
        api.ltc.transactions(blockHeightOrHash: String(blockHeight), skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress) { result in
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
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let address = ltcAddressWithBalance
        let skip: Int? = 0
        let limit: Int? = nil
        
        //act
        api.ltc.addressesOutputs(addresses: [address], status: "unspent", skip: skip, limit: limit) { result in
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
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let address = ltcAddressWithBalance
        
        //act
        api.ltc.addressesUxtoInfo(addresses: [address]) { result in
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
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let address = ltcAddressWithBalance2
        let skip = 0
        let limit = 10
        
        //act
        api.ltc.addressesTransactionsHistory(addresses: [address], skip: skip, limit: limit) { result in
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
    
//    func testSubscribePushNotifications() {
//        //assert
//        let addresses = [ltcAddressWithBalance, ltcAddressWithBalance2]
//        let token = firebaseToken
//        let types = "all"
//        let expectation = XCTestExpectation(description: "testSubscribePushNotifications")
//
//        //act
//        api.ltc.subscribePushNotifications(addresses: addresses, firebaseToken: token, types: types) { result in
//            switch result {
//            case .success(let model):
//                //assert
//                XCTAssertFalse(model.addresses.isEmpty)
//
//            case .failure(let error):
//                //assert
//                XCTAssertThrowsError(error)
//            }
//            expectation.fulfill()
//        }
//
//        //assert
//        wait(for: [expectation], timeout: testTimeout)
//    }
//
//    func testUnsubscribePushNotifications() {
//        //assert
//        let addresses = [ltcAddressWithBalance, ltcAddressWithBalance2]
//        let token = firebaseToken
//        let types = "all"
//        let expectation = XCTestExpectation(description: "testUnsubscribePushNotifications")
//
//        //act
//        api.ltc.unsubscribePushNotifications(addresses: addresses, firebaseToken: token, types: types) { result in
//            switch result {
//            case .success(let model):
//                //assert
//                XCTAssertFalse(model.addresses.isEmpty)
//
//            case .failure(let error):
//                //assert
//                XCTAssertThrowsError(error)
//            }
//            expectation.fulfill()
//        }
//
//        //assert
//        wait(for: [expectation], timeout: testTimeout)
//    }
    
    func testSubscribePushNotificationsFailed() {
        //assert
        let addresses = [ltcAddressWithBalance, ltcAddressWithBalance2]
        let firebaseToken = "invalid token"
        let types = "all"
        let expectation = XCTestExpectation(description: "testSubscribePushNotificationsFailed")
        
        //act
        api.ltc.subscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken, types: types) { result in
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
}
