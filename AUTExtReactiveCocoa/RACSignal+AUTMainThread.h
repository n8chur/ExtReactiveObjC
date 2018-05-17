//
//  RACSignal+AUTOnMainThread.h
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 9/28/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType> (AUTMainThread)

/// Creates and returns a signal that executes its side effects and delivers its
/// events on the main thread scheduler.
///
/// Differs from `-[RACSignal subscribeOn:RACScheduler.mainThreadScheduler]`
/// in that subscription will occur synchronously if already on the main thread.
- (RACSignal<ValueType> *)aut_subscribeOnMainThread;

@end

NS_ASSUME_NONNULL_END
