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
    var needLogs: Bool
    
    init(session: URLSession, authToken: AuthorizationToken, needLogs: Bool) {
        self.session = session
        self.authToken = authToken
        self.needLogs = needLogs
    }
    
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void) {
        CommonNetwork.coins
            .request(type: [String].self, session: session, authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
}
