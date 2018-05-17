//
//  RACSignal+AUTRetainUntilDisposal.h
//  AUTExtReactiveCocoa
//
//  Created by Westin Newell on 7/8/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType> (AUTRetainUntilDisposal)

/// Retains the provided object until the receiver completes or is disposed of.
- (RACSignal<ValueType> *)aut_retainUntilDisposal:(id)object;

@end

NS_ASSUME_NONNULL_END
