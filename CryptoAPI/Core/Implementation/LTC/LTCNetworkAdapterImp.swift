//
//  LTCNetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class LTCNetworkAdapterImp: LTCNetworkAdapter {
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
    
    func network(completion: @escaping (Result<LTCNetworkResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.network
            .request(type: LTCNetworkResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func feePerKb(completion: @escaping (Result<String, CryptoApiError>) -> Void) {
        LTCNetwork.feePerKb
            .request(type: String.self, session: session, baseUrl: baseUrl,
                      authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func sendRaw(transaction: String, completion: @escaping (Result<LTCSendRawResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.sendRaw(transactionHash: transaction)
            .request(type: LTCSendRawResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func decodeRaw(transaction: String, completion: @escaping (Result<LTCDecodeRawResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.decodeRaw(transaction: transaction)
            .request(type: LTCDecodeRawResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func block(numberOrHash: String, completion: @escaping (Result<LTCBlockResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.block(heightOrHash: numberOrHash)
            .request(type: LTCBlockResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func blocks(skip: Int, limit: Int, completion: @escaping (Result<LTCBlocksResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.blocks(skip: skip, limit: limit)
            .request(type: LTCBlocksResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transactionBy(hash: String, completion: @escaping (Result<LTCTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.transactionBy(hash: hash)
            .request(type: LTCTransactionByHashResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<LTCTransactionsResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.transactions(blockHeightOrHash: blockHeightOrHash, skip: skip, limit: limit, fromAddress: fromAddress, toAddress: toAddress)
            .request(type: LTCTransactionsResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[LTCAddressOutputResponseModel], CryptoApiError>) -> Void) {
        LTCNetwork.addressesOutputs(addresses: addresses, status: status, skip: skip, limit: limit)
            .request(type: [LTCAddressOutputResponseModel].self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesUxtoInfo(addresses: [String], completion: @escaping (Result<[LTCAddressOutInfoResponseModel], CryptoApiError>) -> Void) {
        LTCNetwork.addressesUxtoInfo(addresses: addresses)
            .request(type: [LTCAddressOutInfoResponseModel].self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<LTCAddressOutHistoryResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.addressesTransactionsHistory(addresses: addresses, skip: skip, limit: limit)
            .request(type: LTCAddressOutHistoryResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                    completion: @escaping (Result<LTCPushNotificationsResponseModel, CryptoApiError>) -> Void) {
        LTCNetwork.subscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken, types: types)
            .request(type: LTCPushNotificationsResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                      completion: @escaping (Result<Bool, CryptoApiError>) -> Void) {
        LTCNetwork.unsubscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken, types: types)
            .request(type: Bool.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
}
