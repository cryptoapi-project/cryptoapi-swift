//
//  BTCTransactionReceiptResponseModel.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct BTCTransactionsResponseModel {
    public let blockHeightOfHash: String
    public let skip: Int
    public let limit: Int
    public let fromAddress: String
    public let toAddress: String
    public let items: [BTCTransactionByHashResponseModel]
}

extension BTCTransactionsResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case blockHeightOfHash = "block_height_or_hash"
        case skip
        case limit
        case fromAddress = "from"
        case toAddress = "to"
        case items
    }
}

public struct BTCTransactionByHashResponseModel {
    public let blockHeight: Int
    public let blockHash: String
    public let blockTime: String
    public let mempoolTime: String?
    public let fee: Int
    public let size: Int
    public let transactionIndex: Int
    public let lockTime: Int
    public let value: Int
    public let hash: String
    public let inputCount: Int
    public let outputCount: Int
    public let inputs: [TransactionInput]
    public let outputs: [TransactionOutput]
}

extension BTCTransactionByHashResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case blockHeight = "block_height"
        case blockHash = "block_hash"
        case blockTime = "block_time"
        case mempoolTime = "mempool_time"
        case fee
        case size
        case transactionIndex = "transaction_index"
        case lockTime = "n_lock_time"
        case value
        case hash
        case inputCount = "input_count"
        case outputCount = "output_count"
        case inputs
        case outputs
    }
}

public struct TransactionInput {
    public let address: String
    public let prevTransactionHash: String
    public let outputIndex: Int
    public let sequenceNumber: Int
    public let script: String
}

extension TransactionInput: Codable {
    enum CodingKeys: String, CodingKey {
        case address
        case prevTransactionHash = "previous_transaction_hash"
        case outputIndex = "output_index"
        case sequenceNumber = "sequence_number"
        case script
    }
}

public struct TransactionOutput: Codable {
    public let address: String
    public let satoshis: Int
    public let script: String
}
