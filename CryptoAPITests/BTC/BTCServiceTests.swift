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
    let authToken = BTCTestConstants.authToken
    let testTimeout = BTCTestConstants.timeout
    let btcInvalidAddress = BTCTestConstants.btcInvalidAddress
    let blockHash = BTCTestConstants.btcBlockHash
    let blockHeight = BTCTestConstants.btcBlockHeight
    let firebaseToken = BTCTestConstants.firebaseToken
    
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
    
    func testEstimateFeeTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testNetworkTest")
        
        //act
        api.btc.feePerKb { result in
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
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let fromAddress = "2N6z6fSZRQifyC8irzFrJrxJg1nbwh2PDB3"
        let toAddress = "2MzUnALzSgniCX9FXrGeYqewSVhtfkywX2b"
        let blockHeight = 1665130
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
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let address = "2MwcRaFr3TicdFLm84AfYi3HArFQx91cwFz"
        let skip: Int? = 0
        let limit: Int? = nil
        
        //act
        api.btc.addressesOutputs(addresses: [address], status: "unspent", skip: skip, limit: limit) { result in
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
        let address = "2MwcRaFr3TicdFLm84AfYi3HArFQx91cwFz"
        
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
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let address = "2MwcRaFr3TicdFLm84AfYi3HArFQx91cwFz"
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
    
//    func testSubscribePushNotifications() {
//        //assert
//        let addresses = [btcAddressWithBalance, btcAddressWithBalance2]
//        let token = firebaseToken
//        let types = "all"
//        let expectation = XCTestExpectation(description: "testSubscribePushNotifications")
//
//        //act
//        api.btc.subscribePushNotifications(addresses: addresses, firebaseToken: token, types: types) { result in
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
    
//    func testUnsubscribePushNotifications() {
//        //assert
//        let addresses = [btcAddressWithBalance, btcAddressWithBalance2]
//        let token = firebaseToken
//        let types = "all"
//        let expectation = XCTestExpectation(description: "testUnsubscribePushNotifications")
//
//        //act
//        api.btc.unsubscribePushNotifications(addresses: addresses, firebaseToken: token, types: types) { result in
//            switch result {
//            case .success(let success):
//                //assert
//                XCTAssertTrue(success)
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
        let addresses = [btcAddressWithBalance, btcAddressWithBalance2]
        let firebaseToken = "invalid token"
        let expectation = XCTestExpectation(description: "testSubscribePushNotificationsFailed")
        let types = "outgoing,incoming"
        
        //act
        api.btc.subscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken, types: types) { result in
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
