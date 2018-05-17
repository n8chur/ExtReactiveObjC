//
//  RACSignal+AUTSynchronizationAdditionsSpec.m
//  AUTExtReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2015-06-18.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

@import Expecta;
@import Specta;
@import AUTExtReactiveCocoa;

SpecBegin(RACSignalAdditions)

__block dispatch_queue_t queue;

beforeEach(^{
    queue = dispatch_queue_create("com.automatic.AUTBatchLogging.RACSignalAdditionsSpec", DISPATCH_QUEUE_SERIAL);
});

afterEach(^{
    queue = nil;
});

it(@"should start work when the queue is available", ^{
    dispatch_suspend(queue);

    __block BOOL done = NO;

    [[[RACSignal
        return:RACUnit.defaultUnit]
        aut_subscribeOnAndOccupyQueue:queue]
        subscribeNext:^(RACUnit *unit) {
            expect(unit).to.equal(RACUnit.defaultUnit);
            done = YES;
        }];

    expect(done).to.beFalsy();
    
    dispatch_resume(queue);
    expect(done).will.beTruthy();
});

it(@"should hold the queue until the signal completes", ^{
    RACSubject<RACUnit *> *subject = [RACReplaySubject subject];
    [subject sendNext:RACUnit.defaultUnit];

    __block BOOL next = NO;
    __block BOOL completed = NO;

    [[subject
        aut_subscribeOnAndOccupyQueue:queue]
        subscribeNext:^(RACUnit *unit) {
            next = YES;
        } completed:^{
            completed = YES;
        }];

    expect(next).will.beTruthy();

    __block BOOL blockRun = NO;
    dispatch_async(queue, ^{
        blockRun = YES;
    });

    expect(completed).to.beFalsy();
    expect(blockRun).to.beFalsy();

    [subject sendCompleted];
    expect(completed).will.beTruthy();
    expect(blockRun).will.beTruthy();
});

it(@"should hold the queue until the signal is disposed", ^{
    __block BOOL next = NO;

    RACDisposable *disposable = [[[RACSignal
        interval:0.01 onScheduler:[RACScheduler scheduler]]
        aut_subscribeOnAndOccupyQueue:queue]
        subscribeNext:^(NSDate *date) {
            expect(date).to.beKindOf(NSDate.class);
            next = YES;
        }];

    expect(next).will.beTruthy();

    __block BOOL blockRun = NO;
    dispatch_async(queue, ^{
        blockRun = YES;
    });

    expect(blockRun).to.beFalsy();

    [disposable dispose];
    expect(blockRun).will.beTruthy();
});

SpecEnd
