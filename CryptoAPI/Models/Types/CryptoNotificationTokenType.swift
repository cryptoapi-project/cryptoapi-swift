//
//  CryptoNotificationTokenType.swift
//  CryptoAPI
//
//  Created by Dmitry Medyuho on 22.02.21.
//  Copyright © 2021 PixelPlex. All rights reserved.
//

import Foundation

public enum CryptoNotificationTokenType: String, Codable {
    case outgoing
    case incoming
    case all
}
