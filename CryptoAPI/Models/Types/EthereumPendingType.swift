//
//  EthereumPendingType.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 6/21/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public enum EthereumPendingType: String, Codable {
    case include
    case exclude
    case only
}
