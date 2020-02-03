//
//  ETHEstimateGasResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHEstimateGasResponseModel {
    public let estimateGas: Int
    public let gasPrice: String
    public let nonce: Int
}

extension ETHEstimateGasResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case estimateGas = "estimate_gas"
        case gasPrice = "gas_price"
        case nonce
    }
}
