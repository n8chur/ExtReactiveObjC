//
//  AUTEmptyReplaySubject.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/24/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

/// A subject that replays error and complete events, but not next values.
///
/// In contrast with RACReplaySubject, does not @synchronize on itself when
/// sending events or receiving subscriptions since it does not maintain a
/// history of next values.
@interface AUTEmptyReplaySubject<ValueType> : RACSubject<ValueType>

@end

NS_ASSUME_NONNULL_END
