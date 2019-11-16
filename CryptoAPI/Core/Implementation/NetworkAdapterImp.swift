//
//  NetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final class NetworkAdapterImp: NetworkAdapter {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func balance(address: String,
                 completion: @escaping (() throws -> (BalanceModel)) -> Void) {
        
    }
}
