//
//  RACSignal_AUTIsNilSpec.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 1/16/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

@import Specta;
@import Expecta;
@import AUTExtReactiveCocoa;

#import "AUTExtObjC.h"

SpecBegin(RACSignal_AUTIsNil)

__block NSError *error;
__block BOOL success;
__block RACSubject<NSString *> *notNilThenNil;

beforeEach(^{
    error = nil;
    success = NO;

    notNilThenNil = [RACReplaySubject subject];
    [notNilThenNil sendNext:@"not nil"];
    [notNilThenNil sendNext:nil];
    [notNilThenNil sendCompleted];
});

describe(@"aut_isNil", ^{
    it(@"should send whether the values are nil", ^{
        let areValuesNil = [[[notNilThenNil aut_isNil]
            collect]
            asynchronousFirstOrDefault:nil success:&success error:&error];

        expect(success).to.beTruthy();
        expect(error).to.beNil();

        expect(areValuesNil).to.equal(@[ @NO, @YES ]);
    });
});

describe(@"aut_isNotNil", ^{
    it(@"should send whether the values are not nil", ^{
        let areValuesNotNil = [[[notNilThenNil aut_isNotNil]
            collect]
            asynchronousFirstOrDefault:nil success:&success error:&error];

        expect(success).to.beTruthy();
        expect(error).to.beNil();

        expect(areValuesNotNil).to.equal(@[ @YES, @NO ]);
    });
});

SpecEnd
