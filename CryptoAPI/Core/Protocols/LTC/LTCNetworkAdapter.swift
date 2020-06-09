//
//  LTCNetworkAdapter.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

protocol LTCNetworkAdapter {
    func network(completion: @escaping (Result<LTCNetworkResponseModel, CryptoApiError>) -> Void)
    
    func feePerKb(completion: @escaping (Result<String, CryptoApiError>) -> Void)
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<LTCSendRawResponseModel, CryptoApiError>) -> Void)
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<LTCDecodeRawResponseModel, CryptoApiError>) -> Void)
    
    func block(numberOrHash: String,
               completion: @escaping (Result<LTCBlockResponseModel, CryptoApiError>) -> Void)
    
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<LTCBlocksResponseModel, CryptoApiError>) -> Void)
    
    func transactionBy(hash: String,
                       completion: @escaping (Result<LTCTransactionByHashResponseModel, CryptoApiError>) -> Void)
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<LTCTransactionsResponseModel, CryptoApiError>) -> Void)
    
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[LTCAddressOutputResponseModel], CryptoApiError>) -> Void)
    
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[LTCAddressOutInfoResponseModel], CryptoApiError>) -> Void)
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<LTCAddressOutHistoryResponseModel, CryptoApiError>) -> Void)
    
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: [String],
                                    completion: @escaping (Result<LTCPushNotificationsResponseModel, CryptoApiError>) -> Void)
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: [String],
                                      completion: @escaping (Result<LTCPushNotificationsResponseModel, CryptoApiError>) -> Void)
}
