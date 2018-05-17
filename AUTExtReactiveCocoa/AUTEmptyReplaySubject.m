//
//  AUTEmptyReplaySubject.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/24/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import <libkern/OSAtomic.h>

#import "AUTEmptyReplaySubject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACScheduler ()

/// Private method not exposed publicly in ReactiveCocoa.framework.
+ (instancetype)subscriptionScheduler;

@end

@interface AUTEmptyReplaySubject ()  {
    // Atomic backing variable for determining whether self has completed or
    // errored. Set to NULL when not yet terminated, self when completed, and a
    // `NSError` if errored.
    void * volatile _errorOrCompleted;
}

@end

@implementation AUTEmptyReplaySubject

#pragma mark - Lifecycle

- (void)dealloc {
	if (_errorOrCompleted == NULL || _errorOrCompleted == (__bridge void *)self) return;

	CFRelease(_errorOrCompleted);
	_errorOrCompleted = NULL;
}

#pragma mark RACSignal

- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
    RACCompoundDisposable *compoundDisposable = [RACCompoundDisposable compoundDisposable];

    RACDisposable *schedulingDisposable = [RACScheduler.subscriptionScheduler schedule:^{
        if (compoundDisposable.disposed) return;

        NSError *errorOrCompleted = (__bridge NSError *)self->_errorOrCompleted;

        if (errorOrCompleted == (__bridge void *)self) {
            [subscriber sendCompleted];
        } else if (errorOrCompleted != NULL) {
            [subscriber sendError:errorOrCompleted];
        } else {
            RACDisposable *subscriptionDisposable = [super subscribe:subscriber];
            [compoundDisposable addDisposable:subscriptionDisposable];
        }
    }];

    [compoundDisposable addDisposable:schedulingDisposable];

    return compoundDisposable;
}

#pragma mark RACSubscriber

- (void)sendCompleted {
    if (_errorOrCompleted != NULL) return;

    while (YES) {
        void *current = _errorOrCompleted;
        if (current != NULL) return;
        if (OSAtomicCompareAndSwapPtrBarrier(current, (__bridge void *)self, &_errorOrCompleted)) break;
    }

    [super sendCompleted];
}

- (void)sendError:(nullable NSError *)error {
    if (_errorOrCompleted != NULL) return;

    CFTypeRef *bridgedError = (void *)CFBridgingRetain(error);

    while (YES) {
        void *current = _errorOrCompleted;
        if (current != NULL) return;
        if (OSAtomicCompareAndSwapPtrBarrier(current, bridgedError, &_errorOrCompleted)) break;
    }

    [super sendError:error];
}

@end

NS_ASSUME_NONNULL_END
