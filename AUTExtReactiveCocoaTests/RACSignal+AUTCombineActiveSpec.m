//
//  RACSignal+AUTCombineActiveSpec.m
//  AUTExtReactiveCocoa
//
//  Created by James Lawton on 1/27/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import Specta;
@import Expecta;
@import AUTExtReactiveCocoa;

SpecBegin(RACSignal_AUTCombineActive)

__block NSError *error;
__block BOOL success;

beforeEach(^{
    error = nil;
    success = NO;
});

it(@"should combine two signals", ^{
    __block int firstSubscriptionCount = 0;
    RACSubject *firstLife = [RACSubject subject];
    RACSubject *secondLife = [RACSubject subject];
    RACSignal *first = [[[RACSignal return:@1] concat:firstLife]
        initially:^{
            firstSubscriptionCount++;
        }];
    RACSignal *second = [[RACSignal return:@2] concat:secondLife];

    __block BOOL combinedCompleted = NO;
    RACSubject *signals = [RACSubject subject];
    RACSignal *combined = [[[signals aut_combineLatestWhileActive]
        doCompleted:^{
            combinedCompleted = YES;
        }]
        replayLast];

    [signals sendNext:first];
    RACTuple *value = [combined firstOrDefault:nil success:&success error:&error];

    // Value from firstSignal gets added to the tuple
    expect(success).to.beTruthy();
    expect(error).to.beNil();
    expect(value).to.haveACountOf(1);
    expect(value.first).to.equal(@1);

    [signals sendNext:second];
    value = [combined firstOrDefault:nil success:&success error:&error];

    // Value from secondSignal gets added to the tuple
    expect(success).to.beTruthy();
    expect(error).to.beNil();
    expect(value).to.haveACountOf(2);
    expect(value.first).to.equal(@1);
    expect(value.second).to.equal(@2);

    [firstLife sendCompleted];
    value = [combined firstOrDefault:nil success:&success error:&error];

    // Value from first signal gets removed from the tuple
    expect(success).to.beTruthy();
    expect(error).to.beNil();
    expect(value).to.haveACountOf(1);
    expect(value.first).to.equal(@2);

    [secondLife sendCompleted];
    value = [combined firstOrDefault:nil success:&success error:&error];

    // Value from second signal gets removed from the tuple
    expect(success).to.beTruthy();
    expect(error).to.beNil();
    expect(value).to.haveACountOf(0);

    expect(combinedCompleted).to.beFalsy();

    [signals sendCompleted];
    success = [combined asynchronouslyWaitUntilCompleted:&error];

    // Completes successfully
    expect(success).to.beTruthy();
    expect(error).to.beNil();
    expect(combinedCompleted).to.beTruthy();

    expect(firstSubscriptionCount).to.equal(1);
});

SpecEnd
