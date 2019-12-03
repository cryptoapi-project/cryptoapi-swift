//
//  CommonNetwork.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/19/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

enum CommonNetwork: Resty {
    case coins
}

extension CommonNetwork {
    var host: String {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
        case .coins:
            return "/v1/coins"
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

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        let escaped: String! = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return escaped
    }
    
    var utf8Encoded: Data {
        let encoded: Data! = data(using: .utf8)
        return encoded
    }
}
