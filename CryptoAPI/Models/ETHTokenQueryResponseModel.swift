//
//  ETHTokenQueryResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTokensQueryResponseModel: Codable {
    public let query: String?
    public let skip: Int
    public let limit: Int
    public let count: Int
    public let items: [ETHTokenQueryResponseModel]
    public let types: [String]
}

public struct ETHTokenQueryResponseModel {
    public let address: String
    public let createTransactionHash: String
    public let status: Bool
    public let type: String
    public let info: ETHTokenQueryItemResponseModel
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

public struct ETHTokenQueryItemResponseModel {
    public let decimals: String
    public let totalSupply: String
    public let symbol: String
    public let name: String
}

extension ETHTokenQueryItemResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case decimals
        case totalSupply = "total_supply"
        case symbol
        case name
    }
}
