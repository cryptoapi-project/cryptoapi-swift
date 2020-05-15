# Using CryptoApiLib library with [EthereumKit](https://github.com/D-Technologies/EthereumKit)

### Get started

Сonfigure and return the object of the CryptoAPI class, which will allow to perform all the operations provided by the CryptoApiLib library.
Further, we can use the obtained method to get the CryptoAPI object anywhere in the program.
```swift
func configCryptoApiLib() -> CryptoAPI {
    // Initialize setting for CryptoApi with your authorization token.
    let apiSettings = Settings(authorizationToken: ExampleConstants.authToken) { configurator in
        configurator.networkType = NetworkType.testnet
    }
    let cryptoApi = CryptoAPI(settings: apiSettings)
    
    return cryptoApi
}
```
### Constanst
The example has an `enum with constants` that can be modified with valid data to run the example.
```swift
enum ExampleConstants {
    static let authToken = "Your token"
    
    static let fromAddress = "sender address"
    static let toAddress = "recipient address"
    static let sendAmount = "100000000000000"
    
    static let mnemonicHex = "000102030405060708090a0b0c0d0e0f"
}
```
### Generate address. Get balance.
The following is an example that shows how to `generated address and obtain balance` for it using CryptoApiLib.
```swift
let cryptoApi = configCryptoApiLib()

let mnemonic = Mnemonic.create(entropy: Data(hex: ExampleConstants.mnemonicHex))
let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
let wallet = try! Wallet(seed: seed, network: .private(chainID: 4, testUse: true), debugPrints: true)

let address = wallet.address()

cryptoApi.eth.balance(addresses: [address]) { result in
    switch result {
    case .success(let addressesBalancesArray):
        for item in addressesBalancesArray {
            print("Balance \(item.balance) wei")
        }
        
    case .failure(let error):
        print(error)
    }
}
```
### Estimate nonce, gas price and gas limit
Now, before creating a transaction, you need to get a `gas estimate`.
```swift
cryptoApi.eth.estimateGas(fromAddress: ExampleConstants.fromAddress, toAddress: ExampleConstants.toAddress, data: "", value: ExampleConstants.sendAmount) { result in
    switch result {
    case .success(let response):
        print("nonse: \(response.nonce), gas prise: \(response.gasPrice), estimate: \(response.estimateGas).")
        return
    case .failure(let error):
        print(error)
        return
    }
}
```
### Create and Send trantaction
CryptoAPI allows you to send raw transactions, but before that you need to prepare it.
`Creating and sending a transaction` is as follows:
```swift
let value = Wei(ExampleConstants.sendAmount)!

let rawTransaction = RawTransaction(
    value: value,
    to: ExampleConstants.toAddress,
    gasPrice: Int(response.gasPrice)!,
    gasLimit: response.estimateGas,
    nonce: response.nonce
)
let transactionHash = try! wallet.sign(rawTransaction: rawTransaction)

cryptoApi.eth.sendRaw(transaction: transactionHash) { result in
    switch result {
    case .success(let response):
        print(response.hash)
        return
        
    case .failure(let error):
        fatalError("Error: \(error.localizedDescription)")
    }
}
```


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
