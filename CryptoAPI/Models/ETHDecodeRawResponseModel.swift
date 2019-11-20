//
//  ETHDecodeRawResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/20/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHDecodeRawResponseModel: Codable {
    let nonce: Int
    let gasPrice: ETHDecodeHexResponseModel
    let gasLimit: ETHDecodeHexResponseModel
    let to: String
    let value: ETHDecodeHexResponseModel
    let data: String
    let v: Int
    let r: String
    let s: String
}

public struct ETHDecodeHexResponseModel {
    let hex: String
}

extension ETHDecodeHexResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case hex = "_hex"
    }
}
