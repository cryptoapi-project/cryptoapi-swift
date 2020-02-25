//
//  BTcNetworkAdapter.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

protocol BTCNetworkAdapter {
    //BTC
    func network(completion: @escaping (Result<BTCNetworkResponseModel, CryptoApiError>) -> Void)
    
    func estimateFee(completion: @escaping (Result<String, CryptoApiError>) -> Void)
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BTCSendRawResponseModel, CryptoApiError>) -> Void)
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BTCDecodeRawResponseModel, CryptoApiError>) -> Void)
    
    func block(numberOrHash: String,
               completion: @escaping (Result<BTCBlockResponseModel, CryptoApiError>) -> Void)
    
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BTCBlocksResponseModel, CryptoApiError>) -> Void)
    
    func transactionBy(hash: String,
                       completion: @escaping (Result<BTCTransactionByHashResponseModel, CryptoApiError>) -> Void)
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BTCTransactionsResponseModel, CryptoApiError>) -> Void)
    
    func addressesOutputs(addresses: [String], status: String, skip: Int, limit: Int,
                          completion: @escaping (Result<[BTCAddressOutputResponseModel], CryptoApiError>) -> Void)
    
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BTCAddressOutInfoResponseModel], CryptoApiError>) -> Void)
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BTCAddressOutHistoryResponseModel, CryptoApiError>) -> Void)
}
