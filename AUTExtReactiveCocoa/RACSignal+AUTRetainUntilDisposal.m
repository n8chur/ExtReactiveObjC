//
//  RACSignal+AUTRetainUntilDisposal.m
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 7/8/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACSignal+AUTRetainUntilDisposal.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTRetainUntilDisposal)

- (instancetype)aut_retainUntilDisposal:(id)object {
    AUTAssertNotNil(object);
    
    return [self finally:^{
        __unused id obj = object;
    }];
}

@end

NS_ASSUME_NONNULL_END
