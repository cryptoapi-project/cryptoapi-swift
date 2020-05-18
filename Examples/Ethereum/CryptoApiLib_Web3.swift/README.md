# Using CryptoApiLib library with [Web3.swift](https://github.com/Boilertalk/Web3.swift)

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
    static let authToken = "Your authorization token"
    
    static let toAddress = "recipient address"
    static let sendAmount = "1000000000000000000"
    
    static let privateKey = "0xa26da69ed1df3ba4bb2a231d506b711eace012f1bd2571dfbfff9650b03375af"
}
```
### Generate address. Get balance.
The following is an example that shows how to `generated address and obtain balance` for it using CryptoApiLib.
```swift
let cryptoApi = configCryptoApiLib()

let privateKey = try! EthereumPrivateKey(hexPrivateKey: ExampleConstants.privateKey)
let address = privateKey.address.hex(eip55: true)
print("ETH Address: \(address)")

cryptoApi.eth.balance(addresses: [address]) { result in
    switch result {
    case .success(let addressesBalancesArray):
        for item in addressesBalancesArray {
            print("Balance: \(item.balance)")
        }
    
    case .failure(let error):
        print(error)
    }
}
```
### Estimate nonce, gas price and gas limit
Now, before creating a transaction, you need to get a `gas estimate`.
```swift
cryptoApi.eth.estimateGas(fromAddress: privateKey.address.hex(eip55: true),
                          toAddress: privateKey.address.hex(eip55: true),
                          data: "", value: ExampleConstants.sendAmount) { result in
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
let nonce = EthereumQuantity(quantity: BigUInt(estimatedGas.nonce))
let gasPrice = EthereumQuantity(quantity: try! BigUInt(estimatedGas.gasPrice))
let gasLimit = EthereumQuantity(quantity: BigUInt(estimatedGas.estimateGas))
let value = EthereumQuantity(quantity: 1.eth)
let toAddress = try! EthereumAddress(hex: ExampleConstants.toAddress, eip55: true)

let transaction = EthereumTransaction(
    nonce: nonce,
    gasPrice: gasPrice,
    gas: gasLimit,
    from: privateKey.address,
    to: toAddress,
    value: value
)

let signedTransaction = try! transaction.sign(with: privateKey)
let transactionHex = try! RLPEncoder().encode(signedTransaction.rlp()).toHexString()

cryptoApi.eth.sendRaw(transaction: transactionHex) { result in
    switch result {
    case .success(let txResponse):
        print(txResponse.hash)
    case .failure(let error):
        print(error.localizedDescription)
        return
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
