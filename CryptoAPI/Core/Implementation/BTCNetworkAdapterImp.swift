//
//  BTCNetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class BTCNetworkAdapterImp: BTCNetworkAdapter {
    let session: URLSession
    let authToken: AuthorizationToken
    
    init(session: URLSession, authToken: AuthorizationToken) {
        self.session = session
        self.authToken = authToken
    }
    
    func network(completion: @escaping (Result<BTCNetworkResponseModel, CryptoApiError>) -> Void) {
        BTCNetwork.network.request(type: BTCNetworkResponseModel.self, session: session, authToken: authToken, completionHandler: completion)
    }
}
