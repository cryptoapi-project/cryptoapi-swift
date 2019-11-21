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
    let testTimeout: TimeInterval = 10

    func testGetBalance() {
        //arrange
        let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testInfoTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testInfoTest")
        let address = ethAddressWithBalance

        //act
        //act
        api.eth.info(addresses: [address]) { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testInfosTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testInfoTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2

        //act
        //act
        api.eth.info(addresses: [address, address2]) { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testInfoContractTest() {
        //arrange
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testInfoContractTest")
        let address = ethContractAddress

        //act
        //act
        api.eth.info(addresses: [address]) { result in
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testInfoFailedTest() {
        //arrange
        let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testHistoryAddressTest")
        let address = ethAddressWithBalance
        let skip = 0
        let limit = 10
        let positive = ""

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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testHistoryAddressTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2
        let skip = 0
        let limit = 10
        let positive = ""

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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testHistoryAddressFailedTest")
        let address = ethInvalidAddress
        let skip = 0
        let limit = 10
        let positive = ""

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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressTest")
        let address = ethAddressWithBalance
        let skip = 0
        let limit = 10

        //act
        api.eth.externalTransfers(skip: skip, limit: limit, addresses: [address]) { result in
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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressTest")
        let address = ethAddressWithBalance
        let address2 = ethAddressWithBalance2
        let skip = 0
        let limit = 10

        //act
        api.eth.externalTransfers(skip: skip, limit: limit, addresses: [address, address2]) { result in
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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testExternalHistoryAddressFailedTest")
        let address = ethInvalidAddress
        let skip = 0
        let limit = 10

        //act
        api.eth.externalTransfers(skip: skip, limit: limit, addresses: [address]) { result in
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTokensBalancesTest() {
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
        wait(for: [expectation], timeout: testTimeout)
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
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func testTokenHistoryTest() {
        //arrange
        let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testTokenHistoryFailedTest")
        let address = ethInvalidAddress
        let tokenAddress = ethContractAddress
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
        let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testQueryTest")
        let query = ""
        let skip = 0
        let limit = 10
        let types = ["ERC20"]
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
         let api = CtyptoAPI.default
         let expectation = XCTestExpectation(description: "testQueryTest")
         let query = ""
         let skip = 0
         let limit = 10
         let types = ["ERC20", "ERC721"]
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
         let api = CtyptoAPI.default
         let expectation = XCTestExpectation(description: "testQueryTest")
         let query = ""
         let skip = 0
         let limit = 10
         let types = ["ERC20", "ERC721"]
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
        let api = CtyptoAPI.default
        let expectation = XCTestExpectation(description: "testQueryFailedTest")
        let query = ""
        let skip = 0
        let limit = 10
        let types: [String] = []

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
//         let api = CtyptoAPI.default
//         let expectation = XCTestExpectation(description: "testSendRawTransactionTest")
//         let tx = "0xf86b24843b9aca0082520894b0202ebbf797dd61a3b28d5e82fba2523edc1a9b880de0b6b3a7640000801ba07cf766c8ec0c2d24e98d4fd6ec8af69dadc7fc8f9ba18e1476705f016ceeda6ea0375633e6bfe837b21e4ca97f8751c6e6e9a5e4ae06bb00d83f6337ca5e714cfb"
//         //act
//         api.eth.sendRaw(transaction: tx) { result in
//             switch result {
//             case let .success(result):
//                 //assert
//                 XCTAssertTrue(!result.isEmpty)
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
         let api = CtyptoAPI.default
         let expectation = XCTestExpectation(description: "testSendRawTransactionTest")
         let tx = "invalidc tion hash"
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
         let api = CtyptoAPI.default
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
         let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
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
        let api = CtyptoAPI.default
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
}
