//
//  BTCNetwork.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

enum BTCNetwork: Resty {
    case network
    case estimateFee
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

extension BTCNetwork {
    var path: String {
        switch self {
        case .network:
            return "coins/btc/network"
        case .estimateFee:
            return "coins/btc/estimate-fee"
        case .sendRaw:
            return "coins/btc/transactions/raw/send"
        case .decodeRaw:
            return "coins/btc/transactions/raw/decode"
        case .transactions:
            return "coins/btc/transactions"
        case .transactionBy(let hash):
            return "coins/btc/transactions/\(hash)"
        case .addressesOutputs(let addresses, _, _, _):
            return "coins/btc/addresses/\(addresses.description)/outputs"
        case .addressesUxtoInfo(let addresses):
            return "coins/btc/addresses/\(addresses.description)"
        case .addressesTransactionsHistory(let addresses, _, _):
            return "coins/btc/addresses/\(addresses.description)/transactions"
        case .block(let heightOrHash):
            return "coins/btc/blocks/\(heightOrHash)"
        case .blocks:
            return "coins/btc/blocks"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .addressesOutputs, .addressesTransactionsHistory, .addressesUxtoInfo, .block,
             .blocks, .network, .transactionBy, .transactions, .estimateFee:
            return .get
            
        case .decodeRaw, .sendRaw:
            return .post
        }
    }
    
    var bodyParameters: [String: Any]? {
        switch self {
        case .addressesOutputs, .addressesTransactionsHistory, .addressesUxtoInfo, .block, .blocks,
             .network, .transactionBy, .transactions, .estimateFee:
            return nil
            
        case let .sendRaw(transaction):
            return ["hash": transaction]
            
        case let .decodeRaw(transaction):
            return ["hash": transaction]
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .network, .block, .transactionBy, .sendRaw, .decodeRaw, .addressesUxtoInfo, .estimateFee:
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
