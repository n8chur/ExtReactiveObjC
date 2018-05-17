//
//  RACCommand+AUTOneShotCommand.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/18/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "RACCommand+AUTOneShotCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (AUTOneShotCommand)

+ (instancetype)aut_oneShotCommandWithSignalBlock:(RACSignal<id> * (^)(id input))signalBlock {
    RACSubject<NSNumber *> *enabled = [RACSubject subject];

    RACCommand *command = [[self alloc] initWithEnabled:enabled signalBlock:signalBlock];

    // Disable the command following its first execution.
    [[[command.executionSignals
        take:1]
        mapReplace:@NO]
        subscribe:enabled];

    return command;
}

@end

NS_ASSUME_NONNULL_END
