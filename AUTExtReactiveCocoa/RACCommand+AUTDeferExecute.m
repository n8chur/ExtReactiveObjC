//
//  RACCommand+AUTDeferExecute.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 12/18/15.
//  Copyright © 2015 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACCommand+AUTDeferExecute.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (AUTDeferExecute)

- (RACSignal *)aut_deferExecute:(nullable id)input {
    @weakify(self);

    return [RACSignal defer:^{
        @strongifyOr(self) return [RACSignal empty];

        return [self execute:input];
    }];
}

@end

NS_ASSUME_NONNULL_END
