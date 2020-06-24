//
//  EthereumPendingType.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 6/21/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

/// Ethereum pending transaction's parameter
public enum EthereumPendingType: String, Codable {
    /// Include pending transactions
    case include
    
    /// Not include pending transactions
    case exclude
    
    /// Only pending transactions
    case only
}
