//
//  RACCommand+AUTPassthroughCommand.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/17/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

#import "RACCommand+AUTPassthroughCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACCommand (AUTPassthroughCommand)

+ (instancetype)aut_passthroughCommand {
    return [[self alloc] initWithSignalBlock:^(id _Nullable input) {
        return [RACSignal return:input];
    }];
}

+ (instancetype)aut_passthroughCommandWithEnabled:(nullable RACSignal<NSNumber *> *)enabled {
    return [[self alloc] initWithEnabled:enabled signalBlock:^(id _Nullable input) {
        return [RACSignal return:input];
    }];
}

@end

NS_ASSUME_NONNULL_END
