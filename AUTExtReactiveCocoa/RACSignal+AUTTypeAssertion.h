//
//  RACSignal+AUTTypeAssertion.h
//  AUTExtReactiveCocoa
//
//  Created by Robert Böhnke on 20/01/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

#import <AUTExtReactiveCocoa/metamacros.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType> (AUTTypeAssertion)

/// Do the given block on `next`.
///
/// Passes the name of the receiver into the block to improve the information
/// on the asserts.
///
/// A no-op on non-DEBUG builds.
- (RACSignal<ValueType> *)aut_debugDoNext:(void (^)(NSString *name, id _Nullable x))block;

@end

#define aut_assertSignalOf(...) \
    metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        (__AUTAssertSingleType(metamacro_head(__VA_ARGS__))) \
        (__AUTAssertRACTuple(__VA_ARGS__))

#define aut_assertSignalOfObjectsConformingToProtocol(PROTOCOL) \
    aut_debugDoNext:^(NSString *name, id value) { \
        __AUTAssertProtocol(PROTOCOL, value, @"Expected '%@' to send values that conform to protocol %@, got %@.", name, @ # PROTOCOL, value); \
    }

// IMPLEMENTATION DETAILS FOLLOW!
// Do not write code that depends on anything below this line.

#define __AUTAssertProtocol(PROTOCOL, VALUE, MESSAGE, ...) \
    NSCAssert([VALUE conformsToProtocol:@protocol(PROTOCOL)], MESSAGE, __VA_ARGS__);

#define __AUTAssertType(TYPE, VALUE, MESSAGE, ...) \
    if (strcmp(@encode(TYPE *), @encode(NSObject *)) == 0) { 	\
        NSCAssert([VALUE isKindOfClass:NSClassFromString(@# TYPE)], MESSAGE, __VA_ARGS__); 	\
    } else { 	\
        NSCAssert([VALUE isKindOfClass:NSValue.class] && strcmp(@encode(TYPE), [(NSValue *)VALUE objCType]) == 0, MESSAGE, __VA_ARGS__); 	\
    }

#define __AUTAssertSingleType(TYPE) \
    aut_debugDoNext:^(NSString *name, id value) { \
        __AUTAssertType(TYPE, value, @"Expected '%@' to send values of type %@, got %@ which is of type %@.", name, @ # TYPE, value, [value class]); \
    }

#define __AUTAssertRACTuple(...) \
    aut_debugDoNext:^(NSString *name, RACTuple *tuple) { \
        NSCAssert([tuple isKindOfClass:RACTuple.class], @"Expected %@ to send RACTuples, got %@.", name, tuple); \
        metamacro_foreach_cxt(__AUTAssertRACTupleIterator,, tuple, __VA_ARGS__) \
    }

#define __AUTAssertRACTupleIterator(INDEX, TUPLE, TYPE) \
    __AUTAssertType(TYPE, TUPLE[INDEX], @"Expected RACTuple value at index %@ to be of type %@, got %@", @(INDEX), @ # TYPE, [TUPLE[INDEX] class]);

NS_ASSUME_NONNULL_END
