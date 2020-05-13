//
//  ETHTransactionsResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTransactionsResponseModel: Codable {
    public let items: [ETHTransactionResponseModel]
    public let count: Int
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
    public let internalTransactions: [ETHInternalTransaction]
    public let confirmations: Int?
    public let status: Bool?
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
        case confirmations
        case status
    }
}

public struct ETHTransactionByHashResponseModel {
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
    public let internalTransactions: [ETHInternalTransaction]
    public let receipt: ETHTransactionByHashReceiptResponseModel
}

extension ETHTransactionByHashResponseModel: Codable {
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
        case receipt
    }
}

public struct ETHTransactionByHashReceiptResponseModel {
    public let contractAddress: String?
    public let gasUsed: Int
    public let cumulativeGasUsed: Int
    public let logs: [ETHContractLogsResponseModel]
    public let status: Bool
}

extension ETHTransactionByHashReceiptResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case contractAddress = "contract_address"
        case gasUsed = "gas_used"
        case cumulativeGasUsed = "cumulative_gas_used"
        case logs
        case status
    }
}

public struct ETHTransactionReceiptResponseModel {
    public let blockHash: String
    public let blockNumber: Int
    public let contractAddress: String?
    public let gasUsed: Int
    public let cumulativeGasUsed: Int
    public let logs: [ETHContractLogsResponseModel]
    public let status: Bool
    public let from: String
    public let hash: String
    public let to: String
    public let transactionIndex: Int
}

extension ETHTransactionReceiptResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case blockNumber = "block_number"
        case contractAddress = "contract_address"
        case gasUsed = "gas_used"
        case cumulativeGasUsed = "cumulative_gas_used"
        case logs
        case status
        case from
        case hash
        case to
        case transactionIndex = "transaction_index"
    }
}
