//
//  RACCommand+AUTIsEnabledOrExecuting.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 8/12/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand (AUTIsEnabledOrExecuting)

/// Sends YES when the receiver is either enabled or executing, or NO otherwise.
@property (readonly, nonatomic) RACSignal<NSNumber *> *aut_isEnabledOrExecuting;

@end

NS_ASSUME_NONNULL_END
