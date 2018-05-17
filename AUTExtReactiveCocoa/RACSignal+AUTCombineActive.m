//
//  RACSignal+AUTCombineActive.m
//  AUTExtReactiveCocoa
//
//  Created by James Lawton on 1/27/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "RACSignal+AUTCombineActive.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTCombineActive)

- (RACSignal *)aut_combineLatestWhileActive {
    // Storage for active signals
    NSMutableArray *activeSignals = [NSMutableArray array];

    // Sends an array of the signals that have been sent over the receiver that
    // have yet to complete.
    RACSignal *currentSignals = [self flattenMap:^(RACSignal *added) {
        NSCParameterAssert([added isKindOfClass:RACSignal.class]);

        // Ensure that we always have a value and don't subscribe to
        // `added` multiple times.
        RACSignal *replay = [added replayLast];

        // Keep track of added and completed signals, sending the array of all
        // current signals.
        return [RACSignal concat:@[
            // Add the new signal
            [[RACSignal return:activeSignals] initially:^{
                [activeSignals addObject:replay];
            }],
            // Wait for the new signal to complete
            [replay ignoreValues],
            // Remove the completed signal
            [[RACSignal return:activeSignals] initially:^{
                [activeSignals removeObject:replay];
            }]
        ]];
    }];

    // Return a tuple of all the most recent values from the active signals.
    return [[currentSignals
        flattenMap:^ RACSignal<RACTuple *> * (NSArray *signals) {
            if (signals.count == 0) return [RACSignal return:[[RACTuple alloc] init]];

            return [RACSignal combineLatest:signals];
        }]
        setNameWithFormat:@"[%@] -aut_combineLatestWhileActive", self.name];
}

@end

NS_ASSUME_NONNULL_END
