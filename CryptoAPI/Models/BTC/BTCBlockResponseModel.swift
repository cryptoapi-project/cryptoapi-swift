//
//  BTCBlockResponseModel.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct BTCBlockResponseModel {
    public let height: Int
    public let hash: String
    public let bits: Int
    public let time: String
    public let merkleRoot: String
    public let nonce: Int
    public let size: Int
    public let version: Int 
    public let prevBlockHash: String
    public let nextBlockHash: String
    public let reward: Int
    public let transactionCount: Int
    public let transactions: [String]
}

extension BTCBlockResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case height
        case hash
        case bits
        case time
        case merkleRoot = "merkle_root"
        case nonce
        case size
        case version
        case prevBlockHash = "previous_block_hash"
        case nextBlockHash = "next_block_hash"
        case reward
        case transactionCount = "transaction_count"
        case transactions
    }
}

public struct BTCBlocksResponseModel: Codable {
    public let skip: Int
    public let limit: Int
    public let count: Int
    public let items: [BTCBlockResponseModel]
}
