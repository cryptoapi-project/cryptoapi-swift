//
//  ETHTokenQueryResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTokensQueryResponseModel: Codable {
    let query: String?
    let skip: Int
    let limit: Int
    let count: Int
    let items: [ETHTokenQueryResponseModel]
    let types: [String]
}

public struct ETHTokenQueryResponseModel {
    let address: String
    let createTransactionHash: String
    let status: Bool
    let type: String
    let info: ETHTokenQueryItemResponseModel
}

extension ETHTokenQueryResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case address
        case createTransactionHash = "create_transaction_hash"
        case status
        case type
        case info
    }
}

public struct ETHTokenQueryItemResponseModel: Codable {
    let decimals: String
    let totalSupply: String
    let symbol: String
    let name: String
}
