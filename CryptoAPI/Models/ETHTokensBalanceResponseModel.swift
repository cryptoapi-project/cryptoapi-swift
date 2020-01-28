//
//  ETHTokensBalanceResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTokensBalanceResponseModel: Codable {
    public let items: [ETHTokenBalanceResponseModel]
    public let total: Int
}

public struct ETHTokenBalanceResponseModel: Codable {
    public let address: String
    public let balance: String
    public let holder: String
}
