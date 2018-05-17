//
//  RACSignal+AUTPolling.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 6/30/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACSignal+AUTPolling.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTPolling)

- (instancetype)aut_pollAtInterval:(NSTimeInterval)interval withTimeout:(NSTimeInterval)timeout onScheduler:(RACScheduler *)scheduler {
    AUTAssertNotNil(scheduler);

    return [[[[[[RACSignal interval:interval onScheduler:scheduler]
        startWith:[NSDate date]]
        timeout:timeout onScheduler:scheduler]
        mapReplace:self]
        concat]
        take:1];
}

@end

NS_ASSUME_NONNULL_END
