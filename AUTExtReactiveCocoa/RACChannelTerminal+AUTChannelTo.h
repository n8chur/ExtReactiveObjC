//
//  RACChannelTerminal+AUTChannelTo.h
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 3/3/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACChannelTerminal<ValueType> (AUTChannelTo)

/// Subscribes the receiver to the provided terminal and vice versa.
- (RACDisposable *)aut_channelTo:(RACChannelTerminal<ValueType> *)terminal;

@end

NS_ASSUME_NONNULL_END
