//
//  ETHInternalTransaction.swift
//  CryptoAPI
//
//  Created by Vladimir Sharaev on 4/17/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public struct ETHInternalTransaction {
    public let to: String
    public let from: String
    public let value: String
    public let input: String
    public let isSuicide: Bool
    public let type: String
}

extension ETHInternalTransaction: Codable {
    enum CodingKeys: String, CodingKey {
        case to
        case from
        case value
        case input
        case isSuicide = "is_suicide"
        case type
    }
}
