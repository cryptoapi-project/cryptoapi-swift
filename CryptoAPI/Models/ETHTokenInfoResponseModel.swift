//
//  ETHTokenInfoResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTokenInfoResponseModel {
    let address: String
    let type: String
    let name: String
    let symbol: String
    let decimals: String
    let totalSupply: String
    let createTransactionHash: String
    let holdersCount: Int
}

extension ETHTokenInfoResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case address
        case type
        case name
        case symbol
        case decimals
        case totalSupply
        case createTransactionHash = "create_transaction_hash"
        case holdersCount = "holders_count"
    }
}
