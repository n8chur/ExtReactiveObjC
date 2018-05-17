//
//  RACSerialDisposable+AUTDisposable.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 6/12/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSerialDisposable (AUTDisposable)

/// Otherwise identical to `disposable`, but disposes of the previous disposable
/// when set to a new value (if there was a previous value).
@property (atomic, strong, nullable) RACDisposable *aut_disposable;

@end

NS_ASSUME_NONNULL_END
