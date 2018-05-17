//
//  RACSignal+AUTIsNil.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/16/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType> (AUTIsNil)

/// Maps the values in the receiver to YES if the value is nil, and NO if the
/// value is non-nil.
- (RACSignal<NSNumber *> *)aut_isNil;

/// Maps the values in the receiver to NO if the value is nil, and YES if the
/// value is non-nil.
- (RACSignal<NSNumber *> *)aut_isNotNil;

@end

NS_ASSUME_NONNULL_END
