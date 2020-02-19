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
    let baseUrl: String
    let authToken: String
    let needLogs: Bool
    
    init(session: URLSession, baseUrl: String, authToken: String, needLogs: Bool) {
        self.session = session
        self.baseUrl = baseUrl
        self.authToken = authToken
        self.needLogs = needLogs
    }
    
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void) {
        CommonNetwork.coins
            .request(type: [String].self, session: session, baseUrl: baseUrl,
                     authToken: authToken, withLog: needLogs, completionHandler: completion)
    }
}
