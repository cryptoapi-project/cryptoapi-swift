//
//  ETHNetwork.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 14.01.2019.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

enum ETHNetwork: Resty {
    case network
    case info(addresses: [String])
    case balance(addresses: [String])
    case history(addresses: [String], from: Int, limit: Int)
    case externalHistory(addresses: [String], from: Int, limit: Int)
    case transactions(fromAddress: String, toAddress: String, skip: Int, limit: Int)
    case transaction(hash: String)
    case transactionReceipt(hash: String)
    case estimateGas(from: String, to: String, value: String, data: String)
    case sendRaw(transaction: String)
    case decodeRaw(transaction: String)
    case contractInfo(address: String)
    case contractLogs(fromBlock: Int, toBlock: Int, addresses: [String], topics: [String])
    case queryTokens(query: String, skip: Int, limit: Int, types: [String])
    case tokenInfo(address: String)
    case tokenBalance(addresses: [String], skip: Int, limit: Int, token: String?)
    case tokenHistory(tokenAddress: String, addresses: [String], from: Int, limit: Int)
    case callContract(address: String, sender: String, amount: Int, bytecode: String)
    case subscribePushNotifications(addresses: [String], token: String)
    case unsubscribePushNotifications(addresses: [String], token: String)
    case block(numberOrHash: String)
    case blocks(skip: Int, limit: Int)
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
            return "/v1/coins/eth/tokens/\(address)"
        case .transaction(let hash):
            return "/v1/coins/eth/transactions/\(hash)"
        case .contractInfo(let addresses):
            return "/v1/coins/eth/contracts/\(addresses)"
        case .info(let addresses):
            return "/v1/coins/eth/addresses/\(addresses.description)"
        case .network:
            return "/v1/coins/eth/network"
        case .history( let addresses, _, _):
            return "/v1/coins/eth/addresses/\(addresses.description)/transfers"
        case .transactions:
            return "/v1/coins/eth/transactions"
        case .externalHistory( let addresses, _, _):
            return "/v1/coins/eth/addresses/\(addresses.description)/transactions"
        case .tokenHistory(let tokenAddress, _, _, _):
            return "/v1/coins/eth/tokens/\(tokenAddress)/transfers"
        case .balance(let addresses):
            return "/v1/coins/eth/addresses/\(addresses.description)/balance"
        case .tokenBalance(let addresses, _, _, let token):
            if let token = token {
                return "/v1/coins/eth/addresses/\(addresses.description)/balance/tokens/\(token)"
            } else {
                return "/v1/coins/eth/addresses/\(addresses.description)/balance/tokens"
            }
            
        case .sendRaw:
            return "/v1/coins/eth/transactions/raw/send"
        case .decodeRaw:
            return "/v1/coins/eth/transactions/raw/decode"
        case .estimateGas:
            return "/v1/coins/eth/estimate-gas"
        case .subscribePushNotifications(let address, _):
            return "/v1/coins/eth/accounts/\(address)/token/subscribe/balance"
        case .unsubscribePushNotifications(let address, _):
            return "/v1/coins/eth/accounts/\(address)/token/unsubscribe/balance"
        case .contractLogs:
            return "/v1/coins/eth/contracts/logs"
        case .transactionReceipt(let hash):
            return "/v1/coins/eth/transactions/receipt/\(hash)"
        case .block(let numberOrHash):
            return "/v1/coins/eth/blocks/\(numberOrHash)"
        case .blocks:
            return "/v1/coins/eth/blocks"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .history, .tokenHistory, .balance, .transactions,
             .contractInfo, .transaction, .tokenBalance, .network, .info, .externalHistory,
             .tokenInfo, .queryTokens, .contractLogs, .transactionReceipt, .block, .blocks:
            return .get

        case .sendRaw, .estimateGas, .subscribePushNotifications, .unsubscribePushNotifications, .callContract, .decodeRaw:
            return .post
        }
    }
    
    var bodyParameters: [String: Any]? {
        switch self {
        case .balance, .history, .transactions, .contractInfo,
             .tokenHistory, .tokenBalance, .network, .info,
             .externalHistory, .transaction, .tokenInfo, .queryTokens, .contractLogs,
             .transactionReceipt, .block, .blocks:
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
        case .balance, .network, .info, .transaction, .contractInfo, .sendRaw, .decodeRaw,
             .estimateGas, .subscribePushNotifications, .unsubscribePushNotifications,
             .tokenInfo, .callContract, .transactionReceipt, .block:
            return nil
            
        case let .queryTokens(query, skip, limit, types):
            return ["query": query, "skip": String(skip), "limit": String(limit), "types": types.joined(separator: ",")]
            
        case let .history(_, from, limit):
            return ["skip": String(from), "limit": String(limit)]
            
        case let .transactions(from, to, skip, limit):
            return ["from": from, "to": to, "skip": String(skip), "limit": String(limit)]
            
        case let .externalHistory(_, from, limit):
            return ["skip": String(from), "limit": String(limit)]
            
        case let .tokenHistory(_, addresses, from, limit):
            return ["skip": String(from), "limit": String(limit), "addresses": addresses.description]
            
        case let .tokenBalance(_, skip, limit, _):
            return ["skip": String(skip), "limit": String(limit)]
            
        case let .contractLogs(from, to, addresses, topics):
            var result = ["from_block": String(from), "to_block": String(to), "addresses": addresses.description]
            if !topics.isEmpty {
                result["topics"] = topics.description
            }
            return result
            
        case let .blocks(skip, limit):
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
