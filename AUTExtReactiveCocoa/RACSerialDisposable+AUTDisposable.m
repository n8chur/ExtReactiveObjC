//
//  RACSerialDisposable+AUTDisposable.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 6/12/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "RACSerialDisposable+AUTDisposable.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSerialDisposable (AUTDisposable)

- (nullable RACDisposable *)aut_disposable {
    return self.disposable;
}

- (void)setAut_disposable:(nullable RACDisposable *)newDisposable {
    [[self swapInDisposable:newDisposable] dispose];
}

@end

NS_ASSUME_NONNULL_END
