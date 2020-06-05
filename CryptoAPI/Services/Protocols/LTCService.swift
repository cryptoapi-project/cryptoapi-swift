//
//  LTCService.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public protocol LTCService {
    /**
     Network information
     
     - Parameter completion: Callback which returns an [LTCNetworkResponseModel](LTCNetworkResponseModel) result  or error
     */
    func network(completion: @escaping (Result<LTCNetworkResponseModel, CryptoApiError>) -> Void)
    
    /**
     Fee per Kb information
     
     - Parameter completion: Callback which returns an [Strint](String) result  or error
     */
    func feePerKb(completion: @escaping (Result<String, CryptoApiError>) -> Void)
    
    /**
     Send raw LTC transaction.
     
     - Parameter transaction: transaction hex
     - Parameter completion: Callback which returns an [LTCSendRawResponseModel](LTCSendRawResponseModel) result  or error
     */
    func sendRaw(transaction: String,
                 completion: @escaping (Result<LTCSendRawResponseModel, CryptoApiError>) -> Void)
    
    /**
     Decode raw LTC transaction hex.
     
     - Parameter transaction: transaction hex
     - Parameter completion: Callback which returns an [LTCDecodeRawResponseModel](LTCDecodeRawResponseModel) result  or error
     */
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<LTCDecodeRawResponseModel, CryptoApiError>) -> Void)
    
    /**
     Returns block object by number or hash
     
     - Parameter numberOrHash: number or hash of block
     - Parameter completion: Callback which returns an [LTCBlockResponseModel](LTCBlockResponseModel) result  or error
     */
    func block(numberOrHash: String,
               completion: @escaping (Result<LTCBlockResponseModel, CryptoApiError>) -> Void)
    
    /**
     Returns blocks
     
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [LTCBlocksResponseModel](LTCBlocksResponseModel) result  or error
     */
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<LTCBlocksResponseModel, CryptoApiError>) -> Void)
    
    /**
     Get transaction by hash
     
     - Parameter hash: hash of transaction
     - Parameter completion: Callback which returns an [LTCTransactionByHashResponseModel](LTCTransactionByHashResponseModel) result  or error
     */
    func transactionBy(hash: String,
                       completion: @escaping (Result<LTCTransactionByHashResponseModel, CryptoApiError>) -> Void)
    
    /**
     Get transaction history from one address to another
     
     - Parameter blockHeightOrHash: height or hash of block
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter fromAddress: from address
     - Parameter toAddress: to address
     - Parameter completion: Callback which returns an [LTCTransactionsResponseModel](LTCTransactionsResponseModel) result  or error
     */
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<LTCTransactionsResponseModel, CryptoApiError>) -> Void)
    
    /**
     Get outputs list filtered by addresses and status
     
     - Parameter addresses: addresses
     - Parameter status: status
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [[LTCAddressOutputResponseModel]]([LTCAddressOutputResponseModel]) result  or error
     */
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[LTCAddressOutputResponseModel], CryptoApiError>) -> Void)
    
    /**
     Get data about LTC addresses, such as balance.
     Field balance include spent, unspent, confirmed, unconfirmed balance.
     
     - Parameter addresses: addresses
     - Parameter completion: Callback which returns an [[LTCAddressOutInfoResponseModel]]([LTCAddressOutInfoResponseModel]) result  or error
     */
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[LTCAddressOutInfoResponseModel], CryptoApiError>) -> Void)
    
    /**
     Get LTC addresses history.
     
     - Parameter addresses: addresses
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [LTCAddressOutHistoryResponseModel](LTCAddressOutHistoryResponseModel) result  or error
     */
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<LTCAddressOutHistoryResponseModel, CryptoApiError>) -> Void)
    
    /**
     Set firebase notification by addresses (balance updated, new transaction)
     
     - Parameter addresses: addresses
     - Parameter firebaseToken: firebase token
     - Parameter types: notification types
     - Parameter completion: Callback which returns an [LTCPushNotificationsResponseModel](LTCPushNotificationsResponseModel) result  or error
     */
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                    completion: @escaping (Result<LTCPushNotificationsResponseModel, CryptoApiError>) -> Void)
    
    /**
     Remove firebase notification by addresses
     
     - Parameter addresses: addresses
     - Parameter firebaseToken: firebase token
     - Parameter types: notification types
     - Parameter completion: Callback which returns an [LTCPushNotificationsResponseModel](LTCPushNotificationsResponseModel) result  or error
     */
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                      completion: @escaping (Result<LTCPushNotificationsResponseModel, CryptoApiError>) -> Void)
}
