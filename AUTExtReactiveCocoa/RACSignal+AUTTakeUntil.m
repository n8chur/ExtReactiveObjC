//
//  RACSignal+AUTTakeUntil.m
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 10/14/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACSignal+AUTTakeUntil.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTTakeUntil)

- (instancetype)aut_takeUntilAfterBlock:(BOOL (^)(id _Nullable value))block {
    AUTAssertNotNil(block);
    
    return [[[self materialize]
        flattenMap:^(RACEvent *event) {
            if (event.eventType == RACEventTypeNext && block(event.value)) {
                return [[RACSignal return:event]
                    concat:[RACSignal return:RACEvent.completedEvent]];
            }
            return [RACSignal return:event];
        }]
        dematerialize];
}

@end

NS_ASSUME_NONNULL_END
