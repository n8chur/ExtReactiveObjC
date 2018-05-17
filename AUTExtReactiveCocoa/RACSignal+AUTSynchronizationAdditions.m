//
//  RACSignal+AUTSynchronizationAdditions.m
//  AUTExtReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2015-06-18.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import "RACSignal+AUTSynchronizationAdditions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTSynchronizationAdditions)

- (RACSignal *)aut_subscribeOnAndOccupyQueue:(dispatch_queue_t)queue {
    NSParameterAssert(queue != NULL);

    return [[RACSignal
        createSignal:^(id<RACSubscriber> subscriber) {
            RACSerialDisposable *serialDisposable = [[RACSerialDisposable alloc] init];

            dispatch_barrier_async(queue, ^{
                if (serialDisposable.disposed) return;

                // Suspend the queue, to prevent other work from starting before
                // we've finished.
                dispatch_suspend(queue);

                RACDisposable *subscriptionDisposable = [self subscribe:subscriber];

                serialDisposable.disposable = [RACDisposable disposableWithBlock:^{
                    [subscriptionDisposable dispose];

                    // Allow other work to continue.
                    dispatch_resume(queue);
                }];
            });

            return serialDisposable;
        }]
        setNameWithFormat:@"%@ %s %@", self, sel_getName(_cmd), queue];
}

@end

NS_ASSUME_NONNULL_END
