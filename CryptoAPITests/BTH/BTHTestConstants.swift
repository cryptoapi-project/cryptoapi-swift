//
//  BTHTestConstants.swift
//  CryptoAPITests
//
//  Created by Artemy Markovsky on 1/31/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

enum BTHTestConstants {
    static let authToken = "f25dad2aacc926604190852e94e5e9a705a72a8439281716" // Dev
//    static let authToken = "74e24f797dc46915de69f97e8383f4a31cb8a6dbf45fe9ea" // Stage
    
    static let timeout: TimeInterval = 30
    
    static let bthAddressWithBalance = "bchtest:pptaejry4psdwdq8akh8zxgmdy7c2zwwave0kla5n9"
    static let bthAddressWithBalance2 = "bchtest:qqrkr66xpllee6ujzcuexzvd3kkhtc6gqu9d7m8q33"
    static let bthInvalidAddress = "mjTXbyDS41qWNNkvXi8H5UgmMgTzrdMh7t"
    static let bthTransactionHash = "5349ec90c7d4d04b0ae32c23f881fa813043c270c8f377ccfbf4510189e0c777"
    
    static let bthBlockHeight = 1356613
    static let bthBlockHash = "000000000008ecf38dfa49aa5619ee2c2d3f00d6f66a6bf54d2659965a12ac19"
}
