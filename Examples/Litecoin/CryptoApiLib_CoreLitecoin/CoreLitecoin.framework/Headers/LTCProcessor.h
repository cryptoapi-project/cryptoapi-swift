// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>

@class LTCBlock;
@class LTCTransaction;
@class LTCProcessor;
@class LTCNetwork;

extern NSString* const LTCProcessorErrorDomain;

typedef NS_ENUM(NSUInteger, LTCProcessorError) {
    
    // Block already stored in the blockchain (on mainchain or sidechain)
    LTCProcessorErrorDuplicateBlock,
    
    // Block already stored as orphan
    LTCProcessorErrorDuplicateOrphanBlock,
    
    // Block has timestamp below last downloaded checkpoint.
    LTCProcessorErrorTimestampBeforeLastCheckpoint,
    
    // Proof of work is below the minimum possible since the last checkpoint.
    LTCProcessorErrorBelowCheckpointProofOfWork,
    
};

// Data source implements actual storage for blocks, block headers and transactions.
@protocol LTCProcessorDataSource <NSObject>
@required

// Returns a block in the blockchain (mainchain or sidechain), or nil if block is missing.
- (LTCBlock*) blockWithHash:(NSData*)hash;

// Returns YES if the block exists in the blockchain (mainchain or sidechain).
- (BOOL) blockExistsWithHash:(NSData*)hash;

// Returns orphan block with the given hash (or nil if block is not stored among orphans).
- (LTCBlock*) orphanBlockWithHash:(NSData*)hash;

// Returns YES if orphan block exists.
- (BOOL) orphanBlockExistsWithHash:(NSData*)hash;

@end



// Delegate allows to handle errors and selectively ignore them for testing purposes.
@protocol LTCProcessorDelegate <NSObject>
@optional

// For some error codes, userInfo[@"DoS"] contains level of DoS punishment.
// If this method returns NO, error is ignored and processing continues.
- (BOOL) processor:(LTCProcessor*)processor shouldRejectBlock:(LTCBlock*)block withError:(NSError*)error;

// Sent when processing stopped because of an error.
- (void) processor:(LTCProcessor*)processor didRejectBlock:(LTCBlock*)block withError:(NSError*)error;

@end



// Processor implements validation and processing of the incoming blocks and unconfirmed transactions.
// It defers storage to data source which takes care of storing and retrieving all objects efficiently.
@interface LTCProcessor : NSObject

// Network (mainnet/testnet) that should be used by processor.
// Default is mainnet.
@property(nonatomic) LTCNetwork* network;

// Data source provides block headers, blocks, and transactions during the process of verification.
// Should not be nil when processing blocks and transactions.
@property(nonatomic, weak) id<LTCProcessorDataSource> dataSource;

// Delegate allows fine-grained control of errors that happen. Can be nil.
@property(nonatomic, weak) id<LTCProcessorDelegate> delegate;

// Attempts to process the block. Returns YES on success, NO and error on failure.
// Make sure to set dataSource before calling this method.
// See ProcessBlock() in bitcoind.
- (BOOL) processBlock:(LTCBlock*)block error:(NSError**)errorOut;

// Attempts to add transaction to "memory pool" of unconfirmed transactions.
// Make sure to set dataSource before calling this method.
// See AcceptToMemoryPool() in bitcoind.
- (BOOL) processTransaction:(LTCTransaction*)transaction error:(NSError**)errorOut;

@end
