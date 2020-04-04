//
//  ETHNetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final class ETHNetworkAdapterImp: ETHNetworkAdapter {
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
    
    func balance(addresses: [String],
                 completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void) {
        ETHNetwork.balance(addresses: addresses)
            .request(type: [ETHBalanceResponseModel].self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func estimateGas(fromAddress: String, toAddress: String, data: String, value: String,
                     completion: @escaping (Result<ETHEstimateGasResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.estimateGas(from: fromAddress, to: toAddress, value: value, data: data)
            .request(type: ETHEstimateGasResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func network(completion: @escaping (Result<ETHNetworkResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.network
            .request(type: ETHNetworkResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func info(addresses: [String], completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void) {
        ETHNetwork.info(addresses: addresses)
            .request(type: [ETHInfoResponseModel].self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transfers(skip: Int, limit: Int, addresses: [String], positive: String,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.history(addresses: addresses, from: skip, limit: limit)
            .request(type: ETHTransfersResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func externalTransfers(skip: Int, limit: Int, addresses: [String],
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.externalHistory(addresses: addresses, from: skip, limit: limit)
            .request(type: ETHExternalTransfersResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transactions(skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<ETHTransactionsResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.transactions(fromAddress: fromAddress, toAddress: toAddress, skip: skip, limit: limit)
            .request(type: ETHTransactionsResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transaction(hash: String,
                     completion: @escaping (Result<ETHTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.transaction(hash: hash)
            .request(type: ETHTransactionByHashResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func transactionReceipt(hash: String,
                            completion: @escaping (Result<ETHTransactionReceiptResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.transactionReceipt(hash: hash)
            .request(type: ETHTransactionReceiptResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func contractInfo(address: String,
                      completion: @escaping (Result<ETHContractInfoResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.contractInfo(address: address)
            .request(type: ETHContractInfoResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func tokensBalance(addresses: [String], skip: Int, limit: Int, token: String?,
                       completion: @escaping (Result<ETHTokensBalanceResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.tokenBalance(addresses: addresses, skip: skip, limit: limit, token: token)
            .request(type: ETHTokensBalanceResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func tokenTransfers(tokenAddress: String, addresses: [String], skip: Int, limit: Int,
                        completion: @escaping (Result<ETHTokenTransfersResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.tokenHistory(tokenAddress: tokenAddress, addresses: addresses, from: skip, limit: limit)
            .request(type: ETHTokenTransfersResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func tokenInfo(address: String,
                   completion: @escaping (Result<ETHTokenInfoResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.tokenInfo(address: address)
            .request(type: ETHTokenInfoResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func tokenSearch(query: String, skip: Int, limit: Int, types: [String],
                     completion: @escaping (Result<ETHTokensQueryResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.queryTokens(query: query, skip: skip, limit: limit, types: types)
            .request(type: ETHTokensQueryResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<ETHSendRawResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.sendRaw(transaction: transaction)
            .request(type: ETHSendRawResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<ETHDecodeRawResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.decodeRaw(transaction: transaction)
            .request(type: ETHDecodeRawResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func callContract(sender: String, amount: Int, bytecode: String, address: String,
                      completion: @escaping (Result<String, CryptoApiError>) -> Void) {
        ETHNetwork.callContract(address: address, sender: sender, amount: amount, bytecode: bytecode)
            .request(type: String.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func contractLogs(fromBlock: Int, toBlock: Int, addresses: [String], topics: [String],
                      completion: @escaping (Result<[ETHContractLogsResponseModel], CryptoApiError>) -> Void) {
        ETHNetwork.contractLogs(fromBlock: fromBlock, toBlock: toBlock, addresses: addresses, topics: topics)
            .request(type: [ETHContractLogsResponseModel].self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func block(numberOrHash: String, completion: @escaping (Result<ETHBlockResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.block(numberOrHash: numberOrHash)
            .request(type: ETHBlockResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func blocks(skip: Int, limit: Int, completion: @escaping (Result<ETHBlocksResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.blocks(skip: skip, limit: limit)
            .request(type: ETHBlocksResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func subscribePushNotifications(addresses: [String], firebaseToken: String,
                                    completion: @escaping (Result<ETHPushNotificationsResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.subscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken)
            .request(type: ETHPushNotificationsResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String,
                                      completion: @escaping (Result<ETHPushNotificationsResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.unsubscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken)
            .request(type: ETHPushNotificationsResponseModel.self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
}
    
