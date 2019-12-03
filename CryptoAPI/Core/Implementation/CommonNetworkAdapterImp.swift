//
//  CommonNetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/19/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final class CommonNetworkAdapterImp: CommonNetworkAdapter {
    let session: URLSession
    let authToken: AuthorizationToken
    
    init(session: URLSession, authToken: AuthorizationToken) {
        self.session = session
        self.authToken = authToken
    }
    
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void) {
        CommonNetwork.coins
            .request(type: [String].self, session: session, authToken: authToken, completionHandler: completion)
    }
}
