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
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BTCSendRawResponseModel, CryptoApiError>) -> Void)
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BTCDecodeRawResponseModel, CryptoApiError>) -> Void)

}
