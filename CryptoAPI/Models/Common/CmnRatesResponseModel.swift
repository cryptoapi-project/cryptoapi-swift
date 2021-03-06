//
//  CmnRatesResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/19/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct CmnRatesResponseModel {
    public let eth: CmnUSDRateResponseModel
}

extension CmnRatesResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case eth = "ETH"
    }
}

public struct CmnUSDRateResponseModel {
    public let usd: Double
}

extension CmnUSDRateResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}
