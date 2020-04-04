//
//  RatesHistoryResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 4/3/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public struct RatesHistoryResponseModel: Codable {
    public let symbol: String
    public let rates: [CoinRateHistoryResponseModel]
}

public struct CoinRateHistoryResponseModel {
    public let createdAt: String
    public let rate: CoinRateResponseModel
}

extension CoinRateHistoryResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case rate
    }
}
