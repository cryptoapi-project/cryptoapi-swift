//
//  NetworkProviderImp.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 14.01.2019.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

enum ETHNetwork: Resty {
    case history(address: String, from: Int, limit: Int)
    case tokenHistory(tokenAddress: String, address: String, from: Int, limit: Int)
    case balance(address: String)
    case tokenBalance(address: String, skip: Int, limit: Int)
    case sendRawTransaction(transaction: String)
    case estimateGas(from: String, to: String, value: String, data: String)
    case outputs(address: String)
    case estimateFee
    case subscribePushNotifications(address: String, token: String)
    case unsubscribePushNotifications(address: String, token: String)
    case coinRates
    case coinsRateHistory
}

extension ETHNetwork {
    var host: String {
        return ""
    }
    var path: String {
        switch self {
        case .history( let address, _, _):
            return "/v1/coins/eth/accounts/\(address)/transfers"
        case .tokenHistory(let tokenAddress, let address, _, _):
            return "/v1/coins/eth/tokens/\(tokenAddress)/\(address)/transfers"
        case .estimateFee:
            return "/v1/coins/eth/estimate-fee-per-kb"
        case .balance(let address):
            return "/v1/coins/eth/accounts/\(address)/balance"
        case .tokenBalance(let address, _, _):
            return "/v1/coins/eth/tokens/\(address)/balances"
        case .sendRawTransaction:
            return "/v1/coins/eth/transactions/raw/send"
        case .estimateGas:
            return "/v1/coins/eth/estimate-gas"
        case .outputs(let address):
            return "/v1/coins/eth/\(address)/outputs"
        case .subscribePushNotifications(let address, _):
            return "/v1/coins/eth/accounts/\(address)/token/subscribe/balance"
        case .unsubscribePushNotifications(let address, _):
            return "/v1/coins/eth/accounts/\(address)/token/unsubscribe/balance"
        case .coinRates:
            return "/v1/coins/rates"
        case .coinsRateHistory:
            return "/v1/coins/rates/eth/history"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .history, .tokenHistory, .balance, .outputs, .coinRates, .estimateFee, .coinsRateHistory, .tokenBalance:
            return .get

        case .sendRawTransaction, .estimateGas, .subscribePushNotifications, .unsubscribePushNotifications:
            return .post
        }
    }
    
    var bodyParameters: [String: Any]? {
        switch self {
        case .balance, .outputs, .coinRates, .estimateFee, .coinsRateHistory, .history, .tokenHistory, .tokenBalance:
            return nil
            
        case let .sendRawTransaction(transaction):
            return ["tx": transaction]
            
        case let .estimateGas(from, to, value, data):
            if data.isEmpty {
                return ["from": from, "to": to, "value": value]
            } else {
                return ["from": from, "to": to, "value": value, "data": data]
            }
            
        case let .subscribePushNotifications(_, token):
            return ["token": token]
            
        case let .unsubscribePushNotifications(_, token):
            return ["token": token]
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .balance, .outputs, .coinRates, .estimateFee, .coinsRateHistory,
             .sendRawTransaction, .estimateGas, .subscribePushNotifications, .unsubscribePushNotifications:
            return nil
            
        case let .history(_, from, limit):
            return ["skip": String(from), "limit": String(limit)]
            
        case let .tokenHistory(_, _, from, limit):
            return ["skip": String(from), "limit": String(limit)]
            
        case let .tokenBalance(_, skip, limit):
            return ["skip": String(skip), "limit": String(limit)]
        }
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
