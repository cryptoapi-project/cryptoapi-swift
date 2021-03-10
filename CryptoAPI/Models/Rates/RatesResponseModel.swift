//
//  RatesResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 4/3/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public struct RatesResponseModel: Codable {
    public let symbol: String
    public let rate: CoinRateResponseModel
}

public struct CoinRateResponseModel {
    public let usd: String
    public let eur: String
    public let krw: String
    public let cny: String
    public let jpy: String
    public let aud: String
    public let rub: String
    public let cad: String
    public let chf: String
    public let gbp: String
}

extension CoinRateResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case krw = "KRW"
        case cny = "CNY"
        case jpy = "JPY"
        case aud = "AUD"
        case rub = "RUB"
        case cad = "CAD"
        case chf = "CHF"
        case gbp = "GBP"
    }
}
