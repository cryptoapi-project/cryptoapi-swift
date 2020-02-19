//
//  Settings.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final public class Settings {
    public let authorizationToken: String
    public var workingQueue: DispatchQueue
    public var timeoutIntervalForRequest: TimeInterval
    public var timeoutIntervalForResource: TimeInterval
    public var sessionConfiguration: URLSessionConfiguration
    public var networkType: NetworkType
    public var debugEnabled: Bool
    
    public typealias BuildConfiguratorClosure = (Configurator) -> Void
    
    public init(authorizationToken: String, build: BuildConfiguratorClosure = { _ in }) {
        self.authorizationToken = authorizationToken
        
        let configurator = Configurator()
        build(configurator)
        timeoutIntervalForResource = configurator.timeoutIntervalForResource
        timeoutIntervalForRequest = configurator.timeoutIntervalForRequest
        sessionConfiguration = configurator.sessionConfiguration
        workingQueue = configurator.workingQueue
        networkType = configurator.networkType
        debugEnabled = configurator.debugEnabled
    }
    
    public func getBaseUrlString() -> String {
        switch networkType {
        case .mainnet:
            return Constants.mainnetUrl
            
        case .testnet:
            return Constants.testnetUrl
            
        case .stage:
            return Constants.stageUrl
            
        case .dev:
            return Constants.devUrl
        }
    }
}
