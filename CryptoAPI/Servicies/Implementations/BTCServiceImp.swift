//
//  BTCServiceImp.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class BTCServiceImp: BTCService {    
    let networkAdapter: BTCNetworkAdapter
    
    public init(networkAdapter: BTCNetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
}
