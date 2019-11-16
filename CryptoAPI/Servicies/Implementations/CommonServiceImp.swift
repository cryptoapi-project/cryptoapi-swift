//
//  CommonService.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

final class CommonServiceImp: CommonService {
    let networkAdapter: NetworkAdapter

    public init(networkAdapter: NetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
}
