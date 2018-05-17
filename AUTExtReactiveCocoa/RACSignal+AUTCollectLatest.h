//
//  RACSignal+AUTCollectLatest.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 3/30/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal (AUTCollectLatest)

/// Combines the latest values from the given signals into an array, once all
/// the signals have sent at least one `next`.
///
/// Nils values are implicitly filtered from the resulting array, so indicies of
/// the provided signals array may not match those of the sent array.
+ (RACSignal<NSArray *> *)aut_collectLatest:(id<NSFastEnumeration>)signals;

@end

NS_ASSUME_NONNULL_END
