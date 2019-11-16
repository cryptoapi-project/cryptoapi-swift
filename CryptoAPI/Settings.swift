//
//  Settings.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final public class Settings {
    public var workingQueue: DispatchQueue
    public var timeoutIntervalForRequest: TimeInterval
    public var timeoutIntervalForResource: TimeInterval
    public var sessionConfiguration: URLSessionConfiguration
    
    public typealias BuildConfiguratorClosure = (Configurator) -> Void
    
    public init(build: BuildConfiguratorClosure = { _ in }) {
        let configurator = Configurator()
        build(configurator)
        timeoutIntervalForResource = configurator.timeoutIntervalForResource
        timeoutIntervalForRequest = configurator.timeoutIntervalForRequest
        sessionConfiguration = configurator.sessionConfiguration
        workingQueue = configurator.workingQueue
    }
}
