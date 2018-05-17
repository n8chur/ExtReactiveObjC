//
//  RACSignal+AUTShareWhileActive.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 9/14/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

@interface RACSignal<__covariant ValueType> (AUTShareWhileActive)

/// Returns a signal that will have at most one subscription to the receiver at
/// any time. When the returned signal gets its first subscriber, the underlying
/// signal is subscribed to. When the returned signal has no subscribers, the
/// underlying subscription is disposed. Whenever an underlying subscription is
/// already open, new subscribers to the returned signal will receive all events
/// sent so far up to capacity.
- (RACSignal<ValueType> *)aut_shareWhileActiveWithCapacity:(NSUInteger)capacity;

/// A shortcut to aut_shareWhileActiveWithCapacity with a value for capacity of
/// RACReplaySubjectUnlimitedCapacity.
- (RACSignal<ValueType> *)aut_shareWhileActive;

@end
