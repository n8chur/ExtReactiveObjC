//
//  RACCommand+AUTOneShotCommand.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/18/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand<__contravariant InputType, __covariant ValueType> (AUTOneShotCommand)

/// Creates a command that may only be executed once, becoming disabled
/// immediately following its first execution.
+ (instancetype)aut_oneShotCommandWithSignalBlock:(RACSignal<ValueType> * (^)(InputType InputType))signalBlock;

@end

NS_ASSUME_NONNULL_END
