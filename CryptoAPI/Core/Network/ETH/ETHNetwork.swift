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
    case history(addresses: [String], from: Int, limit: Int, positive: Bool)
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
    case block(numberOrHash: String)
    case blocks(skip: Int, limit: Int)
    case subscribePushNotifications(addresses: [String], firebaseToken: String, types: [String])
    case unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: [String])
    case subscribeTokenPushNotifications(addresses: [String], firebaseToken: String, tokenAddress: String, types: [String])
    case unsubscribeTokenPushNotifications(addresses: [String], firebaseToken: String, tokenAddress: String, types: [String])
}

extension ETHNetwork {
    var path: String {
        switch self {
        case let .callContract(address, _, _, _):
            return "coins/eth/contracts/\(address)/call"
        case .queryTokens:
            return "coins/eth/tokens/search"
        case .tokenInfo(let address):
            return "coins/eth/tokens/\(address)"
        case .transaction(let hash):
            return "coins/eth/transactions/\(hash)"
        case .contractInfo(let addresses):
            return "coins/eth/contracts/\(addresses)"
        case .info(let addresses):
            return "coins/eth/addresses/\(addresses.description)"
        case .network:
            return "coins/eth/network"
        case .history( let addresses, _, _, _):
            return "coins/eth/addresses/\(addresses.description)/transfers"
        case .transactions:
            return "coins/eth/transactions"
        case .externalHistory( let addresses, _, _):
            return "coins/eth/addresses/\(addresses.description)/transactions"
        case .tokenHistory(let tokenAddress, _, _, _):
            return "coins/eth/tokens/\(tokenAddress)/transfers"
        case .balance(let addresses):
            return "coins/eth/addresses/\(addresses.description)/balance"
        case .tokenBalance(let addresses, _, _, let token):
            if let token = token {
                return "coins/eth/addresses/\(addresses.description)/balance/tokens/\(token)"
            } else {
                return "coins/eth/addresses/\(addresses.description)/balance/tokens"
            }
            
        case .sendRaw:
            return "coins/eth/transactions/raw/send"
        case .decodeRaw:
            return "coins/eth/transactions/raw/decode"
        case .estimateGas:
            return "coins/eth/estimate-gas"
        case .contractLogs:
            return "coins/eth/contracts/logs"
        case .transactionReceipt(let hash):
            return "coins/eth/transactions/\(hash)/receipt"
        case .block(let numberOrHash):
            return "coins/eth/blocks/\(numberOrHash)"
        case .blocks:
            return "coins/eth/blocks"
        case .subscribePushNotifications(let addresses, _, _):
            return "coins/eth/push-notifications/addresses/\(addresses.description)"
        case .unsubscribePushNotifications(let addresses, _, _):
            return "coins/eth/push-notifications/addresses/\(addresses.description)"
        case .subscribeTokenPushNotifications(let addresses, _, _, _):
            return "coins/eth/push-notifications/addresses/\(addresses.description)/tokens"
        case .unsubscribeTokenPushNotifications(let addresses, _, _, _):
            return "coins/eth/push-notifications/addresses/\(addresses.description)/tokens"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .history, .tokenHistory, .balance, .transactions,
             .contractInfo, .transaction, .tokenBalance, .network, .info, .externalHistory,
             .tokenInfo, .queryTokens, .contractLogs, .transactionReceipt, .block, .blocks:
            return .get

        case .sendRaw, .estimateGas, .subscribePushNotifications, .callContract, .decodeRaw,
             .subscribeTokenPushNotifications:
            return .post
            
        case .unsubscribePushNotifications, .unsubscribeTokenPushNotifications:
            return .delete
        }
    }
    
    var bodyParameters: [String: Any]? {
        switch self {
        case .balance, .history, .transactions, .contractInfo,
             .tokenHistory, .tokenBalance, .network, .info,
             .externalHistory, .transaction, .tokenInfo, .queryTokens, .contractLogs,
             .transactionReceipt, .block, .blocks, .unsubscribePushNotifications, .unsubscribeTokenPushNotifications:
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
            
        case let .subscribePushNotifications(_, firebaseToken, types):
            return ["firebase_token": firebaseToken, "types": types.description]
            
        case let .subscribeTokenPushNotifications(_, firebaseToken, tokenAddress, types):
            return ["firebase_token": firebaseToken, "token_address": tokenAddress, "types": types.description]
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .balance, .network, .info, .transaction, .contractInfo, .sendRaw, .decodeRaw,
             .estimateGas, .subscribePushNotifications,
             .tokenInfo, .callContract, .transactionReceipt, .block, .subscribeTokenPushNotifications:
            return nil
            
        case let .queryTokens(query, skip, limit, types):
            return ["query": query, "skip": String(skip), "limit": String(limit), "types": types.description]
            
        case let .history(_, from, limit, positive):
            return ["skip": String(from), "limit": String(limit), "positive": String(positive)]
            
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
            
        case let .unsubscribePushNotifications(_, firebaseToken, types):
            return ["firebase_token": firebaseToken, "types": types.description]
            
        case let .unsubscribeTokenPushNotifications(_, firebaseToken, tokenAddress, types):
            return ["firebase_token": firebaseToken, "token_address": tokenAddress, "types": types.description]
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
