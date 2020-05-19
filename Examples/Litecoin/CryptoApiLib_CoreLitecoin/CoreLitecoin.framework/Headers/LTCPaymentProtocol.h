// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>
#import "LTCPaymentRequest.h"
#import "LTCPaymentMethodRequest.h"

// Interface to BIP70 payment protocol.
// Spec: https://github.com/bitcoin/bips/blob/master/bip-0070.mediawiki
//
// * LTCPaymentProtocol implements high-level request and response API.
// * LTCPaymentRequest object that represents "PaymentRequest" as described in BIP70.
// * LTCPaymentDetails object that represents "PaymentDetails" as described in BIP70.
// * LTCPayment object that represents "Payment" as described in BIP70.
// * LTCPaymentACK object that represents "PaymentACK" as described in BIP70.

@interface LTCPaymentProtocol : NSObject

// List of accepted asset types.
@property(nonnull, nonatomic, readonly) NSArray* assetTypes;

// Instantiates default BIP70 protocol that supports only Bitcoin.
- (nonnull id) init;

// Instantiates protocol instance with accepted asset types. See LTCAssetType* constants.
- (nonnull id) initWithAssetTypes:(nonnull NSArray*)assetTypes;


// Convenience API

// Loads a LTCPaymentRequest object or LTCPaymentMethodRequest from a given URL.
// May return either PaymentMethodRequest or PaymentRequest, depending on the response from the server.
// This method ignores `assetTypes` and allows both bitcoin and openassets types.
- (void) loadPaymentMethodRequestFromURL:(nonnull NSURL*)paymentMethodRequestURL completionHandler:(nonnull void(^)(LTCPaymentMethodRequest* __nullable pmr, LTCPaymentRequest* __nullable pr, NSError* __nullable error))completionHandler;

// Loads a LTCPaymentRequest object from a given URL.
- (void) loadPaymentRequestFromURL:(nonnull NSURL*)paymentRequestURL completionHandler:(nonnull void(^)(LTCPaymentRequest* __nullable pr, NSError* __nullable error))completionHandler;

// Posts completed payment object to a given payment URL (provided in LTCPaymentDetails) and
// returns a PaymentACK object.
- (void) postPayment:(nonnull LTCPayment*)payment URL:(nonnull NSURL*)paymentURL completionHandler:(nonnull void(^)(LTCPaymentACK* __nullable ack, NSError* __nullable error))completionHandler;


// Low-level API
// (use these if you have your own connection queue).

- (nullable NSURLRequest*) requestForPaymentMethodRequestWithURL:(nonnull NSURL*)url; // default timeout is 10 sec
- (nullable NSURLRequest*) requestForPaymentMethodRequestWithURL:(nonnull NSURL*)url timeout:(NSTimeInterval)timeout;
- (nullable id) polymorphicPaymentRequestFromData:(nonnull NSData*)data response:(nonnull NSURLResponse*)response error:(NSError* __nullable * __nullable)errorOut;

- (nullable NSURLRequest*) requestForPaymentRequestWithURL:(nonnull NSURL*)url; // default timeout is 10 sec
- (nullable NSURLRequest*) requestForPaymentRequestWithURL:(nonnull NSURL*)url timeout:(NSTimeInterval)timeout;
- (nullable LTCPaymentRequest*) paymentRequestFromData:(nonnull NSData*)data response:(nonnull NSURLResponse*)response error:(NSError* __nullable * __nullable)errorOut;

- (nullable NSURLRequest*) requestForPayment:(nonnull LTCPayment*)payment url:(nonnull NSURL*)paymentURL; // default timeout is 10 sec
- (nullable NSURLRequest*) requestForPayment:(nonnull LTCPayment*)payment url:(nonnull NSURL*)paymentURL timeout:(NSTimeInterval)timeout;
- (nullable LTCPaymentACK*) paymentACKFromData:(nonnull NSData*)data response:(nonnull NSURLResponse*)response error:(NSError* __nullable * __nullable)errorOut;


// Deprecated Methods

+ (void) loadPaymentRequestFromURL:(nonnull NSURL*)paymentRequestURL completionHandler:(nonnull void(^)(LTCPaymentRequest* __nullable pr, NSError* __nullable error))completionHandler DEPRECATED_ATTRIBUTE;
+ (void) postPayment:(nonnull LTCPayment*)payment URL:(nonnull NSURL*)paymentURL completionHandler:(nonnull void(^)(LTCPaymentACK* __nullable ack, NSError* __nullable error))completionHandler DEPRECATED_ATTRIBUTE;

+ (nullable NSURLRequest*) requestForPaymentRequestWithURL:(nonnull NSURL*)paymentRequestURL DEPRECATED_ATTRIBUTE; // default timeout is 10 sec
+ (nullable NSURLRequest*) requestForPaymentRequestWithURL:(nonnull NSURL*)paymentRequestURL timeout:(NSTimeInterval)timeout DEPRECATED_ATTRIBUTE;
+ (nullable LTCPaymentRequest*) paymentRequestFromData:(nonnull NSData*)data response:(nonnull NSURLResponse*)response error:(NSError* __nullable * __nullable)errorOut DEPRECATED_ATTRIBUTE;

+ (nullable NSURLRequest*) requestForPayment:(nonnull LTCPayment*)payment url:(nonnull NSURL*)paymentURL DEPRECATED_ATTRIBUTE; // default timeout is 10 sec
+ (nullable NSURLRequest*) requestForPayment:(nonnull LTCPayment*)payment url:(nonnull NSURL*)paymentURL timeout:(NSTimeInterval)timeout DEPRECATED_ATTRIBUTE;
+ (nullable LTCPaymentACK*) paymentACKFromData:(nonnull NSData*)data response:(nonnull NSURLResponse*)response error:(NSError* __nullable * __nullable)errorOut DEPRECATED_ATTRIBUTE;

@end
