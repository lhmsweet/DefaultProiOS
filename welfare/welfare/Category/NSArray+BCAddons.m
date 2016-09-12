//
//  NSArray+BCAddons.m
//  FengChao
//
//  Created by Wang Daolong on 8/2/13.
//  Copyright (c) 2013 Baidu, Inc. All rights reserved.
//

#import "NSArray+BCAddons.h"

@implementation NSArray (BCAddons)
- (id)firstObject {
    if ([self count]) {
        return [self objectAtIndex:0];
    } else {
        return nil;
    }
}

/*!
 随机返回一个元素
 @return 返回的随机元素
 */
- (id)randomObject {
    if (![self count]) {
        
        return nil;
    }
    
    NSUInteger index = arc4random() % ([self count]);
    return [self objectAtIndex:index];
}

- (id)objectOrNilAtIndex:(NSUInteger)index {
    if ([self count] <= index) {
        return nil;
    }
    
    id object = [self objectAtIndex:index];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    
    return object;
}

- (NSArray *)reverseObjects {
    NSMutableArray *reverseObjects = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [reverseObjects addObject:obj];
    }];
    
    return reverseObjects;
}

- (NSInteger)integerCount {
    return (NSInteger)self.count;
}

@end

@implementation NSMutableArray (BCAddons)

- (void)setObjectOrNil:(id)obj atIndex:(NSUInteger)idx {
    if (!obj) {
        return;
    }
    
    if (idx < self.count) {
        [self replaceObjectAtIndex:idx withObject:obj];
    } else {
        NSUInteger placeHolderCount = idx - self.count;
        if (placeHolderCount) {
            for (int i = 0; i < placeHolderCount; ++i) {
                [self addObject:[NSNull null]];
            }
        }
        [self addObject:obj];
    }
}

- (void)addObjectOrNil:(id)obj {
    if (obj) {
        [self addObject:obj];
    }
}

- (void)removeObjectOrNilAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

@end
