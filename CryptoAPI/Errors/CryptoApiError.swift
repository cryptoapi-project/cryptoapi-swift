//
//  CryptoApiError.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public enum CryptoApiError: Swift.Error {
    case innerError(Error)
    case customError(CryptoApiTypedError)
    case customErrorList(CryptoApiTypedErrors)
}

public struct CryptoApiTypedErrors: Codable {
    let errors: [CryptoApiTypedError]
    let status: Int
}

public struct CryptoApiTypedError: Codable {
    let message: String
    let field: String
}
