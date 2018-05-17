//
//  UINavigationController+RACAdditions.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 9/22/15.
//  Copyright © 2015 Automatic Labs. All rights reserved.
//

@import ObjectiveC;

#import "AUTExtObjC.h"

#import "UINavigationController+RACAdditions.h"

NS_ASSUME_NONNULL_BEGIN

/// Acts as a proxy for the navigation controller delegate
/// when none has been set.
@interface UINavigationControllerDelegateProxy: NSObject <UINavigationControllerDelegate>

@end

@implementation UINavigationController (RACAdditions)

#pragma mark - Public

- (RACSignal *)aut_willShowViewController {
    return [[[[self aut_delegates]
        map:^(id delegate) {
            return [delegate
                rac_signalForSelector:@selector(navigationController:willShowViewController:animated:)
                fromProtocol:@protocol(UINavigationControllerDelegate)];
        }]
        switchToLatest]
        reduceEach:^(id navigationController, UIViewController *shownViewController, id animated) {
            return shownViewController;
        }];
}

- (RACSignal *)aut_willShowViewController:(UIViewController *)viewController {
    AUTAssertNotNil(viewController);

    return [[[[self aut_willShowViewController]
        filter:^ BOOL (UIViewController *shownViewController) {
            return shownViewController == viewController;
        }]
        take:1]
        ignoreValues];
}

- (RACSignal *)aut_didShowViewController {
    return [[[[self aut_delegates]
        map:^(id delegate) {
            return [delegate
                rac_signalForSelector:@selector(navigationController:didShowViewController:animated:)
                fromProtocol:@protocol(UINavigationControllerDelegate)];
        }]
        switchToLatest]
        reduceEach:^(id navigationController, UIViewController *shownViewController, id animated) {
            return shownViewController;
        }];
    
}

- (RACSignal *)aut_didShowViewController:(UIViewController *)viewController {
    AUTAssertNotNil(viewController);

    return [[[[self aut_didShowViewController]
        filter:^ BOOL (UIViewController *shownViewController) {
            return shownViewController == viewController;
        }]
        take:1]
        ignoreValues];
}

- (RACSignal *)aut_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    AUTAssertNotNil(viewController);

    return [RACSignal defer:^{
        [self pushViewController:viewController animated:animated];

        if (!animated) return [RACSignal empty];

        return [self aut_didShowViewController:viewController];
    }];
}

- (RACSignal *)aut_popViewControllerAnimated:(BOOL)animated {
    return [RACSignal defer:^{
        BOOL didPop = [self popViewControllerAnimated:animated] != nil;

        if (!animated || !didPop) return [RACSignal empty];

        return [self aut_didShowViewController:AUTNotNil(self.viewControllers.lastObject)];
    }];
}

- (RACSignal *)aut_popViewController:(UIViewController *)viewController animated:(BOOL)animated {
    AUTAssertNotNil(viewController);

    return [RACSignal defer:^{
        let viewControllers = self.viewControllers;

        NSInteger index = [viewControllers indexOfObjectIdenticalTo:viewController];
        if (index == NSNotFound || index == 0) return [RACSignal empty];

        let parentViewController = viewControllers[index - 1];
        return [self aut_popToViewController:parentViewController animated:animated];
    }];
}

- (RACSignal *)aut_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    AUTAssertNotNil(viewController);

    return [RACSignal defer:^{
        if (self.viewControllers.lastObject == viewController) return [RACSignal empty];

        [self popToViewController:viewController animated:animated];

        if (!animated) return [RACSignal empty];

        return [self aut_didShowViewController:viewController];
    }];
}

- (RACSignal *)aut_popToRootViewControllerAnimated:(BOOL)animated {
    return [RACSignal defer:^{
        if (self.viewControllers.count <= 1) return [RACSignal empty];

        let rootViewController = self.viewControllers.firstObject;

        [self popToRootViewControllerAnimated:animated];

        if (!animated) return [RACSignal empty];

        return [self aut_didShowViewController:rootViewController];
    }];
}

- (RACSignal *)aut_isAtRootViewController {
    @weakify(self);
    return [[[[self aut_didShowViewController]
        map:^(id _) {
            @strongify(self);
            return @(self.viewControllers.count < 2);
        }]
        startWith:@(self.viewControllers.count < 2)]
        distinctUntilChanged];
}

#pragma mark - Private

/// Sends changes to the receiver's delegate, optionally creating a proxy
/// delegate if one has not been set yet.
- (RACSignal *)aut_delegates {
    @weakify(self)
    return [RACSignal defer:^{
        @strongify(self)
        if (self == nil) return [RACSignal empty];

        if (self.delegate == nil) {
            self.aut_navigationControllerDelegateProxy = [[UINavigationControllerDelegateProxy alloc] init];
            self.delegate = self.aut_navigationControllerDelegateProxy;
        }

        return RACObserve(self, delegate);
    }];
}

- (nullable UINavigationControllerDelegateProxy *)aut_navigationControllerDelegateProxy {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAut_navigationControllerDelegateProxy:(nullable UINavigationControllerDelegateProxy *)delegateProxy {
    objc_setAssociatedObject(self, @selector(aut_navigationControllerDelegateProxy), delegateProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UINavigationControllerDelegateProxy

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {}

@end

NS_ASSUME_NONNULL_END
