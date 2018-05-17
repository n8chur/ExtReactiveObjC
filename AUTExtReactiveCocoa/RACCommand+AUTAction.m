//
//  RACCommand+AUTAction.m
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 9/28/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

#import "RACCommand+AUTAction.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (AUTAction)

- (RACSignal *)aut_executions {
    NSAssert(!self.allowsConcurrentExecution, @"%@ is required to be serial to invoke %@, but %@ has concurreny enabled", NSStringFromClass(self.class), NSStringFromSelector(_cmd), self);

    RACSignal *errors = [self.errors flattenMap:^(NSError *error) {
        return [RACSignal error:error];
    }];

    RACSignal *doneExecuting = [self.executing filter:^ BOOL (NSNumber *executing) {
        return !executing.boolValue;
    }];

    return [[self.executionSignals
        map:^(RACSignal *execution) {
            return [[RACSignal
                merge:@[
                    execution,
                    [errors takeUntil:doneExecuting],
                ]]
                replay];
        }]
        setNameWithFormat:@"%@ -aut_executions", self];
}

- (RACSignal *)aut_values {
    return [[self.executionSignals
        concat]
        setNameWithFormat:@"%@ -aut_values", self];
}

- (RACSignal *)aut_nextExecution {
    return [[[[self.aut_executions
        replayLast]
        take:1]
        flatten]
        setNameWithFormat:@"%@ -aut_nextExecution", self];
}

@end

NS_ASSUME_NONNULL_END
