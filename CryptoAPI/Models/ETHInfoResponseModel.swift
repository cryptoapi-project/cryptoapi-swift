//
//  ETHInfoResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHInfoResponseModel {
    let address: String
    let balance: String
    let isContract: Bool
    let type: String
    let countTransactions: Int
}

extension ETHInfoResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case address
        case balance
        case isContract = "is_contract"
        case type
        case countTransactions = "count_transactions"
    }
}
