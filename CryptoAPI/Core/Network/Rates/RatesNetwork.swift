//
//  RatesNetwork.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 4/3/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

enum RatesNetwork: Resty {
    case rates(coins: [String])
    case ratesHistory(coins: [String])
}

extension RatesNetwork {
    var path: String {
        switch self {
        case .rates(let coins):
            return "rates/\(coins.description)"
            
        case .ratesHistory(coins: let coins):
            return "rates/\(coins.description)/history"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var bodyParameters: [String: Any]? {
        return nil
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
