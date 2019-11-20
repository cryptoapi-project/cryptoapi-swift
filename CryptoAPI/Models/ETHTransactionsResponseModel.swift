//
//  ETHTransactionsResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTransactionsResponseModel: Codable {
    let items: [ETHTransactionResponseModel]
    let total: Int
}

public struct ETHTransactionResponseModel {
    let blockHash: String
    let blockNumber: Int
    let utc: String
    let from: String
    let gas: Int
    let gasPrice: String
    let hash: String
    let input: String
    let nonce: Int
    let to: String
    let value: String
    let transactionIndex: Int
    let v: String
    let s: String
    let r: String
    let internalTransactions: [String]
}

extension ETHTransactionResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case blockNumber = "block_number"
        case utc
        case from
        case gas
        case gasPrice = "gas_price"
        case hash
        case input
        case nonce
        case to
        case value
        case transactionIndex = "transaction_index"
        case v
        case s
        case r
        case internalTransactions = "internal_transactions"
    }
}
