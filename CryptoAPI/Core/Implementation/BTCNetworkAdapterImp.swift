//
//  BTCNetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class BTCNetworkAdapterImp: BTCNetworkAdapter {
    let session: URLSession
    let authToken: AuthorizationToken
    
    init(session: URLSession, authToken: AuthorizationToken) {
        self.session = session
        self.authToken = authToken
    }
    
    func network(completion: @escaping (Result<BTCNetworkResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.network.request(type: BTCNetworkResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func sendRaw(transaction: String, completion: @escaping (Result<BTCSendRawResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.sendRaw(transactionHash: transaction)
            .request(type: BTCSendRawResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func decodeRaw(transaction: String, completion: @escaping (Result<BTCDecodeRawResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.decodeRaw(transaction: transaction)
            .request(type: BTCDecodeRawResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func block(numberOrHash: String, completion: @escaping (Result<BTCBlockResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.block(heightOrHash: numberOrHash)
            .request(type: BTCBlockResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func blocks(skip: Int, limit: Int, completion: @escaping (Result<BTCBlocksResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.blocks(skip: skip, limit: limit)
            .request(type: BTCBlocksResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func transactionBy(hash: String, completion: @escaping (Result<BTCTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.transactionBy(hash: hash)
            .request(type: BTCTransactionByHashResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BTCTransactionsResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.transactions(blockHeightOrHash: blockHeightOrHash, skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress)
            .request(type: BTCTransactionsResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func addressesOutputs(addresses: [String], status: String, skip: Int, limit: Int,
                          completion: @escaping (Result<[BTCAddressOutputResponseModel], CryptoApiError>) -> Void) {
        BTCNetwork.addressesOutputs(addresses: addresses, status: status, skip: skip, limit: limit)
            .request(type: [BTCAddressOutputResponseModel].self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func addressesUxtoInfo(addresses: [String], completion: @escaping (Result<[BTCAddressOutInfoResponseModel], CryptoApiError>) -> Void) {
        BTCNetwork.addressesUxtoInfo(addresses: addresses)
            .request(type: [BTCAddressOutInfoResponseModel].self, session: session, authToken: authToken, completionHandler: completion)
    }
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BTCAddressOutHistoryResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.addressesTransactionsHistory(addresses: addresses, skip: skip, limit: limit)
            .request(type: BTCAddressOutHistoryResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
}
