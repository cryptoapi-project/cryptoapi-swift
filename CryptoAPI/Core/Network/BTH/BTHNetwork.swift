//
//  BTHNetwork.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

enum BTHNetwork: Resty {
    case network
    case sendRaw(transactionHash: String)
    case decodeRaw(transaction: String)
    case transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String)
    case transactionBy(hash: String)
    case addressesOutputs(addresses: [String], status: String, skip: Int, limit: Int)
    case addressesUxtoInfo(addresses: [String])
    case addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int)
    case block(heightOrHash: String)
    case blocks(skip: Int, limit: Int)
}

extension BTHNetwork {
    var host: String {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
        case .network:
            return "/v1/coins/bth/network"
        case .sendRaw:
            return "/v1/coins/bth/transactions/raw/send"
        case .decodeRaw:
            return "/v1/coins/bth/transactions/raw/decode"
        case .transactions:
            return "/v1/coins/bth/transactions"
        case .transactionBy(let hash):
            return "/v1/coins/bth/transactions/\(hash)"
        case .addressesOutputs(let addresses, _, _, _):
            return "/v1/coins/bth/addresses/\(addresses)/outputs"
        case .addressesUxtoInfo(let addresses):
            return "/v1​/coins​/bth/addresses​/\(addresses)"
        case .addressesTransactionsHistory(let addresses, _, _):
            return "/v1/coins/bth/addresses/\(addresses)/transactions"
        case .block(let heightOrHash):
            return "/v1/coins/bth/blocks/\(heightOrHash)"
        case .blocks:
            return "/v1/coins/bth/blocks"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .addressesOutputs, .addressesTransactionsHistory, .addressesUxtoInfo, .block, .blocks, .network, .transactionBy, .transactions:
            return .get
            
        case .decodeRaw, .sendRaw:
            return .post
        }
    }
    
    var bodyParameters: [String: Any]? {
        switch self {
        case .addressesOutputs, .addressesTransactionsHistory, .addressesUxtoInfo, .block, .blocks, .network, .transactionBy, .transactions:
            return nil
            
        case let .sendRaw(transaction):
            return ["tx": transaction]
            
        case let .decodeRaw(transaction):
            return ["hash": transaction]
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .network, .block, .transactionBy, .sendRaw, .decodeRaw, .addressesUxtoInfo:
            return nil
            
        case let .blocks(skip, limit):
            return ["skip": String(skip), "limit": String(limit)]
            
        case let .transactions(heightOrHash, skip, limit, fromAddress, toAddress):
            return [
                "block_height_or_hash": String(heightOrHash), "skip": String(skip),
                "limit": String(limit), "from": String(fromAddress), "to": String(toAddress)
            ]
            
        case let .addressesOutputs(_, status, skip, limit):
            return ["status": String(status), "skip": String(skip), "limit": String(limit)]
            
        case let .addressesTransactionsHistory(_, skip, limit):
            return ["skip": String(skip), "limit": String(limit)]
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
