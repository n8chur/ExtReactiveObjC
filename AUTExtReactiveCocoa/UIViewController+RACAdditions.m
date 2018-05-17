//
//  UIViewController+RACAdditions.m
//  AUTExtReactiveCocoa
//
//  Created by Engin Kurutepe on 11/01/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACSignal+AUTTypeAssertion.h"

#import "UIViewController+RACAdditions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIViewController (RACAdditions)

- (RACSignal *)aut_viewDidLoad {
    @weakify(self);
    return [RACSignal defer:^{
        @strongifyOr(self) return [RACSignal empty];

        if (self.isViewLoaded) return [RACSignal empty];

        return [[[self rac_signalForSelector:@selector(viewDidLoad)]
            take:1]
            ignoreValues];
    }];
}

- (RACSignal *)aut_viewWillAppear {
    return [self rac_signalForSelector:@selector(viewWillAppear:)];
}

- (RACSignal *)aut_viewDidAppear {
    return [self rac_signalForSelector:@selector(viewDidAppear:)];
}

- (RACSignal *)aut_viewWillDisappear {
    return [self rac_signalForSelector:@selector(viewWillDisappear:)];
}

- (RACSignal *)aut_viewDidDisappear {
    return [self rac_signalForSelector:@selector(viewDidDisappear:)];
}

- (RACSignal *)aut_didMoveToNilParent {
    return [[self
        rac_signalForSelector:@selector(didMoveToParentViewController:)]
        filter:^ BOOL (RACTuple *args) {
            return args.first == nil;
        }];
}

- (RACSignal *)aut_didMoveToNilWindow {
    @weakify(self);

    return [[[[[[self
        aut_viewDidLoad]
        then:^{
            @strongifyOr(self) return [RACSignal empty];

            return [[self.view rac_signalForSelector:@selector(didMoveToWindow)] mapReplace:self.view];
        }]
        filter:^ BOOL (UIView *view) {
            return view.window == nil;
        }]
        mapReplace:RACUnit.defaultUnit]
        aut_assertSignalOf(RACUnit)]
        setNameWithFormat:@"autDidMoveToNilWindow"];
}

@end

NS_ASSUME_NONNULL_END
