//
//  NSDictionary+BCAddons.h
//  FengChao
//
//  Created by Wang Daolong on 12/1/12.
//  Copyright (c) 2012 Baidu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSDictionary (BCAddons)

- (id)noneNullObjectForKey:(id)aKey;

- (id)numberNullObjectForKey:(id)aKey;

- (id)objectOrNilForKey:(id)key;

@end

@interface NSMutableDictionary (BCAddons)

- (void)setObjectOrNil:(id)object forKey:(id)key;

@end

@interface NSDictionary (JsonAddons)

- (NSString *)stringValueForKey:(id)aKey;

- (NSString *)nonEmptyStringValueForKey:(id)aKey;

- (int32_t)int32ValueForKey:(id)aKey;

- (int64_t)int64ValueForKey:(id)aKey;

- (CGFloat)floatValueForKey:(id)aKey;

- (double)doubleValueForKey:(id)aKey;

- (BOOL)boolValueForKey:(id)aKey;

- (NSArray *)arrayValueForKey:(id)aKey;

@end

@interface NSString (Description)

+ (NSString *)repeatedString:(NSString *)string forTimes:(NSUInteger)times;

@end

@interface NSDictionary (Description)
@end

@interface NSArray (Description)
@end