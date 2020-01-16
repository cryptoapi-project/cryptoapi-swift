//
//  ETHTokenInfoResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTokenInfoResponseModel {
    public let address: String
    public let type: String
    public let createTransactionHash: String
    public let holdersCount: Int
}

extension ETHTokenInfoResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case address
        case type
        case createTransactionHash = "create_transaction_hash"
        case holdersCount = "holders_count"
    }
}

public struct ETHTokenInfoDetailsResponseModel {
    public let name: String
    public let symbol: String
    public let decimals: String
    public let totalSupply: String
}

extension ETHTokenInfoDetailsResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case decimals
        case totalSupply = "total_supply"
    }
}
