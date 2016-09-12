//
//  NSDictionary+Addons.h
//  FengChao
//
//  Created by Wang Daolong on 12/1/12.
//  Copyright (c) 2012 Baidu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addons)

- (id)noneNullObjectForKey:(id)aKey;

- (id)numberNullObjectForKey:(id)aKey;

- (id)objectOrNilForKey:(id)key;

@end

@interface NSMutableDictionary (Addons)

- (void)setObjectOrNil:(id)object forKey:(id)key;

@end