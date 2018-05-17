//
//  RACSignal+AUTShareWhileActive.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 9/14/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

#import "RACSignal+AUTShareWhileActive.h"

@implementation RACSignal (AUTShareWhileActive)

- (RACSignal *)aut_shareWhileActive {
    return [self aut_shareWhileActiveWithCapacity:RACReplaySubjectUnlimitedCapacity];
}

// Adapted from https://gist.github.com/jaredru/5540a15c5a1bdcc31787
- (RACSignal *)aut_shareWhileActiveWithCapacity:(NSUInteger)capacity {
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    lock.name = @"com.github.ReactiveCocoa.shareWhileActive";

    // These should only be used while `lock` is held.
    __block NSUInteger subscriberCount = 0;
    __block RACDisposable *underlyingDisposable;
    __block RACReplaySubject *inflightSubscription;

    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        __block RACSignal *signal;
        __block RACDisposable *disposable;

        [lock lock];
        
        @onExit {
            [lock unlock];
            disposable = [signal subscribe:subscriber];
        };

        if (subscriberCount++ == 0) {
            // We're the first subscriber, so create the underlying
            // subscription.
            inflightSubscription = [RACReplaySubject replaySubjectWithCapacity:capacity];
            underlyingDisposable = [self subscribe:inflightSubscription];
        }

        signal = inflightSubscription;

        return [RACDisposable disposableWithBlock:^{
            [disposable dispose];

            [lock lock];
            @onExit {
                [lock unlock];
            };

            NSCAssert(subscriberCount > 0, @"Mismatched decrement of subscriberCount (%lu)", (unsigned long)subscriberCount);
            if (--subscriberCount == 0) {
                // We're the last subscriber, so dispose of the underlying
                // subscription.
                [underlyingDisposable dispose];
                underlyingDisposable = nil;

                // Also, release the inflightSubscription, since  we won't need
                // its stored values any longer.
                inflightSubscription = nil;
            }
        }];
    }] setNameWithFormat:@"[%@] -shareWhileActive", self.name];
}

@end
