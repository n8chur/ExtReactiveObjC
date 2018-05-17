//
//  AUTTupleUnpack.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 4/10/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

#import "metamacros.h"

/// Declares new constant variables and unpacks a generic RAC n-tuple into them.
///
/// Example:
///
///   RACTwoTuple<NSString *, NSNumber *> *stringAndNum = RACTuplePack(@"String", @1);
///   RACNTupleUnpack(stringAndNum, string, num)
///   NSLog(@"string: %@", string);
///   NSLog(@"num: %@", num);
///
///   /* The above is equivalent to: */
///   RACTwoTuple<NSString *, NSNumber *> *stringAndNum = RACTuplePack(@"String", @1);
///   __auto_type const _Nullable string = stringAndNum.first;
///   __auto_type const _Nullable num = stringAndNum.second;
///   NSLog(@"string: %@", string);
///   NSLog(@"num: %@", num);
#define RACNTupleUnpack(Tuple, ...) \
    RACNTupleUnpack_(Tuple, __VA_ARGS__)

/// This and everything below is for internal use only.
///
/// See RACNTupleUnpack() instead.
#define RACNTupleUnpack_(TUPLE, ...) \
    metamacro_foreach_cxt(RACNTupleUnpack_declaration,, TUPLE, __VA_ARGS__)

#define RACNTupleUnpack_declaration(INDEX, TUPLE, ARG) \
    __auto_type const _Nullable ARG = (TUPLE)metamacro_at(INDEX, .first, .second, .third, .fourth, .fifth); \
