//
//  RACCommand+AUTCommandWithExecutionValues.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 10/22/15.
//  Copyright © 2015 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACCommand+AUTCommandWithExecutionValues.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (AUTCommandWithExecutionValues)

- (RACCommand *)aut_commandWithExecutionValueSignal:(RACSignal *)executionValue {
    AUTAssertNotNil(executionValue);

    @weakify(self);

    return [[RACCommand alloc] initWithEnabled:self.enabled signalBlock:^ RACSignal * (id _) {
        @strongifyOr(self) return [RACSignal empty];

        /// Sends the first value sent by the executionValue signal.
        RACSignal *firstExecutionValue = [executionValue take:1];

        /// Executes self with the first execution value provided by the passed
        /// in signal.
        return [firstExecutionValue flattenMap:^(id value) {
            return [self execute:value];
        }];
    }];
}

- (RACCommand *)aut_commandWithExecutionValue:(nullable id)executionValue {
    @weakify(self);

    return [[RACCommand alloc] initWithEnabled:self.enabled signalBlock:^(id _) {
        @strongifyOr(self) return [RACSignal empty];
        
        return [self execute:executionValue];
    }];
}

@end

NS_ASSUME_NONNULL_END
