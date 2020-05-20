// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LTCSecretSharingVersion) {
    // Identifies configuration for compact 128-bit secrets with up to 16 shares.
    LTCSecretSharingVersionCompact96  = 96,
    LTCSecretSharingVersionCompact104 = 104,
    LTCSecretSharingVersionCompact128 = 128,
};

@class LTCBigNumber;
@interface LTCSecretSharing : NSObject

@property(nonatomic, readonly) LTCSecretSharingVersion version;
@property(nonatomic, readonly, nonnull) LTCBigNumber* order;
@property(nonatomic, readonly) NSInteger bitlength;

- (id __nonnull) initWithVersion:(LTCSecretSharingVersion)version;

- (NSArray<NSData*>* __nullable) splitSecret:(NSData* __nonnull)secret threshold:(NSInteger)m shares:(NSInteger)n error:(NSError* __nullable * __nullable)errorOut;

- (NSData* __nullable) joinShares:(NSArray<NSData*>* __nonnull)shares error:(NSError* __nullable * __nullable)errorOut;

@end
