//
//  Settings.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final public class Settings {
    public let authorizationToken: AuthorizationToken
    public var workingQueue: DispatchQueue
    public var timeoutIntervalForRequest: TimeInterval
    public var timeoutIntervalForResource: TimeInterval
    public var sessionConfiguration: URLSessionConfiguration
    public var needLogs: Bool
    
    public typealias BuildConfiguratorClosure = (Configurator) -> Void
    
    public init(authorizationToken: AuthorizationToken, build: BuildConfiguratorClosure = { _ in }, isNeedLogs: Bool = false) {
        self.authorizationToken = authorizationToken
        
        let configurator = Configurator()
        build(configurator)
        timeoutIntervalForResource = configurator.timeoutIntervalForResource
        timeoutIntervalForRequest = configurator.timeoutIntervalForRequest
        sessionConfiguration = configurator.sessionConfiguration
        workingQueue = configurator.workingQueue
        needLogs = isNeedLogs
    }
}
