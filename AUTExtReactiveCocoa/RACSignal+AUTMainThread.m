//
//  RACSignal+AUTMainThread.m
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 9/28/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

#import "RACSignal+AUTMainThread.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTMainThread)

- (instancetype)aut_subscribeOnMainThread {
    return [RACSignal defer:^{
        if (!NSThread.isMainThread) return [self subscribeOn:RACScheduler.mainThreadScheduler];

        return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
            return [self subscribe:subscriber];
        }];
    }];
}

@end

NS_ASSUME_NONNULL_END
