//
//  BTCTestConstants.swift
//  CryptoAPITests
//
//  Created by Artemy Markovsky on 1/31/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

enum BTCTestConstants {
    //static let authToken = "f25dad2aacc926604190852e94e5e9a705a72a8439281716" // Dev
    static let authToken = "74e24f797dc46915de69f97e8383f4a31cb8a6dbf45fe9ea" // Stage
    
    static let timeout: TimeInterval = 30

    static let btcAddressWithBalance = "n2RSXcN65UdAuEFUQGVcBftxarTaAfAfrZ"
    static let btcAddressWithBalance2 = "mojkgACmWsNk185EvkR3vapnehemvdvUPQ"
    static let btcInvalidAddress = "mjTXbyDS41qWNNkvXi8H5UgmMgTzrdMh7t"
    static let btcTransactionHash = "7f827d4a3ae3b6e408fa1737f12f9dbfa2bb8fd79e0e3e63256a6e78310790a4"
    
    static let btcBlockHeight = 615204
    static let btcBlockHash = "0000000000883391042526772d733064299777882c1a3fc322e7376c1f11e441"
}
