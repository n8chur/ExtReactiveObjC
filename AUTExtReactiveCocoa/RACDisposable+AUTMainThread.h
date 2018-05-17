//
//  RACDisposable+AUTMainThread.h
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 9/28/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACDisposable (AUTMainThread)

/// Performs the supplied dispose block on the main thread.
/// The block will be called synchronously if it is disposed from the main
/// thread, otherwise it will be scheduled on the main thread scheduler.
+ (instancetype)aut_mainThreadDisposableWithBlock:(void (^)())disposable;

@end

NS_ASSUME_NONNULL_END
