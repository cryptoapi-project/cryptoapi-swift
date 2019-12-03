//
//  ETHNetwork.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 14.01.2019.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

enum ETHNetwork: Resty {
    case queryTokens(query: String, skip: Int, limit: Int, types: [String])
    case contractInfo(address: String)
    case tokenInfo(address: String)
    case info(addresses: [String])
    case network
    case history(addresses: [String], from: Int, limit: Int)
    case transactions(fromAddress: String, toAddress: String, skip: Int, limit: Int)
    case transaction(hash: String)
    case externalHistory(addresses: [String], from: Int, limit: Int)
    case tokenHistory(tokenAddress: String, addresses: [String], from: Int, limit: Int)
    case balance(addresses: [String])
    case tokenBalance(address: String, skip: Int, limit: Int)
    case sendRaw(transaction: String)
    case decodeRaw(transaction: String)
    case callContract(address: String, sender: String, amount: Int, bytecode: String)
    case estimateGas(from: String, to: String, value: String, data: String)
    case outputs(addresses: [String])
    case estimateFee
    case subscribePushNotifications(addresses: [String], token: String)
    case unsubscribePushNotifications(addresses: [String], token: String)
}

extension ETHNetwork {
    var host: String {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
        case let .callContract(address, _, _, _):
            return "/v1/coins/eth/contracts/\(address)/call"
        case .queryTokens:
            return "/v1/coins/eth/tokens/search"
        case .tokenInfo(let address):
            return "/v1/coins/eth/tokens/\(address)/info"
        case .transaction(let hash):
            return "/v1/coins/eth/transactions/\(hash)"
        case .contractInfo(let addresses):
            return "/v1/coins/eth/contracts/\(addresses)/info"
        case .info(let addresses):
            return "/v1/coins/eth/accounts/\(addresses.description)/info"
        case .network:
            return "/v1/coins/eth/network"
        case .history( let addresses, _, _):
            return "/v1/coins/eth/accounts/\(addresses.description)/transfers"
        case .transactions:
            return "/v1/coins/eth/transactions"
        case .externalHistory( let addresses, _, _):
            return "/v1/coins/eth/accounts/\(addresses.description)/transactions/external"
        case .tokenHistory(let tokenAddress, let addresses, _, _):
            return "/v1/coins/eth/tokens/\(tokenAddress)/\(addresses.description)/transfers"
        case .estimateFee:
            return "/v1/coins/eth/estimate-fee-per-kb"
        case .balance(let addresses):
            return "/v1/coins/eth/accounts/\(addresses.description)/balance"
        case .tokenBalance(let address, _, _):
            return "/v1/coins/eth/tokens/\(address)/balances"
        case .sendRaw:
            return "/v1/coins/eth/transactions/raw/send"
        case .decodeRaw:
            return "/v1/coins/eth/transactions/raw/decode"
        case .estimateGas:
            return "/v1/coins/eth/estimate-gas"
        case .outputs(let addresses):
            return "/v1/coins/eth/\(addresses.description)/outputs"
        case .subscribePushNotifications(let address, _):
            return "/v1/coins/eth/accounts/\(address)/token/subscribe/balance"
        case .unsubscribePushNotifications(let address, _):
            return "/v1/coins/eth/accounts/\(address)/token/unsubscribe/balance"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .history, .tokenHistory, .balance, .outputs, .estimateFee, .transactions,
             .contractInfo, .transaction, .tokenBalance, .network, .info, .externalHistory,
             .tokenInfo, .queryTokens:
            return .get

        case .sendRaw, .estimateGas, .subscribePushNotifications, .unsubscribePushNotifications, .callContract, .decodeRaw:
            return .post
        }
    }
    
    var bodyParameters: [String: Any]? {
        switch self {
        case .balance, .outputs, .estimateFee, .history, .transactions, .contractInfo,
             .tokenHistory, .tokenBalance, .network, .info, .externalHistory, .transaction, .tokenInfo, .queryTokens:
            return nil
            
        case let .sendRaw(transaction):
            return ["tx": transaction]
            
        case let .callContract(_, sender, amount, bytecode):
            return [
                "sender": sender,
                "amount": amount,
                "bytecode": bytecode
            ]
            
        case let .decodeRaw(transaction):
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
        case .balance, .outputs, .estimateFee, .network, .info, .transaction, .contractInfo, .sendRaw, .decodeRaw,
             .estimateGas, .subscribePushNotifications, .unsubscribePushNotifications, .tokenInfo, .callContract:
            return nil
            
        case let .queryTokens(query, skip, limit, types):
            return ["query": query, "skip": String(skip), "limit": String(limit), "types": types.joined(separator: ",")]
            
        case let .history(_, from, limit):
            return ["skip": String(from), "limit": String(limit)]
            
        case let .transactions(from, to, skip, limit):
            return ["from": from, "to": to, "skip": String(skip), "limit": String(limit)]
            
        case let .externalHistory(_, from, limit):
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
