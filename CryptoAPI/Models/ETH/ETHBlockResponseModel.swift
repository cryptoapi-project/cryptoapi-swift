//
//  ETHBlockResponseModel.swift
//  CryptoAPI
//
//  Created by Vladimir Sharaev on 27.01.2020.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct ETHBlockResponseModel {
    let size: Int
    let difficulty: Int
    let totalDifficulty: Int
    let uncles: [String]
    let number: Int
    let hash: String
    let parentHash: String
    let nonce: String
    let sha3Uncles: String
    let logsBloom: String
    let transactionRoot: String
    let stateRoot: String
    let receiptsRoot: String
    let miner: String
    let mixHash: String
    let extraData: String
    let gasLimit: String
    let gasUsed: Int
    let utc: String
    let transactions: [String]
    let reward: String
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
        case transactions
        case reward
    }
}

public struct ETHBlocksResponseModel: Codable {
    let skip: Int
    let limit: Int
    let count: Int
    let items: [ETHBlockResponseModel]
}
