//
//  RACCommand+AUTDidExecute.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/15/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand (AUTDidExecute)

/// Sends YES and completes after the receiver first executes following
/// subscription.
- (RACSignal<NSNumber *> *)aut_didExecute;

@end

NS_ASSUME_NONNULL_END
