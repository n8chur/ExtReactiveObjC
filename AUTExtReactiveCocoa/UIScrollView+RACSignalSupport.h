//
//  UIScrollView+RACSignalSupport.h
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 4/14/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

@import UIKit;
@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (RACSignalSupport)

/// Whether the scroll view is currently scrolling.
///
/// This is an OR of aut_isDragging and aut_isDecelerating.
@property (nonatomic, readonly) RACSignal<NSNumber *> *aut_isScrolling;

/// Whether the scroll view is dragging.
@property (nonatomic, readonly) RACSignal<NSNumber *> *aut_isDragging;

/// Whether the scroll view is decelerating.
@property (nonatomic, readonly) RACSignal<NSNumber *> *aut_isDecelerating;

/// A cold signal that sends next when the scroll view scrolls to a new content
/// offset with a value of the new content offset as a CGPoint
@property (nonatomic, readonly) RACSignal<NSValue *> *aut_didScroll;

/// A cold signal that sends next when the scroll view begins dragging.
@property (nonatomic, readonly) RACSignal<RACUnit *> *aut_willBeginDragging;

/// A cold signal that sends next when the scroll view ends dragging.
@property (nonatomic, readonly) RACSignal<RACUnit *> *aut_didEndDragging;

/// A cold signal that sends next when the scroll view begins decelerating.
@property (nonatomic, readonly) RACSignal<RACUnit *> *aut_willBeginDecelerating;

/// A cold signal that sends next when the scroll view ends decelerating.
@property (nonatomic, readonly) RACSignal<RACUnit *> *aut_didEndDecelerating;

/// A cold signal that sends next when the scroll view ends its scrolling
/// animation.
@property (nonatomic, readonly) RACSignal<RACUnit *> *aut_didEndScrollingAnimation;

/// A cold signal that sends next when the scroll view changes content size with
/// a value of a CGSize.
@property (nonatomic, readonly) RACSignal<NSValue *> *aut_didChangeContentSize;

@end

NS_ASSUME_NONNULL_END
