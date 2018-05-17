//
//  RACCommand+AUTDidExecute.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/15/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "RACCommand+AUTDidExecute.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (AUTDidExecute)

- (RACSignal *)aut_didExecute {
    return [[[self.executionSignals take:1]
        flatten]
        then:^{
            return [RACSignal return:@YES];
        }];
}

@end

NS_ASSUME_NONNULL_END
