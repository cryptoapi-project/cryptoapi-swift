//
//  CmnRatesHistoryResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/19/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct CmnRatesHistoryResponseModel {
    public let createdAt: String
    public let rate: CmnUSDRateResponseModel
}

extension CmnRatesHistoryResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case rate
    }
}
