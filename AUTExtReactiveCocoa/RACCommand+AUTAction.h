//
//  RACCommand+AUTAction.h
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 9/28/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

/// Extends RACCommand with methods like those of Action from the RAC 3.0 Swift
/// API.
@interface RACCommand<__contravariant InputType, __covariant ValueType> (AUTAction)

/// A signal of inner signals representing each execution of this action.
///
/// The receiver must have allowsConcurrentExecution set to YES to invoke this
/// getter. If not enabled, an exception will be thrown.
///
/// Unlike -[RACCommand executionSignals], the inner signals here may error out.
@property (nonatomic, strong, readonly) RACSignal<RACSignal<ValueType> *> *aut_executions;

/// The values sent by all executions of this action.
///
/// This signal will never error, and will complete when the action is
/// deallocated.
@property (nonatomic, strong, readonly) RACSignal<ValueType> *aut_values;

/// Replays the latest inner signal sent upon -aut_executions following the
/// invocation of this getter, including any error or completed event.
///
/// Different subscriptions to this signal may connect to different executions
/// of the action.
///
/// Returns a signal that, upon subscription, will replay events from any
/// executions following the invocation of this getter, then forward any future
/// events, or else the previous execution if the action is not currently
/// executing.
@property (nonatomic, strong, readonly) RACSignal<ValueType> *aut_nextExecution;

@end

NS_ASSUME_NONNULL_END
