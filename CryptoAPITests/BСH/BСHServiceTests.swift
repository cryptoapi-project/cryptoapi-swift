//
//  BCHServiceTests.swift
//  CryptoAPITests
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import XCTest
@testable import CryptoAPI

class BCHServiceTests: XCTestCase {
    let BCHAddressWithBalance = BCHTestConstants.BCHAddressWithBalance
    let BCHAddressWithBalance2 = BCHTestConstants.BCHAddressWithBalance2
    let transactionHash = BCHTestConstants.BCHTransactionHash
    let authToken = BCHTestConstants.authToken
    let testTimeout = BCHTestConstants.timeout
    let BCHInvalidAddress = BCHTestConstants.BCHInvalidAddress
    let blockHash = BCHTestConstants.BCHBlockHash
    let blockHeight = BCHTestConstants.BCHBlockHeight
    
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
        api.bch.network { result in
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
        api.bch.feePerKb { result in
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
    
    func testSendRawTransactionFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testSendRawTransactionTest")
        let tx = "invalid transaction hash"
        //act
        api.bch.sendRaw(transaction: tx) { result in
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
        api.bch.decodeRaw(transaction: tx) { result in
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
        api.bch.decodeRaw(transaction: tx) { result in
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
        api.bch.block(numberOrHash: String(height), completion: { result in
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
        api.bch.block(numberOrHash: hash, completion: { result in
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
        api.bch.blocks(skip: skip, limit: limit, completion: { result in
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
        api.bch.transactionBy(hash: hash) { result in
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
        api.bch.transactionBy(hash: hash) { result in
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
        let fromAddress = BCHAddressWithBalance
        let toAddress = BCHAddressWithBalance2
        let blockHeight = 1360264
        let skip = 0
        let limit = 10

        //act
        api.bch.transactions(blockHeightOrHash: String(blockHeight), skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress) { result in
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
        let fromAddress = BCHInvalidAddress
        let toAddress = BCHAddressWithBalance2
        let blockHeight = 1664129
        let skip = 0
        let limit = 10

        //act
        api.bch.transactions(blockHeightOrHash: String(blockHeight), skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress) { result in
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
        let address = BCHAddressWithBalance2
        let skip: Int? = 0
        let limit: Int? = nil

        //act
        api.bch.addressesOutputs(addresses: [address], status: "spent", skip: skip, limit: limit) { result in
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
        let address = BCHAddressWithBalance

        //act
        api.bch.addressesUxtoInfo(addresses: [address]) { result in
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
        let address = BCHAddressWithBalance
        let skip = 0
        let limit = 10

        //act
        api.bch.addressesTransactionsHistory(addresses: [address], skip: skip, limit: limit) { result in
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
//        let addresses = [BCHAddressWithBalance, BCHAddressWithBalance2]
//        let firebaseToken = "euCaVJIrR92o3YMRcXSWot:APA91bFnIkCEo4RWBJsNO5ThtHAmwT1HA0-BEQTbCLDYfAcJXKTx-HoRzcB65AWcrZGo3TyORWM_Ey_IozFrRpaqTC_DmZsZMpoqrUdvK9fVA3ILbGBy-exXOZLWidhz6c_7qIp0NG0G"
//        let expectation = XCTestExpectation(description: "testSubscribePushNotifications")
//        
//        //act
//        api.bch.subscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken) { result in
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
//        let addresses = [BCHAddressWithBalance, BCHAddressWithBalance2]
//        let firebaseToken = "euCaVJIrR92o3YMRcXSWot:APA91bFnIkCEo4RWBJsNO5ThtHAmwT1HA0-BEQTbCLDYfAcJXKTx-HoRzcB65AWcrZGo3TyORWM_Ey_IozFrRpaqTC_DmZsZMpoqrUdvK9fVA3ILbGBy-exXOZLWidhz6c_7qIp0NG0G"
//        let expectation = XCTestExpectation(description: "testUnsubscribePushNotifications")
//        
//        //act
//        api.bch.unsubscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken) { result in
//            switch result {
//            case .success(let model):
//                //assert
//                XCTAssertEqual(model.token, firebaseToken)
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
        let addresses = [BCHAddressWithBalance, BCHAddressWithBalance2]
        let firebaseToken = "invalid token"
        let expectation = XCTestExpectation(description: "testSubscribePushNotificationsFailed")
        
        //act
        api.bch.subscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken) { result in
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
