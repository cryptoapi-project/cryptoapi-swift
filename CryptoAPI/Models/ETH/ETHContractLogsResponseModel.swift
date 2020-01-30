//
//  ETHContractLogsResponseModel.swift
//  CryptoAPI
//
//  Created by Vladimir Sharaev on 24.01.2020.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct ETHContractLogsResponseModel {
    public let address: String
    public let data: String
    public let topics: [String]
    public let logIndex: Int
    public let transactionHash: String
    public let transactionIndex: Int
    public let blockHash: String
    public let blockNumber: Int
}

extension ETHContractLogsResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case address
        case data
        case topics
        case logIndex = "log_index"
        case transactionHash = "transaction_hash"
        case transactionIndex = "transaction_index"
        case blockHash = "block_hash"
        case blockNumber = "block_number"
    }
}
