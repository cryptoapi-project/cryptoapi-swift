// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

// Implementation of [Automatic Encrypted Wallet Backups](https://github.com/oleganza/bitcoin-papers/blob/master/AutomaticEncryptedWalletBackups.md) scheme.
// For test vectors, see unit tests (LTCEncryptedBackup+Tests.m).

#import <Foundation/Foundation.h>

typedef NS_ENUM(unsigned char, LTCEncryptedBackupVersion) {
    LTCEncryptedBackupVersion1 = 0x01,
};

@class LTCNetwork;
@class LTCKey;
@interface LTCEncryptedBackup : NSObject

// Default version is LTCEncryptedBackupVersion1.
@property(nonatomic, readonly) LTCEncryptedBackupVersion version;

// Timestamp of the backup. If not specified, during encryption set to current time.
@property(nonatomic, readonly) NSTimeInterval timestamp;
@property(nonatomic, readonly) NSDate* date;

@property(nonatomic, readonly) NSData* decryptedData;
@property(nonatomic, readonly) NSData* encryptedData;

@property(nonatomic, readonly) NSString* walletID;
@property(nonatomic, readonly) LTCKey* authenticationKey;

+ (instancetype) encrypt:(NSData*)data backupKey:(NSData*)backupKey;
+ (instancetype) encrypt:(NSData*)data backupKey:(NSData*)backupKey timestamp:(NSTimeInterval)timestamp;
+ (instancetype) decrypt:(NSData*)data backupKey:(NSData*)backupKey;

+ (NSData*) backupKeyForNetwork:(LTCNetwork*)network masterKey:(NSData*)masterKey;
+ (LTCKey*) authenticationKeyWithBackupKey:(NSData*)backupKey;
+ (NSString*) walletIDWithAuthenticationKey:(NSData*)authPubkey;

// For testing/audit purposes only:

@property(nonatomic, readonly) NSData* encryptionKey;
@property(nonatomic, readonly) NSData* iv;
@property(nonatomic, readonly) NSData* merkleRoot;
@property(nonatomic, readonly) NSData* ciphertext;
@property(nonatomic, readonly) NSData* dataForSigning;
@property(nonatomic, readonly) NSData* signature;

@end
