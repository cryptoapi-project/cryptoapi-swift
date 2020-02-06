//
//  BCHTestConstants.swift
//  CryptoAPITests
//
//  Created by Artemy Markovsky on 1/31/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

enum BCHTestConstants {
    static let authToken = "5de552d7efc6ff2e1b09d946cc5263e346003a93ab28bf2ffeb24979da85a1f5" // Dev
//    static let authToken = "74e24f797dc46915de69f97e8383f4a31cb8a6dbf45fe9ea" // Stage
    
    static let timeout: TimeInterval = 30
    
    static let BCHAddressWithBalance = "bchtest:pptaejry4psdwdq8akh8zxgmdy7c2zwwave0kla5n9"
    static let BCHAddressWithBalance2 = "bchtest:qqrkr66xpllee6ujzcuexzvd3kkhtc6gqu9d7m8q33"
    static let BCHInvalidAddress = "mjTXbyDS41qWNNkvXi8H5UgmMgTzrdMh7t"
    static let BCHTransactionHash = "2db38ea5b43f4242e90a3d92abe3c32fcef906df7df4a5e78c788b0c457f40d8"
    
    static let BCHBlockHeight = 1358237
    static let BCHBlockHash = "000000000240b727260c9db1dc5399c547391345e54c953dd4e663a69fda3818"
}
