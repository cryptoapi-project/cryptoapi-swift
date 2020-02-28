//
//  BCHNetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class BCHNetworkAdapterImp: BCHNetworkAdapter {
    let session: URLSession
    let baseUrl: String
    let authToken: String
    let needLogs: Bool
    
    init(session: URLSession, baseUrl: String, authToken: String, needLogs: Bool) {
        self.session = session
        self.baseUrl = baseUrl
        self.authToken = authToken
        self.needLogs = needLogs
    }
    
    func network(completion: @escaping (Result<BCHNetworkResponseModel, CryptoApiError>) -> Void) {
        BCHNetwork.network
            .request(type: BCHNetworkResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func feePerKb(completion: @escaping (Result<String, CryptoApiError>) -> Void) {
        BCHNetwork.feePerKb
            .request(type: String.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func sendRaw(transaction: String, completion: @escaping (Result<BCHSendRawResponseModel, CryptoApiError>) -> Void) {
        BCHNetwork.sendRaw(transactionHash: transaction)
            .request(type: BCHSendRawResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func decodeRaw(transaction: String, completion: @escaping (Result<BCHDecodeRawResponseModel, CryptoApiError>) -> Void) {
        BCHNetwork.decodeRaw(transaction: transaction)
            .request(type: BCHDecodeRawResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func block(numberOrHash: String, completion: @escaping (Result<BCHBlockResponseModel, CryptoApiError>) -> Void) {
        BCHNetwork.block(heightOrHash: numberOrHash)
            .request(type: BCHBlockResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func blocks(skip: Int, limit: Int, completion: @escaping (Result<BCHBlocksResponseModel, CryptoApiError>) -> Void) {
        BCHNetwork.blocks(skip: skip, limit: limit)
            .request(type: BCHBlocksResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transactionBy(hash: String, completion: @escaping (Result<BCHTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        BCHNetwork.transactionBy(hash: hash)
            .request(type: BCHTransactionByHashResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BCHTransactionsResponseModel, CryptoApiError>) -> Void) {
        BCHNetwork.transactions(blockHeightOrHash: blockHeightOrHash, skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress)
            .request(type: BCHTransactionsResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[BCHAddressOutputResponseModel], CryptoApiError>) -> Void) {
        BCHNetwork.addressesOutputs(addresses: addresses, status: status, skip: skip, limit: limit)
            .request(type: [BCHAddressOutputResponseModel].self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesUxtoInfo(addresses: [String], completion: @escaping (Result<[BCHAddressOutInfoResponseModel], CryptoApiError>) -> Void) {
        BCHNetwork.addressesUxtoInfo(addresses: addresses)
            .request(type: [BCHAddressOutInfoResponseModel].self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BCHAddressOutHistoryResponseModel, CryptoApiError>) -> Void) {
        BCHNetwork.addressesTransactionsHistory(addresses: addresses, skip: skip, limit: limit)
            .request(type: BCHAddressOutHistoryResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
}
