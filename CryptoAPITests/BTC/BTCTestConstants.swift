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
    static let authToken = "5de552d7efc6ff2e1b09d946cc5263e346003a93ab28bf2ffeb24979da85a1f5" // Stage
    
    static let timeout: TimeInterval = 30

    static let btcAddressWithBalance = "n2RSXcN65UdAuEFUQGVcBftxarTaAfAfrZ"
    static let btcAddressWithBalance2 = "mojkgACmWsNk185EvkR3vapnehemvdvUPQ"
    static let btcInvalidAddress = "mjTXbyDS41qWNNkvXi8H5UgmMgTzrdMh7t"
    static let btcTransactionHash = "ec4f1b151096f1195420e016ae31798b919009c5f57364dbdf5e0d46f2108710"
    
    static let btcBlockHeight = 1665137
    static let btcBlockHash = "00000000000227a515172c920d221b55801bbeac2ad4915799685cf3cfc72407"
}
