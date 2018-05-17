//
//  RACSignal+AUTDelayUntilAfterNextExecutionOf.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 3/31/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACSignal+AUTDelayUntilAfterNextExecutionOf.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTDelayUntilAfterNextExecutionOf)

- (RACSignal *)aut_delayUntilAfterNextExecutionOf:(RACCommand *)command {
    AUTAssertNotNil(command);

    return [RACSignal defer:^{
        RACSignal *values = [self replay];

        RACSignal *nextExecution = [[[command.executionSignals
            take:1]
            flatten]
            ignoreValues];

        return [nextExecution concat:values];
    }];
}

@end

NS_ASSUME_NONNULL_END
