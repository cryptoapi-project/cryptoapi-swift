//
//  ETHBalanceResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 15.01.2019.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

public struct ETHBalanceResponseModel: Codable {
    let balance: String
    let address: String
}
