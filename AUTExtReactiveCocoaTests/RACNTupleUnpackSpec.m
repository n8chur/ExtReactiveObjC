//
//  RACNTupleUnpackSpec.m
//  AUTExtReactiveCocoa
//
//  Created by Eric Horacek on 4/10/17.
//  Copyright © 2017 Automatic. All rights reserved.
//

@import Specta;
@import Expecta;
@import AUTExtReactiveCocoa;

SpecBegin(RACNTupleUnpack)

describe(@"unpacking", ^{
    context(@"RACOneTuple", ^{
        it(@"should succeed", ^{
            RACOneTuple<NSString *> *tuple = RACTuplePack(@"1");
            RACNTupleUnpack(tuple, string);
            expect(string).to.equal(tuple.first);
        });
    });

    context(@"RACTwoTuple", ^{
        it(@"should succeed", ^{
            RACTwoTuple<NSString *, NSNumber *> *tuple = RACTuplePack(@"1", @1);
            RACNTupleUnpack(tuple, string, number);
            expect(string).to.equal(tuple.first);
            expect(number).to.equal(tuple.second);
        });
    });

    context(@"RACThreeTuple", ^{
        it(@"should succeed", ^{
            RACThreeTuple<NSString *, NSNumber *, NSValue *> *tuple = RACTuplePack(@"1", @1, [NSValue valueWithCGSize:CGSizeZero]);
            RACNTupleUnpack(tuple, string, number, size);
            expect(string).to.equal(tuple.first);
            expect(number).to.equal(tuple.second);
            expect(size).to.equal(tuple.third);
        });
    });

    context(@"RACFourTuple", ^{
        it(@"should succeed", ^{
            RACFourTuple<NSString *, NSNumber *, NSValue *, NSValue *> *tuple = RACTuplePack(@"1", @1, [NSValue valueWithCGSize:CGSizeZero], [NSValue valueWithCGPoint:CGPointZero]);
            RACNTupleUnpack(tuple, string, number, size, point);
            expect(string).to.equal(tuple.first);
            expect(number).to.equal(tuple.second);
            expect(size).to.equal(tuple.third);
            expect(point).to.equal(tuple.fourth);
        });
    });

    context(@"RACFiveTuple", ^{
        it(@"should succeed", ^{
            RACFiveTuple<NSString *, NSNumber *, NSValue *, NSValue *, NSValue *> *tuple = RACTuplePack(@"1", @1, [NSValue valueWithCGSize:CGSizeZero], [NSValue valueWithCGPoint:CGPointZero], [NSValue valueWithCGRect:CGRectZero]);
            RACNTupleUnpack(tuple, string, number, size, point, rect);
            expect(string).to.equal(tuple.first);
            expect(number).to.equal(tuple.second);
            expect(size).to.equal(tuple.third);
            expect(point).to.equal(tuple.fourth);
            expect(rect).to.equal(tuple.fifth);
        });
    });
});

SpecEnd
