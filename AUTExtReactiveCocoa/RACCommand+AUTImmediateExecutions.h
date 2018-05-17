//
//  RACCommand+AUTImmediateExecutions.h
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 9/21/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand<__contravariant InputType, __covariant ValueType> (AUTImmediateExecutions)

/// A signal of inner signals representing each execution of this action.
///
/// Unlike -[RACCommand executionSignals], the inner signals here may error out,
/// and are sent from the scheduler that -[RACCommand execute:] was invoked from
/// rather than the main thread scheduler.
@property (readonly, nonatomic) RACSignal<RACSignal<ValueType> *> *aut_immediateExecutions;

@end

NS_ASSUME_NONNULL_END
