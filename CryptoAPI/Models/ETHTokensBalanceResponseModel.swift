//
//  ETHTokensBalanceResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTokensBalanceResponseModel: Codable {
    let items: [ETHTokenBalanceResponseModel]
    let total: Int
}

public struct ETHTokenBalanceResponseModel: Codable {
    let address: String
    let balance: String
}
