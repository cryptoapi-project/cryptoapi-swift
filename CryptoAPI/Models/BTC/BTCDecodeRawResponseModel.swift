//
//  BTCDecodeRawResponseModel.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct BTCDecodeRawResponseModel {
    public let hash: String
    public let version: Int
    public let lockTime: Int
    public let inputs: [Input]
    public let outputs: [Output]
}

extension BTCDecodeRawResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case hash
        case version
        case lockTime = "n_lock_time"
        case inputs
        case outputs
    }
}


public struct Input {
    public let prevTransactionHash: String
    public let outputIndex: Int
    public let sequenceNumber: Int
    public let script: String
}

extension Input: Codable {
    enum CodingKeys: String, CodingKey {
        case prevTransactionHash = "previous_transaction_hash"
        case outputIndex = "output_index"
        case sequenceNumber = "sequence_number"
        case script
    }
}

public struct Output {
    public let satoshis: Int
    public let script: String
    public let scriptByKey: String
}

extension Output: Codable {
    enum CodingKeys: String, CodingKey {
        case satoshis
        case script
        case scriptByKey = "script_pub_key"
    }
}
