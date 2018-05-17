//
//  RACSignal_AUTTypeAssertionSpec.m
//  AUTExtReactiveCocoa
//
//  Created by Robert Böhnke on 20/01/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import Expecta;
@import Specta;
@import AUTExtReactiveCocoa;

SpecBegin(RACSignal_AUTTypeAssertion)

describe(@"when invoked on a signal with one argument", ^{
    describe(@"that is an Objective-C type", ^{
        it(@"should assert that values sent over the signal are of that type", ^{
            expect(^{
                [[[[[RACSignal
                    return:@"123"]
                    aut_assertSignalOf(NSString)]
                    map:^(NSString *string) {
                        return @(string.integerValue);
                    }]
                    aut_assertSignalOf(NSNumber)]
                    subscribeCompleted:^{}];
            }).notTo.raiseAny();

            expect(^{
                [[[RACSignal
                    return:@123]
                    aut_assertSignalOf(NSString)]
                    subscribeCompleted:^{}];
            }).to.raise(NSInternalInconsistencyException);
        });
    });

    describe(@"that is primitive", ^{
        it(@"should expect NSValues that box that type", ^{
            expect(^{
                [[[RACSignal
                    return:@12.34]
                    aut_assertSignalOf(double)]
                    subscribeCompleted:^{}];
            }).notTo.raiseAny();

            expect(^{
                [[[RACSignal
                    return:@NO]
                    aut_assertSignalOf(char)]
                    subscribeCompleted:^{}];
            }).notTo.raiseAny();

            expect(^{
                [[[RACSignal
                    return:[NSValue valueWithCGRect:CGRectZero]]
                    aut_assertSignalOf(CGRect)]
                    subscribeCompleted:^{}];
            }).notTo.raiseAny();

            expect(^{
                [[[RACSignal
                    return:@123]
                    aut_assertSignalOf(CGSize)]
                    subscribeCompleted:^{}];
            }).to.raise(NSInternalInconsistencyException);
        });
    });

    pending(@"should support BOOLs", ^{
        expect(^{
            [[[RACSignal
                return:@YES]
                aut_assertSignalOf(BOOL)]
                subscribeCompleted:^{}];
        }).notTo.raiseAny();
    });
});

describe(@"when invoked on a signal with multiple argument", ^{
    it(@"should assert that the values sent over the signal are a RACTuple of that type", ^{
        expect(^{
            [[[RACSignal
                return:[RACTuple tupleWithObjects:@123, @"A String", [NSValue valueWithCGRect:CGRectZero], nil]]
                aut_assertSignalOf(NSNumber, NSString, CGRect)]
                subscribeCompleted:^{}];
        }).notTo.raiseAny();

        expect(^{
            [[[RACSignal
                return:[RACTuple tupleWithObjects:@"A String", @"Another String", nil]]
                aut_assertSignalOf(NSNumber, NSString)]
                subscribeCompleted:^{}];
        }).to.raise(NSInternalInconsistencyException);
    });
});

SpecEnd
