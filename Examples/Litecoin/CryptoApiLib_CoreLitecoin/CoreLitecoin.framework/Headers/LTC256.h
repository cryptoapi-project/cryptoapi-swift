// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>

// A set of ubiquitous types and functions to deal with fixed-length chunks of data
// (160-bit, 256-bit and 512-bit). These are relevant almost always to hashes,
// but there's no hash-specific about them.
// The purpose of these is to avoid dynamic memory allocations via NSData when
// we need to move exactly 32 bytes around.
//
// We don't call these LTCFixedData256 because these types are way too ubiquituous
// in CoreLitecoin to have such an explicit name.
//
// Somewhat similar to uint256 in bitcoind, but here we don't try
// to pretend that these are integers and then allow arithmetic on them
// and create a mess with the byte order.
// Use LTCBigNumber to do arithmetic on big numbers and convert
// to bignum format explicitly.
// LTCBigNumber has API for converting LTC256 to a big int.
//
// We also declare LTC160 and LTC512 for use with RIPEMD-160, SHA-1 and SHA-512 hashes.


// 1. Fixed-length types

struct private_LTC160
{
    // 160 bits can't be formed with 64-bit words, so we have to use 32-bit ones instead.
    uint32_t words32[5];
} __attribute__((packed));
typedef struct private_LTC160 LTC160;

struct private_LTC256
{
    // Since all modern CPUs are 64-bit (ARM is 64-bit starting with iPhone 5s),
    // we will use 64-bit words.
    uint64_t words64[4];
} __attribute__((aligned(1)));
typedef struct private_LTC256 LTC256;

struct private_LTC512
{
    // Since all modern CPUs are 64-bit (ARM is 64-bit starting with iPhone 5s),
    // we will use 64-bit words.
    uint64_t words64[8];
} __attribute__((aligned(1)));
typedef struct private_LTC512 LTC512;


// 2. Constants

// All-zero constants
extern const LTC160 LTC160Zero;
extern const LTC256 LTC256Zero;
extern const LTC512 LTC512Zero;

// All-one constants
extern const LTC160 LTC160Max;
extern const LTC256 LTC256Max;
extern const LTC512 LTC512Max;

// First 160 bits of SHA512("CoreLitecoin/LTC160Null")
extern const LTC160 LTC160Null;

// First 256 bits of SHA512("CoreLitecoin/LTC256Null")
extern const LTC256 LTC256Null;

// Value of SHA512("CoreLitecoin/LTC512Null")
extern const LTC512 LTC512Null;


// 3. Comparison

BOOL LTC160Equal(LTC160 chunk1, LTC160 chunk2);
BOOL LTC256Equal(LTC256 chunk1, LTC256 chunk2);
BOOL LTC512Equal(LTC512 chunk1, LTC512 chunk2);

NSComparisonResult LTC160Compare(LTC160 chunk1, LTC160 chunk2);
NSComparisonResult LTC256Compare(LTC256 chunk1, LTC256 chunk2);
NSComparisonResult LTC512Compare(LTC512 chunk1, LTC512 chunk2);


// 4. Operations


// Inverse (b = ~a)
LTC160 LTC160Inverse(LTC160 chunk);
LTC256 LTC256Inverse(LTC256 chunk);
LTC512 LTC512Inverse(LTC512 chunk);

// Swap byte order
LTC160 LTC160Swap(LTC160 chunk);
LTC256 LTC256Swap(LTC256 chunk);
LTC512 LTC512Swap(LTC512 chunk);

// Bitwise AND operation (a & b)
LTC160 LTC160AND(LTC160 chunk1, LTC160 chunk2);
LTC256 LTC256AND(LTC256 chunk1, LTC256 chunk2);
LTC512 LTC512AND(LTC512 chunk1, LTC512 chunk2);

// Bitwise OR operation (a | b)
LTC160 LTC160OR(LTC160 chunk1, LTC160 chunk2);
LTC256 LTC256OR(LTC256 chunk1, LTC256 chunk2);
LTC512 LTC512OR(LTC512 chunk1, LTC512 chunk2);

// Bitwise exclusive-OR operation (a ^ b)
LTC160 LTC160XOR(LTC160 chunk1, LTC160 chunk2);
LTC256 LTC256XOR(LTC256 chunk1, LTC256 chunk2);
LTC512 LTC512XOR(LTC512 chunk1, LTC512 chunk2);

// Concatenation of two 256-bit chunks
LTC512 LTC512Concat(LTC256 chunk1, LTC256 chunk2);


// 5. Conversion functions


// Conversion to NSData
NSData* NSDataFromLTC160(LTC160 chunk);
NSData* NSDataFromLTC256(LTC256 chunk);
NSData* NSDataFromLTC512(LTC512 chunk);

// Conversion from NSData.
// If NSData is not big enough, returns LTCHash{160,256,512}Null.
LTC160 LTC160FromNSData(NSData* data);
LTC256 LTC256FromNSData(NSData* data);
LTC512 LTC512FromNSData(NSData* data);

// Returns lowercase hex representation of the chunk
NSString* NSStringFromLTC160(LTC160 chunk);
NSString* NSStringFromLTC256(LTC256 chunk);
NSString* NSStringFromLTC512(LTC512 chunk);

// Conversion from hex NSString (lower- or uppercase).
// If string is invalid or data is too short, returns LTCHash{160,256,512}Null.
LTC160 LTC160FromNSString(NSString* string);
LTC256 LTC256FromNSString(NSString* string);
LTC512 LTC512FromNSString(NSString* string);



