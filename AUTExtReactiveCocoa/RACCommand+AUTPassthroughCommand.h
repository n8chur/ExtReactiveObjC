//
//  RACCommand+AUTPassthroughCommand.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/17/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand (AUTPassthroughCommand)

/// Creates a command with execution signals that send the inputted value as
/// a next and then complete.
+ (instancetype)aut_passthroughCommand;

/// Creates a command with execution signals that send the inputted value as
/// a next and then complete, and that is enabled when the given
///
/// @param enabled A signal of BOOLs which indicate whether the command should
///        be enabled. Enabled will be based on the latest value sent from this
///        signal. Before any values are sent, enabled will default to YES.
+ (instancetype)aut_passthroughCommandWithEnabled:(nullable RACSignal<NSNumber *> *)enabled;

@end

NS_ASSUME_NONNULL_END
