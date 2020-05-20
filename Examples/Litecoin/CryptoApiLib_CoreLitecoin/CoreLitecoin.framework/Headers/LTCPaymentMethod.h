// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>
#import "LTCUnitsAndLimits.h"

@class LTCAssetID;
@class LTCPaymentMethodItem;
@class LTCPaymentMethodAsset;
@class LTCPaymentMethodRejection;
@class LTCPaymentMethodRejectedAsset;

// Reply by the user: payment_method, methods per item, assets per method.
@interface  LTCPaymentMethod : NSObject

@property(nonatomic, nullable) NSData* merchantData;
@property(nonatomic, nullable) NSArray* /* [LTCPaymentMethodItem] */ items;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;
@end





// Proposed method to pay for a given item
@interface  LTCPaymentMethodItem : NSObject

@property(nonatomic, nonnull) NSString* itemType;
@property(nonatomic, nullable) NSData* itemIdentifier;
@property(nonatomic, nullable) NSArray* /* [LTCPaymentMethodAsset] */ assets;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;
@end





// Proposed asset and amount within LTCPaymentMethodItem.
@interface  LTCPaymentMethodAsset : NSObject

@property(nonatomic, nullable) NSString* assetType; // LTCAssetTypeBitcoin or LTCAssetTypeOpenAssets
@property(nonatomic, nullable) LTCAssetID* assetID; // nil if type is "bitcoin".
@property(nonatomic) LTCAmount amount;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;
@end






// Rejection reply by the server: rejection summary and per-asset rejection info.


@interface  LTCPaymentMethodRejection : NSObject

@property(nonatomic, nullable) NSString* memo;
@property(nonatomic) uint64_t code;
@property(nonatomic, nullable) NSArray* /* [LTCPaymentMethodRejectedAsset] */ rejectedAssets;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;
@end


@interface  LTCPaymentMethodRejectedAsset : NSObject

@property(nonatomic, nonnull) NSString* assetType;  // LTCAssetTypeBitcoin or LTCAssetTypeOpenAssets
@property(nonatomic, nullable) LTCAssetID* assetID; // nil if type is "bitcoin".
@property(nonatomic) uint64_t code;
@property(nonatomic, nullable) NSString* reason;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;
@end

