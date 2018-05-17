//
//  RACSignal+AUTCollectLatest.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 3/30/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACSignal+AUTCollectLatest.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTCollectLatest)

+ (RACSignal<NSArray *> *)aut_collectLatest:(id<NSFastEnumeration>)signals {
    AUTAssertNotNil(signals);

    return [[self combineLatest:signals]
        map:^(RACTuple *values) {
            return [values.rac_sequence ignore:NSNull.null].array;
        }];
}

@end

NS_ASSUME_NONNULL_END
