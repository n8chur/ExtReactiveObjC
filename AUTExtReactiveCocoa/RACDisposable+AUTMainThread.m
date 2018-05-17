//
//  RACDisposable+AUTMainThread.m
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 9/28/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACDisposable+AUTMainThread.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACDisposable (AUTMainThread)

+ (instancetype)aut_mainThreadDisposableWithBlock:(void (^)())disposable {
    AUTAssertNotNil(disposable);

    return [RACDisposable disposableWithBlock:^{
        if (NSThread.isMainThread) {
            disposable();
            return;
        }
            
        [RACScheduler.mainThreadScheduler schedule:disposable];
    }];
}

@end

NS_ASSUME_NONNULL_END
