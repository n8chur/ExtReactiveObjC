//
//  RACCommand+AUTImmediateExecutions.m
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 9/21/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "RACCommand+AUTImmediateExecutions.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand ()

/// Expose private property.
@property (nonatomic, strong, readonly) RACSubject *addedExecutionSignalsSubject;

@end

@implementation RACCommand (AUTImmediateExecutions)

- (RACSignal *)aut_immediateExecutions {
    return self.addedExecutionSignalsSubject;
}

@end

NS_ASSUME_NONNULL_END
