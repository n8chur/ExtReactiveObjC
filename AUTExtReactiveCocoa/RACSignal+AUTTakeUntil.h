//
//  RACSignal+AUTTakeUntil.h
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 10/14/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType> (AUTTakeUntil)

/// Takes values until the given block returns `YES`. The value that caused the
/// block to return `YES` will be sent as a next value before the signal
/// completes.
- (RACSignal<ValueType> *)aut_takeUntilAfterBlock:(BOOL (^)(id _Nullable value))block;

@end

NS_ASSUME_NONNULL_END
