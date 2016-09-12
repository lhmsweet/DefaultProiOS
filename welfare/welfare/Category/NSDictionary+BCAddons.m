//
//  NSDictionary+BCAddons.m
//  FengChao
//
//  Created by Wang Daolong on 12/1/12.
//  Copyright (c) 2012 Baidu, Inc. All rights reserved.
//

#import "NSDictionary+BCAddons.h"

@implementation NSDictionary (BCAddons)

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
    if (!key) {
        return nil;
    }
 
    id object = [self objectForKey:key];
    if (object == [NSNull null]) {
        return nil;
    }
    return object;
}

@end

@implementation NSMutableDictionary (BCAddons)

- (void)setObjectOrNil:(id)object forKey:(id)key {
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    [self setObject:object forKey:key];
}

@end

@implementation NSDictionary (JsonAddons)

- (NSString *)stringValueForKey:(id)aKey {
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSString class]] ||
        [obj isKindOfClass:[NSNumber class]]) {
        obj = [NSString stringWithFormat:@"%@", obj];
    } else {
        obj = @"";
    }
    
    return obj;
}

- (NSString *)nonEmptyStringValueForKey:(id)aKey {
    NSString *str = [self stringValueForKey:aKey];
    if (str.length == 0) {
        str = @" ";
    }
    return str;
}

- (int32_t)int32ValueForKey:(id)aKey {
    int32_t retValue = 0;
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = obj;
        str = [[str componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
        retValue = [str intValue];
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        retValue = [obj intValue];
    }
    
    return retValue;
}

- (int64_t)int64ValueForKey:(id)aKey {
    int64_t retValue = 0;
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = obj;
        str = [[str componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
#if defined(__LP64__) && __LP64__
        retValue = [str integerValue];
#else // defined(__LP64__) && __LP64__
        retValue = [str longLongValue];
#endif // defined(__LP64__) && __LP64__
    } else if ([obj isKindOfClass:[NSNumber class]]) {
#if defined(__LP64__) && __LP64__
        retValue = [obj longValue];
#else // defined(__LP64__) && __LP64__
        retValue = [obj longLongValue];
#endif // defined(__LP64__) && __LP64__
    }
    
    return retValue;
}

- (CGFloat)floatValueForKey:(id)aKey {
    CGFloat retValue = 0.0f;
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSString class]] ||
        [obj isKindOfClass:[NSNumber class]]) {
        retValue = [obj floatValue];
    }
    return retValue;
}

- (double)doubleValueForKey:(id)aKey {
    double retValue = 0.0;
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSString class]] ||
        [obj isKindOfClass:[NSNumber class]]) {
        retValue = [obj doubleValue];
    }
    return retValue;
}

- (BOOL)boolValueForKey:(id)aKey {
    BOOL retValue = NO;
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSString class]] ||
        [obj isKindOfClass:[NSNumber class]]) {
        retValue = [obj boolValue];
    }
    
    return retValue;
}

- (NSArray *)arrayValueForKey:(id)aKey {
    id obj = [self objectForKey:aKey];
    if (![obj isKindOfClass:[NSArray class]]) {
        obj = [NSArray array];
    }
    
    return obj;
}

@end

@implementation NSString (Description)
+ (NSString *)repeatedString:(NSString *)string forTimes:(NSUInteger)times {
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < times; i++) {
        [result appendString:string];
    }
    return result;
}
@end

@implementation NSDictionary (Description)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{\n"];
    for (NSString *key in self) {
        id value = [self objectForKey:key];
        [string appendString:[NSString repeatedString:@"    " forTimes:level]];
        NSString *valueDescription = nil;
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            valueDescription = [value descriptionWithLocale:locale indent:level + 1];
        } else {
            valueDescription = [value description];
        }
        [string appendFormat:@"%@=%@;\n", key, valueDescription];
    }
    
    if (level > 1) {
        [string appendString:[NSString repeatedString:@"    " forTimes:level - 1]];
    }
    
    [string appendString:@"}"];
    return string;
}

@end

@implementation NSArray (Description)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"(\n"];
    for (id obj in self) {
        [string appendString:[NSString repeatedString:@"    " forTimes:level]];
        NSString *objDescription = nil;
        if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            objDescription = [obj descriptionWithLocale:locale indent:level + 1];
        } else {
            objDescription = [obj description];
        }
        [string appendFormat:@"%@,\n", objDescription];
    }
    
    if (level > 1) {
        [string appendString:[NSString repeatedString:@"    " forTimes:level - 1]];
    }
    
    [string appendString:@")"];
    return string;
}

@end