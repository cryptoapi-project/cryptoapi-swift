// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import "LTCAddress.h"

@interface LTCAssetID : LTCAddress

+ (nullable instancetype) assetIDWithHash:(nullable NSData*)data;

+ (nullable instancetype) assetIDWithString:(nullable NSString*)string;

@end
