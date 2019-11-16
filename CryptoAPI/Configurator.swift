//
//  Configurator.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final public class Configurator {
    public var workingQueue: DispatchQueue = DispatchQueue.main
    public var timeoutIntervalForRequest: TimeInterval = 15
    public var timeoutIntervalForResource: TimeInterval = 15
    public var sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
}
