//
//  ETHServiceImp.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

final class ETHServiceImp: ETHService {
    let networkAdapter: ETHNetworkAdapter
    
    public init(networkAdapter: ETHNetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
    
    func balance(addresses: [String], completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.balance(addresses: addresses, completion: completion)
    }
    
    func estimateGas(fromAddress: String, toAddress: String, data: String, value: String,
                     completion: @escaping (Result<ETHEstimateGasResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.estimateGas(fromAddress: fromAddress, toAddress: toAddress, data: data, value: value, completion: completion)
    }
    
    func network(completion: @escaping (Result<ETHNetworkResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.network(completion: completion)
    }
    
    func info(addresses: [String], completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.info(addresses: addresses, completion: completion)
    }
    
    func transfers(skip: Int, limit: Int, addresses: [String], positive: Bool, pending: EthereumPendingType,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transfers(skip: skip, limit: limit,
                                 addresses: addresses, positive: positive, pending: pending.rawValue, completion: completion)
    }
    
    func externalTransfers(skip: Int, limit: Int, addresses: [String], pending: EthereumPendingType,
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.externalTransfers(skip: skip, limit: limit,
                                         addresses: addresses, pending: pending.rawValue, completion: completion)
    }
    
    func transactions(skip: Int, limit: Int, fromAddress: String, toAddress: String, pending: EthereumPendingType,
                      completion: @escaping (Result<ETHTransactionsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactions(skip: skip, limit: limit, fromAddress: fromAddress,
                                    toAddress: toAddress, pending: pending.rawValue, completion: completion)
    }
    
    func transaction(hash: String,
                     completion: @escaping (Result<ETHTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transaction(hash: hash, completion: completion)
    }
    
    func transactionReceipt(hash: String, completion: @escaping (Result<ETHTransactionReceiptResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactionReceipt(hash: hash, completion: completion)
    }
    
    func contractInfo(address: String,
                      completion: @escaping (Result<ETHContractInfoResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.contractInfo(address: address, completion: completion)
    }
    
    func tokensBalance(addresses: [String], skip: Int, limit: Int, token: String?,
                       completion: @escaping (Result<ETHTokensBalanceResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.tokensBalance(addresses: addresses, skip: skip, limit: limit, token: token, completion: completion)
    }
    
    func tokenTransfers(tokenAddress: String, addresses: [String], skip: Int, limit: Int,
                        completion: @escaping (Result<ETHTokenTransfersResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.tokenTransfers(tokenAddress: tokenAddress, addresses: addresses,
                                      skip: skip, limit: limit, completion: completion)
    }
    
    func tokenInfo(address: String,
                   completion: @escaping (Result<ETHTokenInfoResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.tokenInfo(address: address, completion: completion)
    }
    
    func tokenSearch(query: String, skip: Int, limit: Int, types: [EthereumTokenType],
                     completion: @escaping (Result<ETHTokensQueryResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.tokenSearch(query: query, skip: skip, limit: limit, types: types.map { $0.rawValue }, completion: completion)
    }
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<ETHSendRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.sendRaw(transaction: transaction, completion: completion)
    }
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<ETHDecodeRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.decodeRaw(transaction: transaction, completion: completion)
    }
    
    func callContract(sender: String, amount: Int, bytecode: String, address: String,
                      completion: @escaping (Result<String, CryptoApiError>) -> Void) {
        networkAdapter.callContract(sender: sender, amount: amount,
                                    bytecode: bytecode, address: address, completion: completion)
    }
    
    func contractLogs(fromBlock: Int, toBlock: Int, addresses: [String], topics: [String],
                      completion: @escaping (Result<[ETHContractLogsResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.contractLogs(fromBlock: fromBlock, toBlock: toBlock, addresses: addresses, topics: topics, completion: completion)
    }
    
    func block(numberOrHash: String, completion: @escaping (Result<ETHBlockResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.block(numberOrHash: numberOrHash, completion: completion)
    }
    
    func blocks(skip: Int, limit: Int, completion: @escaping (Result<ETHBlocksResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.blocks(skip: skip, limit: limit, completion: completion)
    }
    
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: [CryptoNotificationType],
                                    completion: @escaping (Result<ETHPushNotificationsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.subscribePushNotifications(
            addresses: addresses,
            firebaseToken: firebaseToken,
            types: types.map { $0.rawValue },
            completion: completion
        )
    }
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: [CryptoNotificationType],
                                      completion: @escaping (Result<ETHPushNotificationsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.unsubscribePushNotifications(
            addresses: addresses,
            firebaseToken: firebaseToken,
            types: types.map { $0.rawValue },
            completion: completion
        )
    }
    
    func subscribeTokenPushNotifications(addresses: [String], firebaseToken: String, tokenAddress: String, types: [CryptoNotificationTokenType],
                                         completion: @escaping (Result<ETHTokenPushNotificationsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.subscribeTokenPushNotifications(
            addresses: addresses,
            firebaseToken: firebaseToken,
            tokenAddress: tokenAddress,
            types: types.map { $0.rawValue },
            completion: completion
        )
    }
    
    func unsubscribeTokenPushNotifications(addresses: [String], firebaseToken: String, tokenAddress: String, types: [CryptoNotificationTokenType],
                                           completion: @escaping (Result<ETHTokenPushNotificationsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.unsubscribeTokenPushNotifications(
            addresses: addresses,
            firebaseToken: firebaseToken,
            tokenAddress: tokenAddress,
            types: types.map { $0.rawValue },
            completion: completion
        )
    }
}
