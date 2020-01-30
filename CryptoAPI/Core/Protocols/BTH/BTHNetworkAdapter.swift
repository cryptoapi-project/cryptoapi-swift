//
//  BTHNetworkAdapter.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

protocol BTHNetworkAdapter {
    //BTH
    func network(completion: @escaping (Result<BTHNetworkResponseModel, CryptoApiError>) -> Void)
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BTHSendRawResponseModel, CryptoApiError>) -> Void)
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BTHDecodeRawResponseModel, CryptoApiError>) -> Void)
    
    func block(numberOrHash: String,
               completion: @escaping (Result<BTHBlockResponseModel, CryptoApiError>) -> Void)
    
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BTHBlocksResponseModel, CryptoApiError>) -> Void)
    
    func transactionBy(hash: String,
                       completion: @escaping (Result<BTHTransactionByHashResponseModel, CryptoApiError>) -> Void)
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BTHTransactionsResponseModel, CryptoApiError>) -> Void)
    
    func addressesOutputs(addresses: [String], status: String, skip: Int, limit: Int,
                          completion: @escaping (Result<[BTHAddressOutputResponseModel], CryptoApiError>) -> Void)
    
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BTHAddressOutInfoResponseModel], CryptoApiError>) -> Void)
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BTHAddressOutHistoryResponseModel, CryptoApiError>) -> Void)
}
