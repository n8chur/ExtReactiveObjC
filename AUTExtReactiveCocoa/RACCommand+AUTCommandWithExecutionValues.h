//
//  RACCommand+AUTCommandWithExecutionValues.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 10/22/15.
//  Copyright © 2015 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand<__contravariant InputType, __covariant ValueType> (AUTCommandWithExecutionValues)

/// Creates a command that proxies for receiver and is able to have its
/// execution value injected in advance.
///
/// When the returned command is executed, the provided executionValue signal is
/// subscribed to, and its first value is used to execute the receiver.
- (RACCommand *)aut_commandWithExecutionValueSignal:(RACSignal<ValueType> *)executionValue;

/// Creates a command that proxies for receiver and is able to have its
/// execution value injected in advance.
///
/// When the returned command is executed, the value is used to execute the receiver.
- (RACCommand *)aut_commandWithExecutionValue:(nullable InputType)executionValue;

@end

NS_ASSUME_NONNULL_END
