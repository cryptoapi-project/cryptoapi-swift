//
//  LTCBlocksResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct LTCBlocksResponseModel: Codable {
    public let skip: Int
    public let limit: Int
    public let count: Int
    public let items: [LTCBlockResponseModel]
}
