//
//  Dictionary+Extension.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

extension Dictionary where Key: CustomStringConvertible, Value: CustomStringConvertible {
    func stringFromHttpParameters() -> String {
        var parametersString = "?"
        for (key, value) in self {
            parametersString += key.description + "=" + value.description + "&"
        }
        return String(parametersString.dropLast())
    }
}
