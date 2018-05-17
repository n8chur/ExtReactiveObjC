//
//  UIScrollView+RACSignalSupport.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 4/14/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

@import ObjectiveC;
@import ReactiveObjC;

#import "AUTExtObjC.h"

#import "UIScrollView+RACSignalSupport.h"

NS_ASSUME_NONNULL_BEGIN

/// An internal object that serves as the delegate for the UIScrollView
@interface AUTScrollViewDelegateProxy : NSObject <UIScrollViewDelegate>

@end

@interface UIScrollView ()

@property (nonatomic, nullable) AUTScrollViewDelegateProxy *aut_scrollViewDelegateProxy;

@end

@implementation UIScrollView (RACSignalSupport)

- (RACSignal *)aut_isDecelerating {
    return [RACSignal merge:@[
        [[self aut_willBeginDecelerating] mapReplace:@YES],
        [[self aut_didEndDecelerating] mapReplace:@NO]
    ]];
}

- (RACSignal *)aut_isDragging {
    return [RACSignal merge:@[
        [[self aut_willBeginDragging] mapReplace:@YES],
        [[self aut_didEndDragging] mapReplace:@NO]
    ]];
}

- (RACSignal *)aut_isScrolling {
    return [[[RACSignal
        combineLatest:@[
            [self aut_isDecelerating],
            [self aut_isDragging],
        ]]
        or]
        distinctUntilChanged];
}

#pragma mark Delegate Associated Object

- (nullable AUTScrollViewDelegateProxy *)aut_scrollViewDelegateProxy {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAut_scrollViewDelegateProxy:(nullable AUTScrollViewDelegateProxy *)scrollViewDelegateProxy {
    objc_setAssociatedObject(self, @selector(aut_scrollViewDelegateProxy), scrollViewDelegateProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Bindings

- (BOOL)aut_isBindingEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setAut_isBindingEnabled:(BOOL)aut_isBindingEnabled {
    objc_setAssociatedObject(self, @selector(aut_isBindingEnabled), @(aut_isBindingEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Delegate Proxies

- (RACSignal *)aut_didScroll {
    @weakify(self);

    let currentContentOffset = [RACSignal defer:^{
        @strongifyOr(self) return [RACSignal empty];
        return [RACSignal return:[NSValue valueWithCGPoint:self.contentOffset]];
    }];

    let contentOffsetOnSCroll = [[[self aut_signalForScrollViewDelegateSelector:@selector(scrollViewDidScroll:)]
        map:^ NSValue * (id _) {
            @strongifyOr(self) return nil;
            return [NSValue valueWithCGPoint:self.contentOffset];
        }]
        ignore:nil];

    return [currentContentOffset concat:contentOffsetOnSCroll];
}

- (RACSignal *)aut_willBeginDragging {
    return [self aut_signalForScrollViewDelegateSelector:@selector(scrollViewWillBeginDragging:)];
}

- (RACSignal *)aut_didEndDragging {
    return [self aut_signalForScrollViewDelegateSelector:@selector(scrollViewDidEndDragging:willDecelerate:)];
}

- (RACSignal *)aut_willBeginDecelerating {
    return [self aut_signalForScrollViewDelegateSelector:@selector(scrollViewWillBeginDecelerating:)];
}

- (RACSignal *)aut_didEndDecelerating {
    return [self aut_signalForScrollViewDelegateSelector:@selector(scrollViewDidEndDecelerating:)];
}

- (RACSignal *)aut_didEndScrollingAnimation {
    return [self aut_signalForScrollViewDelegateSelector:@selector(scrollViewDidEndScrollingAnimation:)];
}

- (RACSignal *)aut_signalForScrollViewDelegateSelector:(SEL)selector {
    [self aut_setupDelegateProxyIfNecessary];

    return [[RACObserve(self, delegate)
        map:^(NSObject <UIScrollViewDelegate> *delegate) {
            return [[delegate
                rac_signalForSelector:selector fromProtocol:@protocol(UIScrollViewDelegate)]
                mapReplace:RACUnit.defaultUnit];
        }]
        switchToLatest];
}

- (RACSignal *)aut_didChangeContentSize {
    // There's no good way to check for changing content size besides KVO on a
    // UIKit property. Thankfully this one seems to be compliant.
    return RACObserve(self, contentSize);
}

#pragma mark Setup

- (void)aut_setupDelegateProxyIfNecessary {
    // Create a delegate if there isn't one that we can lift selectors.
    if (self.delegate != nil) return;

    self.aut_scrollViewDelegateProxy = [[AUTScrollViewDelegateProxy alloc] init];
    self.delegate = self.aut_scrollViewDelegateProxy;
}

@end

@implementation AUTScrollViewDelegateProxy

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {}

@end

NS_ASSUME_NONNULL_END
