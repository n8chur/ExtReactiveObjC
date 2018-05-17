//
//  UIViewController+RACAdditions.h
//  AUTExtReactiveCocoa
//
//  Created by Engin Kurutepe on 11/01/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import Foundation;
@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RACAdditions)

/// Returns a signal which completes when the receiver's view has been loaded.
- (RACSignal *)aut_viewDidLoad;

/// Returns a signal which sends whether the transition will be animated
/// whenever the receiver's view will appear.
- (RACSignal<NSNumber *> *)aut_viewWillAppear;

/// Returns a signal which sends whether the transition will be animated
/// whenever the receiver's view did appear.
- (RACSignal<NSNumber *> *)aut_viewDidAppear;

/// Returns a signal which sends whether the transition will be animated
/// whenever the receiver's view will disappear.
- (RACSignal<NSNumber *> *)aut_viewWillDisappear;

/// Returns a signal which sends whether the transition will be animated
/// whenever the receiver's view did disappear.
- (RACSignal<NSNumber *> *)aut_viewDidDisappear;

/// Returns a signal which sends a next value when the parent view controller of
/// the receiver view controller has changed to `nil`.
- (RACSignal *)aut_didMoveToNilParent;

/// Returns a signal which sends a value when the receiver's view's window
/// becomes `nil`.
- (RACSignal<RACUnit *> *)aut_didMoveToNilWindow;

@end

NS_ASSUME_NONNULL_END
