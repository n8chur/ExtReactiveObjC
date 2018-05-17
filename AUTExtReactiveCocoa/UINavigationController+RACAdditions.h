//
//  UINavigationController+RACAdditions.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 9/22/15.
//  Copyright © 2015 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (RACAdditions)

/// Sends the view controllers that will be shown by the receiver.
///
/// Completes when the receiver deallocates.
- (RACSignal<UIViewController *> *)aut_willShowViewController;

/// Completes just before the receiver displays the given view controller.
- (RACSignal *)aut_willShowViewController:(UIViewController *)viewController;

/// Sends the view controllers that were be shown by the receiver.
///
/// Completes when the receiver deallocates.
- (RACSignal<UIViewController *> *)aut_didShowViewController;

/// Completes when the receiver displays the given view controller.
- (RACSignal *)aut_didShowViewController:(UIViewController *)viewController;

/// Pushes the given view controller onto the receiver's navigation stack,
/// completing when finished.
- (RACSignal *)aut_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// Pops the current top view controller off of the receiver's navigation stack,
/// completing when finished.
- (RACSignal *)aut_popViewControllerAnimated:(BOOL)animated;

/// Pops view controllers off of the receiver's navigation stack until the
/// specified view controller is popped off the navigation stack, completing
/// when finished.
- (RACSignal *)aut_popViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// Pops view controllers off of the receiver's navigation stack until the
/// specified view controller is at the top of the navigation stack, completing
/// when finished.
- (RACSignal *)aut_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// Pops all the view controllers off of the receiver's navigation stack except
/// the root view controller, completing when finished.
- (RACSignal *)aut_popToRootViewControllerAnimated:(BOOL)animated;

/// Sends whether the receiver has only the root view controller on stack.
- (RACSignal<NSNumber *> *)aut_isAtRootViewController;

@end

NS_ASSUME_NONNULL_END
