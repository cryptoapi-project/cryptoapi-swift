//
//  ETHBlockResponseModel.swift
//  CryptoAPI
//
//  Created by Vladimir Sharaev on 27.01.2020.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct ETHBlockResponseModel {
    public let size: Int
    public let difficulty: Int
    public let totalDifficulty: Int
    public let uncles: [String]
    public let number: Int
    public let hash: String
    public let parentHash: String
    public let nonce: String
    public let sha3Uncles: String
    public let logsBloom: String
    public let transactionRoot: String
    public let stateRoot: String
    public let receiptsRoot: String
    public let miner: String
    public let mixHash: String
    public let extraData: String
    public let gasLimit: String
    public let gasUsed: Int
    public let utc: String
    public let countTransactions: Int
    public let reward: String
}

extension ETHBlockResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case size
        case difficulty
        case totalDifficulty = "total_difficulty"
        case uncles
        case number
        case hash
        case parentHash = "parent_hash"
        case nonce
        case sha3Uncles = "sha3_uncles"
        case logsBloom = "logs_bloom"
        case transactionRoot = "transaction_root"
        case stateRoot = "state_root"
        case receiptsRoot = "receipts_root"
        case miner
        case mixHash = "mix_hash"
        case extraData = "extra_data"
        case gasLimit = "gas_limit"
        case gasUsed = "gas_used"
        case utc
        case countTransactions = "count_transactions"
        case reward
    }
}

public struct ETHBlocksResponseModel: Codable {
    public let skip: Int
    public let limit: Int
    public let count: Int
    public let items: [ETHBlockResponseModel]
}
