# CryptoAPI-ios-framework (CryptoAPI-ios-framework)

CryptoAPI is Swift API Wrapper framework. Designed to receive information about transactions, balances by address and send transactions.

## Install

This framework can be obtained through CocoaPods:
```
pod 'CryptoAPI', :git => 'git@gitlab.pixelplex.by:709-crypto-api-mobile-library/ios-framework.git'
```

## Setup

For setup framework use this simple code:
```swift
// You can use default configuration
let api = CtyptoAPI.default

// Or you can use custom configuration
let api = CtyptoAPI(settings: Settings(build: {
    $0.timeoutIntervalForRequest = 15
    $0.timeoutIntervalForResource = 15
})
```

## Usage

There are simple examples of usage framework

### ETH

#### Balance

```swift
func testGetBalance() {
    //arrange
    let api = CtyptoAPI.default
    let expectation = XCTestExpectation(description: "testGetBalance")
    let address = ethAddressWithBalance
    //act
    api.eth.balance(addresses: [address]) { result in
        switch result {
        case let .success(balances):
            //assert
            XCTAssertTrue(!balances.isEmpty)
        case let .failure(error):
            //assert
            XCTAssertThrowsError(error)
        }
        expectation.fulfill()
    }

    //assert
    wait(for: [expectation], timeout: testTimeout)
}
```

#### Estimate 

```swift
func testEstimateSendAmountTransaction() {
    //arrange
    let api = CtyptoAPI.default
    let expectation = XCTestExpectation(description: "testEstimateSendAmountTransaction")
    let fromAddress = ethAddressWithBalance
    let toAddress = ethAddressWithBalance2
    let amount = "10"
    let data = ""

    //act
    api.eth.estimateGas(fromAddress: fromAddress, toAddress: toAddress, data: data, value: amount) { result in
        switch result {
        case let .success(estimate):
            //assert
            XCTAssertTrue(!estimate.gasPrice.isEmpty)
        case let .failure(error):
            //assert
            XCTAssertThrowsError(error)
        }
        expectation.fulfill()
    }

    //assert
    wait(for: [expectation], timeout: testTimeout)
}
```

#### History

```swift
func testHistoryAddressTest() {
    //arrange
    let api = CtyptoAPI.default
    let expectation = XCTestExpectation(description: "testHistoryAddressTest")
    let address = ethAddressWithBalance
    let skip = 0
    let limit = 10
    let positive = ""

    //act
    api.eth.transfers(skip: skip, limit: limit, addresses: [address], positive: positive) { result in
        switch result {
        case let .success(history):
            //assert
            XCTAssertTrue(!history.items.isEmpty)
        case let .failure(error):
            //asserts
            XCTAssertThrowsError(error)
        }
        expectation.fulfill()
    }

    //assert
    wait(for: [expectation], timeout: testTimeout)
}
```

### Common

#### Rate

```swift
func testRates() {
    //arrange
    let api = CtyptoAPI.default
    let expectation = XCTestExpectation(description: "testRates")
    //act
    api.common.rates { result in
        switch result {
        case let .success(rates):
            //assert
            XCTAssertTrue(rates.eth.usd > 0)
        case let .failure(error):
            //assert
            XCTAssertThrowsError(error)
        }
        expectation.fulfill()
    }

    //assert
    wait(for: [expectation], timeout: testTimeout)
}
```

#### Rates history

```swift
func testRatesHistory() {
    //arrange
    let api = CtyptoAPI.default
    let expectation = XCTestExpectation(description: "testRatesHistory")
    let coin = "eth"
    //act
    api.common.ratesHistory(coin: coin) { result in
        switch result {
        case let .success(history):
            //assert
            XCTAssertTrue(!history.isEmpty)
        case let .failure(error):
            //assert
            XCTAssertThrowsError(error)
        }
        expectation.fulfill()
    }

    //assert
    wait(for: [expectation], timeout: testTimeout)
}
```

#### Coins

```swift
func testCoins() {
    //arrange
    let api = CtyptoAPI.default
    let expectation = XCTestExpectation(description: "testCoins")
    //act
    api.common.coins { result in
        switch result {
        case let .success(coins):
            //assert
            XCTAssertTrue(!coins.isEmpty)
        case let .failure(error):
            //assert
            XCTAssertThrowsError(error)
        }
        expectation.fulfill()
    }

    //assert
    wait(for: [expectation], timeout: testTimeout)
}
```

