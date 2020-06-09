//
//  CryptoNotificationType.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 6/6/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public enum CryptoNotificationType: String, Codable {
    case outgoing
    case incoming
    case balance
}
