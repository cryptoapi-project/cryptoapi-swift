//
//  TestConstants.swift
//  CryptoAPITests
//
//  Created by Vladimir Sharaev on 03.12.2019.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

enum TestConstants {
    static let authToken = "f25dad2aacc926604190852e94e5e9a705a72a8439281716" // Dev
//    static let authToken = "74e24f797dc46915de69f97e8383f4a31cb8a6dbf45fe9ea" // Stage
    
    static let timeout: TimeInterval = 30
    
    static let ethAddressWithBalance = "0x46Ba2677a1c982B329A81f60Cf90fBA2E8CA9fA8"
    static let ethAddressWithBalance2 = "0xCC1326778Ea3B172DDbfedD771219Ef0DB782265"
    static let ethTokenWithBalances = "0x45312171c43da4a6aa402d0a50f6e25d302a8ffd"
    static let ethContractAddress = "0x2c33b034405b49171806698163d1f48be7c956de"
    static let transactionHash = "0xda33d43f2754d8fbd3345e933ec024dc881d5cd1c7e0219e8d6b106906223485"
    
    static let contractLogsFromBlock = 5838000
    static let contractLogsToBlock = 5849000
    static let contractLogsAddresses = ["0x9c67fd4eaf0497f9820a3fbf782f81d6b6dc4baa"]
    
    static let blockNumber = 5870510
    static let blockHash = "0x0d424fbc11ce52261db0d97dec9a26136fdefcb55bde08f247318f8c39afb9ca"
    
    // BTH
    static let bthAddressWithBalance = "bchtest:pptaejry4psdwdq8akh8zxgmdy7c2zwwave0kla5n9"
    static let bthAddressWithBalance2 = "bchtest:qqrkr66xpllee6ujzcuexzvd3kkhtc6gqu9d7m8q33"
    static let bthTransactionHash = "5349ec90c7d4d04b0ae32c23f881fa813043c270c8f377ccfbf4510189e0c777"
    
    static let bthBlockHeight = 1356613
    static let bthBlockHash = "000000000008ecf38dfa49aa5619ee2c2d3f00d6f66a6bf54d2659965a12ac19"
}
