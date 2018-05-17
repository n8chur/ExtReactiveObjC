//
//  RACSignal+AUTIsNil.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/16/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

#import "RACSignal+AUTIsNil.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTIsNil)

- (RACSignal *)aut_isNil {
    return [self map:^(id _Nullable value) {
        return @(value == nil);
    }];
}

- (RACSignal *)aut_isNotNil {
    return [self map:^(id  _Nullable value) {
        return @(value != nil);
    }];
}

@end

NS_ASSUME_NONNULL_END
