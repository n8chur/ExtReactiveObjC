//
//  RACSignal+AUTPolling.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 6/30/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType> (AUTPolling)

/// Returns a signal that repeatedly subscribes to the receiver at the provided
/// interval, until the given timeout, and with the provided scheduler.
///
/// Stops polling if a timeout is reached, the receiver errors, or the receiver
/// sends a value. If the receiver takes more than the provided interval to
/// complete, the operation will be performed back-to-back interval/timeout
/// times.
///
/// If the timeout is reached, errors with the RACSignalErrorTimedOut error.
- (RACSignal<ValueType> *)aut_pollAtInterval:(NSTimeInterval)interval withTimeout:(NSTimeInterval)timeout onScheduler:(RACScheduler *)scheduler;

@end

NS_ASSUME_NONNULL_END
