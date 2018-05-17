//
//  RACCommand+AUTDeferExecute.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 12/18/15.
//  Copyright © 2015 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand<__contravariant InputType, __covariant ValueType> (AUTDeferExecute)

/// A cold signal that defers invocation of the receiver's execute: until
/// subscription with the provided input.
///
/// Executes once for each subscription to the returned signal.
- (RACSignal<ValueType> *)aut_deferExecute:(nullable InputType)input;

@end

NS_ASSUME_NONNULL_END
