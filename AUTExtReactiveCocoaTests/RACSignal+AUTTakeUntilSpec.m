//
//  RACSignal+AUTTakeUntilSpec.m
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 10/14/16.
//  Copyright © 2016 Automatic. All rights reserved.
//

@import Specta;
@import Expecta;
@import AUTExtReactiveCocoa;

SpecBegin(RACSignal_AUTTakeUntil)

__block NSError *error;
__block BOOL success;

beforeEach(^{
    error = nil;
    success = NO;
});

it(@"take values until (and including) the value that passes the block", ^{
    RACSignal *numbers = @[ @0, @1, @2, @3 ].rac_sequence.signal;
    
    NSArray *remainingNumbers = [[[numbers
        aut_takeUntilAfterBlock:^ BOOL (NSNumber *number) {
            return [number isEqual:@2];
        }]
        collect]
        asynchronousFirstOrDefault:nil success:&success error:&error];
    
    expect(success).to.beTruthy();
    expect(error).to.beNil();
    
    expect(remainingNumbers).to.equal(@[ @0, @1, @2 ]);
});

SpecEnd
