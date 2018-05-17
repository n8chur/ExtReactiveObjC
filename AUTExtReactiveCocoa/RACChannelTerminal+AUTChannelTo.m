//
//  RACChannelTerminal+AUTChannelTo.m
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 3/3/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACChannelTerminal+AUTChannelTo.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACChannelTerminal (AUTChannelTo)

- (RACDisposable *)aut_channelTo:(RACChannelTerminal *)terminal {
    AUTAssertNotNil(terminal);
    
    return [RACCompoundDisposable compoundDisposableWithDisposables:@[
        [terminal subscribe:self],
        [self subscribe:terminal],
    ]];
}

@end

NS_ASSUME_NONNULL_END
