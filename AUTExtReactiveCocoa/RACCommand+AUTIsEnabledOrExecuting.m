//
//  RACCommand+AUTIsEnabledOrExecuting.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 8/12/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "RACCommand+AUTIsEnabledOrExecuting.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (AUTIsEnabledOrExecuting)

- (RACSignal *)aut_isEnabledOrExecuting {
    return [[[[RACSignal
        combineLatest:@[
            self.enabled,
            self.executing
        ]]
        or]
        // When executed, make sure that (1, 0, 1) isn't sent.
        throttle:0.0]
        distinctUntilChanged];
}

@end

NS_ASSUME_NONNULL_END
