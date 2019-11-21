//
//  ETHDecodeRawResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/20/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHDecodeRawResponseModel: Codable {
    public let nonce: Int
    public let gasPrice: ETHDecodeHexResponseModel
    public let gasLimit: ETHDecodeHexResponseModel
    public let to: String
    public let value: ETHDecodeHexResponseModel
    public let data: String
    public let v: Int
    public let r: String
    public let s: String
}

public struct ETHDecodeHexResponseModel {
    public let hex: String
}

extension ETHDecodeHexResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case hex = "_hex"
    }
}
