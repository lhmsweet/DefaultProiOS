//
//  NSJSONSerialization+Addons.h
//  Umbrella
//
//  Created by yufei on 13-10-30.
//  Copyright (c) 2013年 yufei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Helper)

extern NSData * JSONEncode(id object, NSError **error);
extern id JSONDecode(NSData *data, NSError **error);

@end

@interface NSString (NSJSONSerialization)

- (id)objectFromJSONString;

@end

@interface NSDictionary (NSJSONSerialization)

- (NSString *)JSONString;

@end