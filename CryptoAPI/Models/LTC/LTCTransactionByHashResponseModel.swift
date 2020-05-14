//
//  LTCTransactionByHashResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct LTCTransactionByHashResponseModel {
    public let blockHeight: Int
    public let blockHash: String?
    public let blockTime: String?
    public let mempoolTime: String?
    public let fee: Int
    public let size: Int
    public let transactionIndex: Int
    public let lockTime: Int
    public let value: Int
    public let hash: String
    public let inputCount: Int
    public let outputCount: Int
    public let inputs: [LTCTransactionInputResponseModel]
    public let outputs: [LTCTransactionOutputResponseModel]
}

extension LTCTransactionByHashResponseModel: Codable {
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

public struct LTCTransactionInputResponseModel {
    public let prevTransactionHash: String
    public let outputIndex: Int
    public let sequenceNumber: Int
    public let script: String
    public let address: String?
    public let satoshis: Int?
}

extension LTCTransactionInputResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case prevTransactionHash = "previous_transaction_hash"
        case outputIndex = "output_index"
        case sequenceNumber = "sequence_number"
        case script
        case address
        case satoshis
    }
}

public struct LTCTransactionOutputResponseModel: Codable {
    public let address: String
    public let satoshis: Int
    public let script: String?
}
