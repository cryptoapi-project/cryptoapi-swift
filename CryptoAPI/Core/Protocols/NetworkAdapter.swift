//
//  ETHNetworkAdapter.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 6/12/2019.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

enum MapError: Swift.Error, Equatable {
    /// Indicates that date is invalid format
    case invalidFormat
}

protocol NetworkAdapter {
    func balance(address: String,
                 completion: @escaping (() throws -> (BalanceModel)) -> Void)
}
