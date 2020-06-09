//
//  BTCService.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public protocol BTCService {
/**
     Network information
     
     - Parameter completion: Callback which returns an [BTCNetworkResponseModel](BTCNetworkResponseModel) result  or error
*/
    func network(completion: @escaping (Result<BTCNetworkResponseModel, CryptoApiError>) -> Void)
    
/**
    Fee per Kb information
         
    - Parameter completion: Callback which returns an [Strint](String) result  or error
*/
    func feePerKb(completion: @escaping (Result<String, CryptoApiError>) -> Void)
        
/**
     Send raw btc transaction.
     
     - Parameter transaction: transaction hex
     - Parameter completion: Callback which returns an [BTCSendRawResponseModel](BTCSendRawResponseModel) result  or error
*/
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BTCSendRawResponseModel, CryptoApiError>) -> Void)
    
/**
     Decode raw btc transaction hex.
     
     - Parameter transaction: transaction hex
     - Parameter completion: Callback which returns an [BTCDecodeRawResponseModel](BTCDecodeRawResponseModel) result  or error
*/
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BTCDecodeRawResponseModel, CryptoApiError>) -> Void)
    
/**
     Returns block object by number or hash
     
     - Parameter numberOrHash: number or hash of block
     - Parameter completion: Callback which returns an [BTCBlockResponseModel](BTCBlockResponseModel) result  or error
*/
    func block(numberOrHash: String,
               completion: @escaping (Result<BTCBlockResponseModel, CryptoApiError>) -> Void)
    
/**
     Returns blocks
     
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [BTCBlocksResponseModel](BTCBlocksResponseModel) result  or error
*/
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BTCBlocksResponseModel, CryptoApiError>) -> Void)
    
/**
     Get transaction by hash
     
     - Parameter hash: hash of transaction
     - Parameter completion: Callback which returns an [BTCTransactionByHashResponseModel](BTCTransactionByHashResponseModel) result  or error
*/
    func transactionBy(hash: String,
                       completion: @escaping (Result<BTCTransactionByHashResponseModel, CryptoApiError>) -> Void)
    
/**
     Get transaction history from one address to another
     
     - Parameter blockHeightOrHash: height or hash of block
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter fromAddress: from address
     - Parameter toAddress: to address
     - Parameter completion: Callback which returns an [BTCTransactionsResponseModel](BTCTransactionsResponseModel) result  or error
*/
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BTCTransactionsResponseModel, CryptoApiError>) -> Void)
    
/**
     Get outputs list filtered by addresses and status
     
     - Parameter addresses: addresses
     - Parameter status: status
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [[BTCAddressOutputResponseModel]]([BTCAddressOutputResponseModel]) result  or error
*/
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[BTCAddressOutputResponseModel], CryptoApiError>) -> Void)
    
/**
     Get data about btc addresses, such as balance.
     Field balance include spent, unspent, confirmed, unconfirmed balance.
     
     - Parameter addresses: addresses
     - Parameter completion: Callback which returns an [[BTCAddressOutInfoResponseModel]]([BTCAddressOutInfoResponseModel]) result  or error
*/
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BTCAddressOutInfoResponseModel], CryptoApiError>) -> Void)
    
/**
     Get btc addresses history.
     
     - Parameter addresses: addresses
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [BTCAddressOutHistoryResponseModel](BTCAddressOutHistoryResponseModel) result  or error
*/
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BTCAddressOutHistoryResponseModel, CryptoApiError>) -> Void)
    
    /**
     Set firebase notification by addresses (balance updated, new transaction)
     
     - Parameter addresses: addresses
     - Parameter firebaseToken: firebase token
     - Parameter types: notification types
     - Parameter completion: Callback which returns an [BTCPushNotificationsResponseModel](BTCPushNotificationsResponseModel) result  or error
     */
    
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: [CryptoNotificationType],
                                    completion: @escaping (Result<BTCPushNotificationsResponseModel, CryptoApiError>) -> Void)
    
    /**
     Remove firebase notification by addresses
     
     - Parameter addresses: addresses
     - Parameter firebaseToken: firebase token
     - Parameter types: notification types
     - Parameter completion: Callback which returns an [BTCPushNotificationsResponseModel](BTCPushNotificationsResponseModel) result  or error
     */
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: [CryptoNotificationType],
                                      completion: @escaping (Result<BTCPushNotificationsResponseModel, CryptoApiError>) -> Void)
}
