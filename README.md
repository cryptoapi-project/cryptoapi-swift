# CryptoApiLib
CryptoAPI is Swift API Wrapper framework. Designed to receive information about transactions, balances and send transactions.

## Install

This framework can be obtained through CocoaPods:
```
pod 'CryptoApiLib'
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
Awailable `types` you can find [here](/CryptoAPI/NetworkType.swift).

### Servicies

CryptoAPI contains 4 main services for usage.
```swift
let common = api.common
let eth = api.eth
let btc = api.btc
let bch = api.bch
```
`CommonService` protocol you can find [here](/CryptoAPI/Servicies/Protocols/CommonService.swift).

`ETHService` protocol you can find [here](/CryptoAPI/Servicies/Protocols/ETHService.swift).

`BTCService` protocol you can find [here](/CryptoAPI/Servicies/Protocols/BTCService.swift).

`BCHService` protocol you can find [here](/CryptoAPI/Servicies/Protocols/BСHServiсe.swift).

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
## Examples

Examples with popular `Bitсoin` libraries you can find [here](/Examples/Bitcoin).

Examples with popular `Ethereum` libraries you can find [here](/Examples/Ethereum).

## License

The MIT License (MIT)

Copyright (c) 2019 PixelPlex Inc. <https://pixelplex.io>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
