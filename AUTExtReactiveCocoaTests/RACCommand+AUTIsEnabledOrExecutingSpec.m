//
//  RACCommand_AUTIsEnabledOrExecutingSpec.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 12/12/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

@import Specta;
@import Expecta;
@import AUTExtReactiveCocoa;

#import "AUTExtObjC.h"

SpecBegin(RACCommand_AUTIsEnabledOrExecuting)

it(@"should not send values when executed if enabled the whole time", ^{
    let enabled = [RACSignal return:@YES];
    let command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^(id input) {
        return [RACSignal return:input];
    }];

    let finishCollecting = [RACSubject subject];
    let isEnabledOrExecuting = [[command.aut_isEnabledOrExecuting takeUntil:finishCollecting]
        replay];

    NSError *error;
    var success = [[command execute:@"test"] asynchronouslyWaitUntilCompleted:&error];
    expect(error).to.beNil();
    expect(success).to.beTruthy();

    [finishCollecting sendCompleted];

    let isEnabledOrExecutingValues = [[isEnabledOrExecuting collect]
        asynchronousFirstOrDefault:nil success:&success error:&error];

    expect(isEnabledOrExecutingValues).to.equal(@[ @YES ]);
    expect(error).to.beNil();
    expect(success).to.beTruthy();
});

SpecEnd
