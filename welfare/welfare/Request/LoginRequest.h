//
//  LoginRequest.h
//  welfare
//
//  Created by hazama on 16/9/22.
//  Copyright © 2016年 hazama. All rights reserved.
//

#import "BaseRequest.h"

@interface LoginRequest : BaseRequest

- (void)loginActionWithUserName:(NSString *)name pwd:(NSString *)pwd;

@end
