//
//  RACSignal_AUTCollectLatestSpec.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 3/30/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

@import Specta;
@import Expecta;
@import AUTExtReactiveCocoa;

#import "AUTExtObjC.h"

SpecBegin(RACSignal_AUTCollectLatest)

__block NSError *error;
__block BOOL success;
__block RACSubject<NSNumber *> *subject1;
__block RACSubject<NSNumber *> *subject2;

beforeEach(^{
    error = nil;
    success = NO;

    subject1 = [RACReplaySubject subject];
    subject2 = [RACReplaySubject subject];
});

describe(@"aut_collectLatest", ^{
    it(@"should send the latest collected values as they change", ^{
        [subject1 sendNext:@1];
        [subject2 sendNext:@2];

        let values = [[RACSignal aut_collectLatest:@[ subject1, subject2 ]]
            asynchronousFirstOrDefault:nil success:&success error:&error];

        expect(success).to.beTruthy();
        expect(error).to.beNil();

        expect(values).to.equal(@[ @1, @2 ]);
    });

    it(@"should filter nil values", ^{
        [subject1 sendNext:@1];
        [subject2 sendNext:nil];

        let values = [[RACSignal aut_collectLatest:@[ subject1, subject2 ]]
            asynchronousFirstOrDefault:nil success:&success error:&error];

        expect(success).to.beTruthy();
        expect(error).to.beNil();

        expect(values).to.equal(@[ @1 ]);
    });
});

SpecEnd
