//
//  NSDictionary+Addons.m
//  FengChao
//
//  Created by Wang Daolong on 12/1/12.
//  Copyright (c) 2012 Baidu, Inc. All rights reserved.
//

#import "NSDictionary+Addons.h"

@implementation NSDictionary (Addons)

- (id)noneNullObjectForKey:(id)aKey {
    id obj = [self objectForKey:aKey];
    BOOL isNull = [obj isEqual:[NSNull null]];
    //    if (isNull) {
    //        DebugLog(@"just avoided a null check/crash key:%@", aKey);
    //    }
    return isNull?nil:obj;
}

-(id)numberNullObjectForKey:(id)aKey {
    id obj = [self objectForKey:aKey];
    BOOL isNull = [obj isEqual:[NSNull null]];
    if (isNull) {
        obj = [NSNumber numberWithInt:0];
//        DebugLog(@"just avoided a null check/crash key:%@", aKey);
    }
    return obj;
}

- (id)objectOrNilForKey:(id)key {
    id object = [self objectForKey:key];
    if (object == [NSNull null]) {
        return nil;
    }
    return object;
}

@end

@implementation NSMutableDictionary (Addons)

- (void)setObjectOrNil:(id)object forKey:(id)key {
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    [self setObject:object forKey:key];
}

@end
