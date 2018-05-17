//
//  RACSignal+AUTTypeAssertion.m
//  AUTExtReactiveCocoa
//
//  Created by Robert Böhnke on 20/01/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "RACSignal+AUTTypeAssertion.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RACSignal (AUTTypeAssertion)

- (instancetype)aut_debugDoNext:(void (^)(NSString *name, id x))block {
#ifdef DEBUG
    AUTAssertNotNil(block);

    NSString *name = self.name;

    return [self doNext:^(id x) {
        block(name, x);
    }];
#else
    return self;
#endif
}

@end

NS_ASSUME_NONNULL_END
