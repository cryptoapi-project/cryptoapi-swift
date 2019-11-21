//
//  ETHTransactionsResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTransactionsResponseModel: Codable {
    public let items: [ETHTransactionResponseModel]
    public let total: Int
}

public struct ETHTransactionResponseModel {
    public let blockHash: String
    public let blockNumber: Int
    public let utc: String
    public let from: String
    public let gas: Int
    public let gasPrice: String
    public let hash: String
    public let input: String
    public let nonce: Int
    public let to: String
    public let value: String
    public let transactionIndex: Int
    public let v: String
    public let s: String
    public let r: String
    public let internalTransactions: [String]
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
