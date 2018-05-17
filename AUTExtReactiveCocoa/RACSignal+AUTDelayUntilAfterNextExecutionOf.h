//
//  RACSignal+AUTDelayUntilAfterNextExecutionOf.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 3/31/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType> (AUTDelayUntilAfterNextExecutionOf)

/// Delays the events from the receiver until the provided command has finished
/// its next execution. Once the execution has finished, forwards events as they
/// arrive.
- (RACSignal<ValueType> *)aut_delayUntilAfterNextExecutionOf:(RACCommand *)command;

@end

NS_ASSUME_NONNULL_END
