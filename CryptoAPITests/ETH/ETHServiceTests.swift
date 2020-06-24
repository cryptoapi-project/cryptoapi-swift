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
    let ethAddressWithBalance = ETHTestConstants.ethAddressWithBalance
    let ethAddressWithBalance2 = ETHTestConstants.ethAddressWithBalance2
    let ethContractAddress = ETHTestConstants.ethContractAddress
    let ethTokenWithBalances = ETHTestConstants.ethTokenWithBalances
    let transactionHash = ETHTestConstants.ethTransactionHash
    let authToken = ETHTestConstants.authToken
    let testTimeout = ETHTestConstants.timeout
    let ethInvalidAddress = ETHTestConstants.ethInvalidAddress
    let blockNumber = ETHTestConstants.ethBlockNumber
    let blockHash = ETHTestConstants.ethBlockHash
    let firebaseToken = ETHTestConstants.firebaseToken
    
    var api: CryptoAPI {
        let settings = Settings(authorizationToken: authToken) { configurator in
            configurator.debugEnabled = true
            configurator.networkType = .testnet
//            configurator.timeoutIntervalForRequest = 30
        }
        return CryptoAPI(settings: settings)
    }
    
    func testGetBalance() {
        //arrange
        let expectation = XCTestExpectation(description: "testGetBalance")
        let address = ethAddressWithBalance
        //act
        api.eth.balance(addresses: [address]) { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testGetBalances() {
        //arrange
        let expectation = XCTestExpectation(description: "testGetBalance")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2
        //act
        api.eth.balance(addresses: [address, address2]) { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testGetBalanceFailed() {
        //arrange
        let expectation = XCTestExpectation(description: "testGetBalance")
        let address = ethInvalidAddress
        //act
        api.eth.balance(addresses: [address]) { result in
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
    
    func testEstimateSendAmountTransaction() {
        //arrange
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testEstimateSendAmountTransactionFailed() {
        //arrangelet asdfaf = Settings(authorizationToken: AuthorizationToken(value: "asdf"))
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testNetworkTest() {
        //arrange
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testInfoTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testInfoTest")
        let address = ethAddressWithBalance

        //act
        api.eth.info(addresses: [address]) { result in
            switch result {
            case let .success(infos):
                //assert
                XCTAssertTrue(!infos.isEmpty)
                XCTAssertFalse(infos.first?.isContract == true)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testInfosTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testInfoTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2

        //act
        api.eth.info(addresses: [address, address2]) { result in
            switch result {
            case let .success(infos):
                //assert
                XCTAssertTrue(!infos.isEmpty)
                XCTAssertFalse(infos.first?.isContract == true)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testInfoContractTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testInfoContractTest")
        let address = ethContractAddress

        //act
        api.eth.info(addresses: [address]) { result in
            switch result {
            case let .success(infos):
                //assert
                XCTAssertTrue(!infos.isEmpty)
                XCTAssertTrue(infos.first?.isContract == true)
            case let .failure(error):
                //assert
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testInfoFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testInfoFailedTest")
        let address = ethInvalidAddress

        //act
        api.eth.info(addresses: [address]) { result in
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
    
    func testHistoryAddressTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testHistoryAddressTest")
        let address = ethAddressWithBalance
        let skip = 0
        let limit = 10
        let positive = true

        //act
        api.eth.transfers(skip: skip, limit: limit, addresses: [address], positive: positive) { result in
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
    
    func testHistoryAddressesTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testHistoryAddressTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2
        let skip = 0
        let limit = 10
        let positive = true

        //act
        api.eth.transfers(skip: skip, limit: limit, addresses: [address, address2], positive: positive) { result in
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
    
    func testHistoryAddressFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testHistoryAddressFailedTest")
        let address = ethInvalidAddress
        let skip = 0
        let limit = 10
        let positive = true

        //act
        api.eth.transfers(skip: skip, limit: limit, addresses: [address], positive: positive) { result in
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
    
    func testExternalHistoryAddressTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressTest")
        let address = ethAddressWithBalance
        let skip = 0
        let limit = 10
        let pending: EthereumPendingType = .include

        //act
        api.eth.externalTransfers(skip: skip, limit: limit, addresses: [address], pending: pending) { result in
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
    
    func testExternalHistoryAddressesTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2
        let skip = 0
        let limit = 10
        let pending: EthereumPendingType = .include

        //act
        api.eth.externalTransfers(skip: skip, limit: limit, addresses: [address, address2], pending: pending) { result in
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
    
    func testExternalHistoryAddressFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressFailedTest")
        let address = ethInvalidAddress
        let skip = 0
        let limit = 10
        let pending: EthereumPendingType = .include

        //act
        api.eth.externalTransfers(skip: skip, limit: limit, addresses: [address], pending: pending) { result in
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
    
    func testTransfersTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTransfersTest")
        let fromAddress = ethAddressWithBalance
        let toAddress = ethAddressWithBalance2
        let skip = 0
        let limit = 10
        let pending: EthereumPendingType = .include

        //act
        api.eth.transactions(skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress, pending: pending) { result in
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
    
    func testTransfersFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTransfersFailedTest")
        let fromAddress = ethInvalidAddress
        let toAddress = ethAddressWithBalance2
        let skip = 0
        let limit = 10
        let pending: EthereumPendingType = .include

        //act
        api.eth.transactions(skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress, pending: pending) { result in
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
    
    func testTransactionTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTransactionTest")
        let hash = transactionHash

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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTransactionFailedTest() {
        //arrange
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTransactionReceiptTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTransactionReceiptTest")
        let hash = transactionHash

        //act
        api.eth.transactionReceipt(hash: hash) { result in
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
    
    func testTransactionReceiptFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTransactionReceiptFailedTest")
        let hash = ethInvalidAddress

        //act
        api.eth.transactionReceipt(hash: hash) { result in
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
    
    func testContractInfoTest() {
        //arrange
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testContractInfoFailedTest() {
        //arrange
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTokensBalancesTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTokensBalancesTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2
        let skip = 0
        let limit = 10
        
        //act
        api.eth.tokensBalance(addresses: [address, address2], skip: skip, limit: limit, token: nil) { result in
            switch result {
            case let .success(balances):
                //assert
                XCTAssertTrue(!balances.items.isEmpty)
                print(balances.items)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTokensBalancesForSpecificTokenTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTokensBalancesTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2
        let token = ethTokenWithBalances
        let skip = 0
        let limit = 10
        
        //act
        api.eth.tokensBalance(addresses: [address, address2], skip: skip, limit: limit, token: token) { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTokensBalanceFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTokensBalanceFailedTest")
        let address = ethInvalidAddress
        let skip = 0
        let limit = 10
        //act
        api.eth.tokensBalance(addresses: [address], skip: skip, limit: limit, token: nil) { result in
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
    
    func testTokenHistoryTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTokenHistoryTest")
        let address = ethAddressWithBalance
        let tokenAddress = ethContractAddress
        let skip = 0
        let limit = 10
        //act
        api.eth.tokenTransfers(tokenAddress: tokenAddress, addresses: [address], skip: skip, limit: limit) { result in
            switch result {
            case let .success(balances):
                //assert
                XCTAssertTrue(!balances.addresses.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTokensHistoryTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTokenHistoryTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2
        let tokenAddress = ethContractAddress
        let skip = 0
        let limit = 10
        //act
        api.eth.tokenTransfers(tokenAddress: tokenAddress, addresses: [address, address2], skip: skip, limit: limit) { result in
            switch result {
            case let .success(balances):
                //assert
                XCTAssertTrue(!balances.addresses.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTokenHistoryFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTokenHistoryFailedTest")
        let address = ethInvalidAddress
        let tokenAddress = ethInvalidAddress
        let skip = 0
        let limit = 10
        //act
        api.eth.tokenTransfers(tokenAddress: tokenAddress, addresses: [address], skip: skip, limit: limit) { result in
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
    
    func testTokenInfoTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTokenInfoTest")
        let address = ethContractAddress

        //act
        api.eth.tokenInfo(address: address) { result in
            switch result {
            case let .success(info):
                //assert
                XCTAssertTrue(!info.createTransactionHash.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTokenInfoFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testTokenInfoFailedTest")
        let address = ethInvalidAddress

        //act
        api.eth.tokenInfo(address: address) { result in
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
    
    func testQueryTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testQueryTest")
        let query = "0x"
        let skip = 0
        let limit = 20
        let types: [EthereumTokenType] = [.ERC20]
        //act
        api.eth.tokenSearch(query: query, skip: skip, limit: limit, types: types) { result in
            switch result {
            case let .success(query):
                //assert
                XCTAssertTrue(!query.items.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testQueryWithTypesTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testQueryTest")
        let query = ""
        let skip = 0
        let limit = 10
        let types: [EthereumTokenType] = [.ERC20, .ERC721]
        //act
        api.eth.tokenSearch(query: query, skip: skip, limit: limit, types: types) { result in
            switch result {
            case let .success(query):
                //assert
                XCTAssertTrue(!query.items.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        }
        
        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testQueryWithQueryTest() {
         //arrange
         let expectation = XCTestExpectation(description: "testQueryTest")
         let query = ""
         let skip = 0
         let limit = 10
         let types: [EthereumTokenType] = [.ERC20, .ERC721]
         //act
         api.eth.tokenSearch(query: query, skip: skip, limit: limit, types: types) { result in
             switch result {
             case let .success(query):
                 //assert
                 XCTAssertTrue(!query.items.isEmpty)
             case let .failure(error):
                 //asserts
                 XCTAssertThrowsError(error)
             }
             expectation.fulfill()
         }

         //assert
         wait(for: [expectation], timeout: testTimeout)
     }
    
    func testQueryFailedTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testQueryFailedTest")
        let query = ""
        let skip = 0
        let limit = 10
        let types: [EthereumTokenType] = []

        //act
        api.eth.tokenSearch(query: query, skip: skip, limit: limit, types: types) { result in
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
    
//    func testSendRawTransactionTest() {
//         //arrange
//
//         let expectation = XCTestExpectation(description: "testSendRawTransactionTest")
//         let tx = "0xf86a2c84773594008252089446ba2677a1c982b329a81f60cf90fba2e8ca9fa8872386f26fc10000801ba09f5852f83f48dc86db7d4f5f26514bdd0ef813aa15ec3a7d874354ee99cf017da06a8aa2ef22ab41377cb30c5d48d208476491f687cf20945f91f35591a94a33d3"
//         //act
//         api.eth.sendRaw(transaction: tx) { result in
//             switch result {
//             case .success:
//                 break
//             case let .failure(error):
//                 //asserts
//                 XCTAssertThrowsError(error)
//             }
//             expectation.fulfill()
//         }
//
//         //assert
//         wait(for: [expectation], timeout: testTimeout)
//     }
    
    func testSendRawTransactionFailedTest() {
         //arrange
         let expectation = XCTestExpectation(description: "testSendRawTransactionTest")
         let tx = "invalid transaction hash"
         //act
         api.eth.sendRaw(transaction: tx) { result in
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
         let tx = "0xf86b24843b9aca0082520894b0202ebbf797dd61a3b28d5e82fba2523edc1a9b880de0b6b3a7640000801ba07cf766c8ec0c2d24e98d4fd6ec8af69dadc7fc8f9ba18e1476705f016ceeda6ea0375633e6bfe837b21e4ca97f8751c6e6e9a5e4ae06bb00d83f6337ca5e714cfb"
         //act
         api.eth.decodeRaw(transaction: tx) { result in
             switch result {
             case let .success(result):
                 //assert
                XCTAssertTrue(!result.data.isEmpty)
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
         api.eth.decodeRaw(transaction: tx) { result in
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
    
    func testCallContractTest() {
         //arrange
        let expectation = XCTestExpectation(description: "testCallContractFailedTest")
        let sender = "0x141d5937C7b0e4fB4C535c900C0964B4852007eA"
        let amount = 0
        let bytecode = "0x899426490000000000000000000000000000000000000000000000000000000000000001"
        let address = "0xf36c145eff2771ea22ece5fd87392fc8eeae719c"
        
         //act
         api.eth.callContract(sender: sender, amount: amount, bytecode: bytecode, address: address) { result in
             switch result {
             case let .success(result):
                 //assert
                XCTAssertTrue(!result.isEmpty)
             case let .failure(error):
                 //asserts
                 XCTAssertThrowsError(error)
             }
             expectation.fulfill()
         }

         //assert
         wait(for: [expectation], timeout: testTimeout)
     }
    
    func testCallContractFailedTest() {
         //arrange
        let expectation = XCTestExpectation(description: "testCallContractFailedTest")
        let sender = "invalid sender"
        let amount = 1
        let bytecode = "invalid bytecode"
        let address = "invalid address"
        
         //act
         api.eth.callContract(sender: sender, amount: amount, bytecode: bytecode, address: address) { result in
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
    
    func testContractLogsTest() {
        //arrange
        let expectation = XCTestExpectation(description: "testCallContractFailedTest")
        let fromBlock = ETHTestConstants.contractLogsFromBlock
        let toBlock = ETHTestConstants.contractLogsToBlock
        let addresses = ETHTestConstants.contractLogsAddresses
        let topics: [String] = [String]()
       
        //act
        api.eth.contractLogs(fromBlock: fromBlock, toBlock: toBlock, addresses: addresses, topics: topics, completion: { result in
            switch result {
            case let .success(result):
                //assert
               XCTAssertTrue(!result.isEmpty)
            case let .failure(error):
                //asserts
                XCTAssertThrowsError(error)
            }
            expectation.fulfill()
        })

        //assert
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testGetBlockByNumber() {
        //arrange
        let expectation = XCTestExpectation(description: "testGetBlockByNumber")
        let number = blockNumber
        let hash = blockHash
        
        //act
        api.eth.block(numberOrHash: String(number), completion: { result in
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
        let number = blockNumber
        let hash = blockHash
        
        //act
        api.eth.block(numberOrHash: hash, completion: { result in
            switch result {
            case let .success(result):
                //assert
                XCTAssertTrue(result.number == number)
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
        let limit = 10
        
        //act
        api.eth.blocks(skip: skip, limit: limit, completion: { result in
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
    
//    func testSubscribePushNotifications() {
//        //assert
//        let addresses = [ethAddressWithBalance, ethAddressWithBalance2]
//        let token = firebaseToken
//        let types: [CryptoNotificationType] = [.outgoing, .incoming]
//        let expectation = XCTestExpectation(description: "testSubscribePushNotifications")
//
//        //act
//        api.eth.subscribePushNotifications(addresses: addresses, firebaseToken: token, types: types) { result in
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
//        let addresses = [ethAddressWithBalance, ethAddressWithBalance2]
//        let token = firebaseToken
//        let types: [CryptoNotificationType] = [.outgoing, .incoming]
//        let expectation = XCTestExpectation(description: "testUnsubscribePushNotifications")
//
//        //act
//        api.eth.unsubscribePushNotifications(addresses: addresses, firebaseToken: token, types: types) { result in
//            switch result {
//            case .success(let model):
//                //assert
//                XCTAssertEqual(model.token, token)
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
        let addresses = [ethAddressWithBalance, ethAddressWithBalance2]
        let firebaseToken = "invalid token"
        let types: [CryptoNotificationType] = [.outgoing, .incoming]
        let expectation = XCTestExpectation(description: "testSubscribePushNotificationsFailed")
        
        //act
        api.eth.subscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken, types: types) { result in
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
    
//    func testSubscribeTokenPushNotifications() {
//        //assert
//        let addresses = [ethAddressWithBalance, ethAddressWithBalance2]
//        let token = firebaseToken
//        let tokenAddress = ethTokenWithBalances
//        let types: [CryptoNotificationType] = [.outgoing, .incoming]
//        let expectation = XCTestExpectation(description: "testSubscribeTokenPushNotifications")
//
//        //act
//        api.eth.subscribeTokenPushNotifications(addresses: addresses, firebaseToken: token, tokenAddress: tokenAddress, types: types) { result in
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
//    func testUnsubscribeTokenPushNotifications() {
//        //assert
//        let addresses = [ethAddressWithBalance, ethAddressWithBalance2]
//        let token = firebaseToken
//        let tokenAddress = ethTokenWithBalances
//        let types: [CryptoNotificationType] = [.outgoing, .incoming]
//        let expectation = XCTestExpectation(description: "testUnsubscribeTokenPushNotifications")
//
//        //act
//        api.eth.unsubscribeTokenPushNotifications(addresses: addresses, firebaseToken: token, tokenAddress: tokenAddress, types: types) { result in
//            switch result {
//            case .success(let model):
//                //assert
//                XCTAssertEqual(model.token, token)
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
    
    func testSubscribeTokenPushNotificationsFailed() {
        //assert
        let addresses = [ethAddressWithBalance, ethAddressWithBalance2]
        let firebaseToken = "invalid token"
        let tokenAddress = ethTokenWithBalances
        let types: [CryptoNotificationType] = [.outgoing, .incoming]
        let expectation = XCTestExpectation(description: "testSubscribeTokenPushNotificationsFailed")
        
        //act
        api.eth.subscribeTokenPushNotifications(addresses: addresses, firebaseToken: firebaseToken, tokenAddress: tokenAddress, types: types) { result in
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
