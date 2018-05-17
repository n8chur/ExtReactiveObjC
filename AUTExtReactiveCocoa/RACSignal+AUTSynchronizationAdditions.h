//
//  RACSignal+AUTSynchronizationAdditions.h
//  AUTExtReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2015-06-18.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType> (AUTSynchronizationAdditions)

/// Asynchronously subscribes to the receiver on the given GCD queue, then
/// blocks all other work on the queue until the signal has terminated or been
/// disposed.
- (RACSignal<ValueType> *)aut_subscribeOnAndOccupyQueue:(dispatch_queue_t)queue;

@end

NS_ASSUME_NONNULL_END
