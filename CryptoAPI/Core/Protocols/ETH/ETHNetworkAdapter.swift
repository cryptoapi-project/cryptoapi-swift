//
//  ETHNetworkAdapter.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 6/12/2019.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

enum MapError: Swift.Error, Equatable {
    /// Indicates that date is invalid format
    case invalidFormat
}

protocol ETHNetworkAdapter {
    //ETH
    func balance(addresses: [String],
                 completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void)
    
    func estimateGas(fromAddress: String, toAddress: String, data: String, value: String,
                     completion: @escaping (Result<ETHEstimateGasResponseModel, CryptoApiError>) -> Void)
    
    func network(completion: @escaping (Result<ETHNetworkResponseModel, CryptoApiError>) -> Void)
    func info(addresses: [String], completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void)
    func transfers(skip: Int, limit: Int, addresses: [String], positive: Bool,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void)
    func externalTransfers(skip: Int, limit: Int, addresses: [String],
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void)
    func transactions(skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<ETHTransactionsResponseModel, CryptoApiError>) -> Void)
    func transaction(hash: String,
                     completion: @escaping (Result<ETHTransactionByHashResponseModel, CryptoApiError>) -> Void)
    func transactionReceipt(hash: String,
                            completion: @escaping (Result<ETHTransactionReceiptResponseModel, CryptoApiError>) -> Void)
    func contractInfo(address: String,
                      completion: @escaping (Result<ETHContractInfoResponseModel, CryptoApiError>) -> Void)
    func tokensBalance(addresses: [String], skip: Int, limit: Int, token: String?,
                       completion: @escaping (Result<ETHTokensBalanceResponseModel, CryptoApiError>) -> Void)
    func tokenTransfers(tokenAddress: String, addresses: [String], skip: Int, limit: Int,
                        completion: @escaping (Result<ETHTokenTransfersResponseModel, CryptoApiError>) -> Void)
    func tokenInfo(address: String,
                   completion: @escaping (Result<ETHTokenInfoResponseModel, CryptoApiError>) -> Void)
    func tokenSearch(query: String, skip: Int, limit: Int, types: [String],
                     completion: @escaping (Result<ETHTokensQueryResponseModel, CryptoApiError>) -> Void)
    func sendRaw(transaction: String,
                 completion: @escaping (Result<ETHSendRawResponseModel, CryptoApiError>) -> Void)
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<ETHDecodeRawResponseModel, CryptoApiError>) -> Void)
    func callContract(sender: String, amount: Int, bytecode: String, address: String,
                      completion: @escaping (Result<String, CryptoApiError>) -> Void)
    func contractLogs(fromBlock: Int, toBlock: Int, addresses: [String], topics: [String],
                      completion: @escaping (Result<[ETHContractLogsResponseModel], CryptoApiError>) -> Void)

    func block(numberOrHash: String, completion: @escaping (Result<ETHBlockResponseModel, CryptoApiError>) -> Void)
    func blocks(skip: Int, limit: Int, completion: @escaping (Result<ETHBlocksResponseModel, CryptoApiError>) -> Void)
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                    completion: @escaping (Result<ETHPushNotificationsResponseModel, CryptoApiError>) -> Void)
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                      completion: @escaping (Result<ETHPushNotificationsResponseModel, CryptoApiError>) -> Void)
}
