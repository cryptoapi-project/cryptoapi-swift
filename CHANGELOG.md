# CHANGELOG

## Changelog 0.4.5 - 2021-03-29
### Changed
* CryptoNotificationTokenType: add balance enum value
* CryptoNotificationType: add all enum value

## Changelog 0.4.4 - 2021-03-10
### Added
* Add support RUB rates

## Changelog 0.4.3 - 2021-02-24
### Added
* CryptoNotificationTokenType for subscribe to token push notifications

## Changelog 0.4.2 - 2020-06-29
### Added
* Subscribe/unsubscribe methods to push notifications for Ethereum tokens
* Pending transactions for Ethereum

### Removed
* Rub currency for RatesResponseModel

## Changelog 0.4.1 - 2020-06-09
### Added
* CryptoCurrencyType enum
* EthereumTokenType enum
* CryptoNotificationType enum
* BTCPushNotificationsResponseModel struct

### Changed
* Method subscribePushNotifications. Added types parameter(array of CryptoNotificationType) and response result model(BTCPushNotificationsResponseModel)
* Method unsubscribePushNotifications. Added types parameter(array of CryptoNotificationType) and response result model(BTCPushNotificationsResponseModel)
* ETHTokensQueryResponseModel. Property types is [EthereumTokenType] 
* ETHTokenQueryResponseModel. Property type is EthereumTokenType 

## Changelog 0.4.0 - 2020-05-19
### Added
* Litecoin integration

## Changelog 0.3.6 - 2020-05-18
### Added
* ETHInternalTransaction object to ETHExternalTransfersResponseModel and ETHTransactionsResponseModel
* Imput field to ETHExternalTransfersResponseModel

### Fixed
* To field to optional in ETHTransfersResponseModel
* Positive field to Bool in transfers method in ETHService
* Errors fields protection level
* Status field to optional in ETHTokenQueryResponseModel
* ETH examples

## Changelog 0.3.5 - 2020-04-06
### Added
* Getting rates and rates history methods
* Subscribe and unsubscribe methods for push notification

### Fixed
* Get transaction receipt method for Ethereum network
* Mapping String responses
