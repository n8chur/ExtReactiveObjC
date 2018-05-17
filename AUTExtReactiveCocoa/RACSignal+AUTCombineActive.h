//
//  RACSignal+AUTCombineActive.h
//  AUTExtReactiveCocoa
//
//  Created by James Lawton on 1/27/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal (AUTCombineActive)

/// Returns a signal of `RACTuple`, representing the latest values from all
/// incomplete signals sent on the receiver.
///
/// The length of the tuple will vary, increasing when an incomplete signal is
/// sent over the receiver, and decreasing when one of the signals that was sent
/// completes.
///
/// After a signal is sent on the receiver, no values will be sent on the
/// returned signal until that inner signal sends a value or completes.
///
/// The returned signal will error if any of the inner signals error.
///
/// The receiver must only send RACSignals.
- (RACSignal<RACTuple *> *)aut_combineLatestWhileActive;

@end

NS_ASSUME_NONNULL_END
