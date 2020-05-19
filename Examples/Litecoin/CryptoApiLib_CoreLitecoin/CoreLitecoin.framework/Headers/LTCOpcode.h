// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>

// See below for declarations of:
// NSString* LTCNameForOpcode(LTCOpcode opcode);
// LTCOpcode LTCOpcodeForName(NSString* opcodeName);
// LTCOpcode LTCOpcodeForSmallInteger(NSInteger smallInteger);
// NSInteger LTCSmallIntegerFromOpcode(LTCOpcode opcode);


// Script consists of opcodes ("operation codes") and raw binary data.
// Opcodes define how the data is added, removed and modified on the stack.
typedef NS_ENUM(unsigned char, LTCOpcode)
{
    // 1. Operators pushing data on stack.
    
    // Push 1 byte 0x00 on the stack
    LTC_OP_0 = 0x00,
    LTC_OP_FALSE = LTC_OP_0,
    
    // Any opcode with value < PUSHDATA1 is a length of the string to be pushed on the stack.
    // So opcode 0x01 is followed by 1 byte of data, 0x09 by 9 bytes and so on up to 0x4b (75 bytes)
    
    // PUSHDATA<N> opcode is followed by N-byte length of the string that follows.
    LTC_OP_PUSHDATA1 = 0x4c, // followed by a 1-byte length of the string to push (allows pushing 0..255 bytes).
    LTC_OP_PUSHDATA2 = 0x4d, // followed by a 2-byte length of the string to push (allows pushing 0..65535 bytes).
    LTC_OP_PUSHDATA4 = 0x4e, // followed by a 4-byte length of the string to push (allows pushing 0..4294967295 bytes).
    LTC_OP_1NEGATE   = 0x4f, // pushes -1 number on the stack
    LTC_OP_RESERVED  = 0x50, // Not assigned. If executed, transaction is invalid.
    
    // OP_<N> pushes number <N> on the stack
    LTC_OP_1  = 0x51,
    LTC_OP_TRUE = LTC_OP_1,
    LTC_OP_2  = 0x52,
    LTC_OP_3  = 0x53,
    LTC_OP_4  = 0x54,
    LTC_OP_5  = 0x55,
    LTC_OP_6  = 0x56,
    LTC_OP_7  = 0x57,
    LTC_OP_8  = 0x58,
    LTC_OP_9  = 0x59,
    LTC_OP_10 = 0x5a,
    LTC_OP_11 = 0x5b,
    LTC_OP_12 = 0x5c,
    LTC_OP_13 = 0x5d,
    LTC_OP_14 = 0x5e,
    LTC_OP_15 = 0x5f,
    LTC_OP_16 = 0x60,
    
    // 2. Control flow operators
    
    LTC_OP_NOP      = 0x61, // Does nothing
    LTC_OP_VER      = 0x62, // Not assigned. If executed, transaction is invalid.
    
    // BitcoinQT executes all operators from OP_IF to OP_ENDIF even inside "non-executed" branch (to keep track of nesting).
    // Since OP_VERIF and OP_VERNOTIF are not assigned, even inside a non-executed branch they will fall in "default:" switch case
    // and cause the script to fail. Some other ops like OP_VER can be present inside non-executed branch because they'll be skipped.
    LTC_OP_IF       = 0x63, // If the top stack value is not 0, the statements are executed. The top stack value is removed.
    LTC_OP_NOTIF    = 0x64, // If the top stack value is 0, the statements are executed. The top stack value is removed.
    LTC_OP_VERIF    = 0x65, // Not assigned. Script is invalid with that opcode (even if inside non-executed branch).
    LTC_OP_VERNOTIF = 0x66, // Not assigned. Script is invalid with that opcode (even if inside non-executed branch).
    LTC_OP_ELSE     = 0x67, // Executes code if the previous OP_IF or OP_NOTIF was not executed.
    LTC_OP_ENDIF    = 0x68, // Finishes if/else block
    
    LTC_OP_VERIFY   = 0x69, // Removes item from the stack if it's not 0x00 or 0x80 (negative zero). Otherwise, marks script as invalid.
    LTC_OP_RETURN   = 0x6a, // Marks transaction as invalid.
    
    // Stack ops
    LTC_OP_TOALTSTACK   = 0x6b, // Moves item from the stack to altstack
    LTC_OP_FROMALTSTACK = 0x6c, // Moves item from the altstack to stack
    LTC_OP_2DROP = 0x6d,
    LTC_OP_2DUP  = 0x6e,
    LTC_OP_3DUP  = 0x6f,
    LTC_OP_2OVER = 0x70,
    LTC_OP_2ROT  = 0x71,
    LTC_OP_2SWAP = 0x72,
    LTC_OP_IFDUP = 0x73,
    LTC_OP_DEPTH = 0x74,
    LTC_OP_DROP  = 0x75,
    LTC_OP_DUP   = 0x76,
    LTC_OP_NIP   = 0x77,
    LTC_OP_OVER  = 0x78,
    LTC_OP_PICK  = 0x79,
    LTC_OP_ROLL  = 0x7a,
    LTC_OP_ROT   = 0x7b,
    LTC_OP_SWAP  = 0x7c,
    LTC_OP_TUCK  = 0x7d,
    
    // Splice ops
    LTC_OP_CAT    = 0x7e, // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_SUBSTR = 0x7f, // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_LEFT   = 0x80, // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_RIGHT  = 0x81, // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_SIZE   = 0x82,
    
    // Bit logic
    LTC_OP_INVERT = 0x83, // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_AND    = 0x84, // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_OR     = 0x85, // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_XOR    = 0x86, // Disabled opcode. If executed, transaction is invalid.
    
    LTC_OP_EQUAL = 0x87,        // Last two items are removed from the stack and compared. Result (true or false) is pushed to the stack.
    LTC_OP_EQUALVERIFY = 0x88,  // Same as OP_EQUAL, but removes the result from the stack if it's true or marks script as invalid.
    
    LTC_OP_RESERVED1 = 0x89, // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_RESERVED2 = 0x8a, // Disabled opcode. If executed, transaction is invalid.
    
    // Numeric
    LTC_OP_1ADD      = 0x8b,  // adds 1 to last item, pops it from stack and pushes result.
    LTC_OP_1SUB      = 0x8c,  // substracts 1 to last item, pops it from stack and pushes result.
    LTC_OP_2MUL      = 0x8d,  // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_2DIV      = 0x8e,  // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_NEGATE    = 0x8f,  // negates the number, pops it from stack and pushes result.
    LTC_OP_ABS       = 0x90,  // replaces number with its absolute value
    LTC_OP_NOT       = 0x91,  // replaces number with True if it's zero, False otherwise.
    LTC_OP_0NOTEQUAL = 0x92,  // replaces number with True if it's not zero, False otherwise.
    
    LTC_OP_ADD    = 0x93,  // (x y -- x+y)
    LTC_OP_SUB    = 0x94,  // (x y -- x-y)
    LTC_OP_MUL    = 0x95,  // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_DIV    = 0x96,  // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_MOD    = 0x97,  // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_LSHIFT = 0x98,  // Disabled opcode. If executed, transaction is invalid.
    LTC_OP_RSHIFT = 0x99,  // Disabled opcode. If executed, transaction is invalid.
    
    LTC_OP_BOOLAND            = 0x9a,
    LTC_OP_BOOLOR             = 0x9b,
    LTC_OP_NUMEQUAL           = 0x9c,
    LTC_OP_NUMEQUALVERIFY     = 0x9d,
    LTC_OP_NUMNOTEQUAL        = 0x9e,
    LTC_OP_LESSTHAN           = 0x9f,
    LTC_OP_GREATERTHAN        = 0xa0,
    LTC_OP_LESSTHANOREQUAL    = 0xa1,
    LTC_OP_GREATERTHANOREQUAL = 0xa2,
    LTC_OP_MIN                = 0xa3,
    LTC_OP_MAX                = 0xa4,
    
    LTC_OP_WITHIN = 0xa5,
    
    // Crypto
    LTC_OP_RIPEMD160      = 0xa6,
    LTC_OP_SHA1           = 0xa7,
    LTC_OP_SHA256         = 0xa8,
    LTC_OP_HASH160        = 0xa9,
    LTC_OP_HASH256        = 0xaa,
    LTC_OP_CODESEPARATOR  = 0xab, // This opcode is rarely used because it's useless, but we need to support it anyway.
    LTC_OP_CHECKSIG       = 0xac,
    LTC_OP_CHECKSIGVERIFY = 0xad,
    LTC_OP_CHECKMULTISIG  = 0xae,
    LTC_OP_CHECKMULTISIGVERIFY = 0xaf,
    
    // Expansion
    LTC_OP_NOP1  = 0xb0,
    LTC_OP_NOP2  = 0xb1,
    LTC_OP_NOP3  = 0xb2,
    LTC_OP_NOP4  = 0xb3,
    LTC_OP_NOP5  = 0xb4,
    LTC_OP_NOP6  = 0xb5,
    LTC_OP_NOP7  = 0xb6,
    LTC_OP_NOP8  = 0xb7,
    LTC_OP_NOP9  = 0xb8,
    LTC_OP_NOP10 = 0xb9,
    
    LTC_OP_INVALIDOPCODE = 0xff,
};


// Returns name for opcode or @"OP_UNKNOWN" for unknown opcode.
NSString* LTCNameForOpcode(LTCOpcode opcode);

// Returns opcode integer for a given name. Returns OP_INVALIDOPCODE for unknown name.
LTCOpcode LTCOpcodeForName(NSString* opcodeName);

// Returns OP_1NEGATE, OP_0 .. OP_16 for ints from -1 to 16.
// Returns OP_INVALIDOPCODE for other ints.
LTCOpcode LTCOpcodeForSmallInteger(NSInteger smallInteger);

// Converts opcode OP_<N> or OP_1NEGATE to an integer value.
// If incorrect opcode is given, NSIntegerMax is returned.
NSInteger LTCSmallIntegerFromOpcode(LTCOpcode opcode);




