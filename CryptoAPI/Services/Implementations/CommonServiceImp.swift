//
//  CommonService.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

final class CommonServiceImp: CommonService {
    let networkAdapter: CommonNetworkAdapter

    public init(networkAdapter: CommonNetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
    
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void) {
        networkAdapter.coins(completion: completion)
    }
}
