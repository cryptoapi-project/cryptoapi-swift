# CryptoAPI-ios-framework

CryptoAPI is Swift API Wrapper framework. Designed to receive information about transactions, balances and send transactions.

## Install

This framework can be obtained through CocoaPods:
```
pod 'CryptoAPI', :git => 'path to your repo'
```

## Setup

For setup framework use this simple code:
```swift
let settings = Settings(authorizationToken: "Your token")
let api = CryptoAPI(settings: settings)

// Or you can use custom configuration
let settings = Settings(authorizationToken: "Your token") { configurator in
    configurator.workingQueue = DispatchQueue.global()
    configurator.timeoutIntervalForRequest = 30
    configurator.timeoutIntervalForResource = 30
    configurator.sessionConfiguration = URLSessionConfiguration()
    configurator.networkType = NetworkType.testnet
    configurator.debugEnabled = true
}
let api = CryptoAPI(settings: settings)
```

## Usage

### Networks

CryptoAPI supports `mainnet` and `testnet` chains. You can select chain type by `networkType` field when setup framework
```swift
let settings = Settings(authorizationToken: "Your token") { configurator in
    configurator.networkType = NetworkType.testnet
}
let api = CryptoAPI(settings: settings)
```
Awailable `types` you can find [here](/CryptoAPI/NetworkType.swift)

### Servicies

CryptoAPI contains 4 main services for usage.
```swift
let common = api.common
let eth = api.eth
let btc = api.btc
let bch = api.bch
```
`CommonService` protocol you can find [here](/CryptoAPI/Servicies/Protocols/CommonService.swift)

`ETHService` protocol you can find [here](/CryptoAPI/Servicies/Protocols/ETHService.swift)

`BTCService` protocol you can find [here](/CryptoAPI/Servicies/Protocols/BTCService.swift)

`BCHService` protocol you can find [here](/CryptoAPI/Servicies/Protocols/BCHService.swift)

### Error handling

Each request contains `completion` which contains `Swift.Result`. Result returns expected response type or [CryptoApiError](/CryptoAPI/Errors/CryptoApiError.swift)
```swift
api.common.coins { result in
    switch result {
    case let .success(coins):
        // Process result
    case let .failure(error):
        // Process error
    }
    expectation.fulfill()
}
```
