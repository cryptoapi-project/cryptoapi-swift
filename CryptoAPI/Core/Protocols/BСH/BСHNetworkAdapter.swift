//
//  BCHNetworkAdapter.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

protocol BCHNetworkAdapter {
    //BCH
    func network(completion: @escaping (Result<BCHNetworkResponseModel, CryptoApiError>) -> Void)
    
    func feePerKb(completion: @escaping (Result<String, CryptoApiError>) -> Void)
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BCHSendRawResponseModel, CryptoApiError>) -> Void)
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BCHDecodeRawResponseModel, CryptoApiError>) -> Void)
    
    func block(numberOrHash: String,
               completion: @escaping (Result<BCHBlockResponseModel, CryptoApiError>) -> Void)
    
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BCHBlocksResponseModel, CryptoApiError>) -> Void)
    
    func transactionBy(hash: String,
                       completion: @escaping (Result<BCHTransactionByHashResponseModel, CryptoApiError>) -> Void)
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BCHTransactionsResponseModel, CryptoApiError>) -> Void)
    
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[BCHAddressOutputResponseModel], CryptoApiError>) -> Void)
    
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BCHAddressOutInfoResponseModel], CryptoApiError>) -> Void)
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BCHAddressOutHistoryResponseModel, CryptoApiError>) -> Void)
    
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                    completion: @escaping (Result<BCHPushNotificationsResponseModel, CryptoApiError>) -> Void)
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                      completion: @escaping (Result<Bool, CryptoApiError>) -> Void)
}
