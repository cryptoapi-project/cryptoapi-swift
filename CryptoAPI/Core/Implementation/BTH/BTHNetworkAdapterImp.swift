//
//  BTHNetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class BTHNetworkAdapterImp: BTHNetworkAdapter {
    let session: URLSession
    let authToken: AuthorizationToken
    let needLogs: Bool
    
    init(session: URLSession, authToken: AuthorizationToken, needLogs: Bool) {
        self.session = session
        self.authToken = authToken
        self.needLogs = needLogs
    }
    
    func network(completion: @escaping (Result<BTHNetworkResponseModel, CryptoApiError>) -> Void) {
        BTHNetwork.network
            .request(type: BTHNetworkResponseModel.self, session: session, authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func sendRaw(transaction: String, completion: @escaping (Result<BTHSendRawResponseModel, CryptoApiError>) -> Void) {
        BTHNetwork.sendRaw(transactionHash: transaction)
            .request(type: BTHSendRawResponseModel.self, session: session, authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func decodeRaw(transaction: String, completion: @escaping (Result<BTHDecodeRawResponseModel, CryptoApiError>) -> Void) {
        BTHNetwork.decodeRaw(transaction: transaction)
            .request(type: BTHDecodeRawResponseModel.self, session: session, authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func block(numberOrHash: String, completion: @escaping (Result<BTHBlockResponseModel, CryptoApiError>) -> Void) {
        BTHNetwork.block(heightOrHash: numberOrHash)
            .request(type: BTHBlockResponseModel.self, session: session, authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func blocks(skip: Int, limit: Int, completion: @escaping (Result<BTHBlocksResponseModel, CryptoApiError>) -> Void) {
        BTHNetwork.blocks(skip: skip, limit: limit)
            .request(type: BTHBlocksResponseModel.self, session: session, authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transactionBy(hash: String, completion: @escaping (Result<BTHTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        BTHNetwork.transactionBy(hash: hash)
            .request(type: BTHTransactionByHashResponseModel.self, session: session,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BTHTransactionsResponseModel, CryptoApiError>) -> Void) {
        BTHNetwork.transactions(blockHeightOrHash: blockHeightOrHash, skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress)
            .request(type: BTHTransactionsResponseModel.self, session: session,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesOutputs(addresses: [String], status: String, skip: Int, limit: Int,
                          completion: @escaping (Result<[BTHAddressOutputResponseModel], CryptoApiError>) -> Void) {
        BTHNetwork.addressesOutputs(addresses: addresses, status: status, skip: skip, limit: limit)
            .request(type: [BTHAddressOutputResponseModel].self, session: session,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesUxtoInfo(addresses: [String], completion: @escaping (Result<[BTHAddressOutInfoResponseModel], CryptoApiError>) -> Void) {
        BTHNetwork.addressesUxtoInfo(addresses: addresses)
            .request(type: [BTHAddressOutInfoResponseModel].self, session: session,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BTHAddressOutHistoryResponseModel, CryptoApiError>) -> Void) {
        BTHNetwork.addressesTransactionsHistory(addresses: addresses, skip: skip, limit: limit)
            .request(type: BTHAddressOutHistoryResponseModel.self, session: session,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
}
