//
//  BaseRequest.h
//  welfare
//
//  Created by hazama on 16/9/22.
//  Copyright © 2016年 hazama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NSString+BRLAddons.h"
#import "NSDictionary+Addons.h"


typedef void (^DidSucceedBlock)(NSDictionary *successDic);
typedef void (^DidFailBlock)(NSDictionary *failDic);
@interface BaseRequest : NSObject

@property(nonatomic, copy) DidSucceedBlock didSucceedBlock;

@property(nonatomic, copy) DidFailBlock didFailBlock;

@end
