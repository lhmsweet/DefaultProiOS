//
//  NSJSONSerialization+Helper.m
//  Umbrella
//
//  Created by yufei on 13-10-30.
//  Copyright (c) 2013年 yufei. All rights reserved.
//


#import "NSJSONSerialization+Addons.h"

@implementation NSJSONSerialization (Helper)

NSData * JSONEncode(id object, NSError **error) {
    return [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:error];
}

id JSONDecode(NSData *data, NSError **error) {
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
}

@end

@implementation NSString (NSJSONSerialization)

- (id)objectFromJSONString {
    return JSONDecode([self dataUsingEncoding:NSUTF8StringEncoding], nil);
}

@end

@implementation NSDictionary (NSJSONSerialization)

- (NSString *)JSONString {
    return [[NSString alloc] initWithData:JSONEncode(self, nil)
                                 encoding:NSUTF8StringEncoding];
}

@end
