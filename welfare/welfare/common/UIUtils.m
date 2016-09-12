//
//  UIUtils.m
//  SmartHome
//
//  Created by lihuaming on 14-3-10.
//  Copyright (c) 2014年 lihuaming. All rights reserved.
//

#import "UIUtils.h"
#import "UIView+FirstResponder.h"
@implementation UIUtils
+ (void)dismissAllKeyboardsInView:(UIView *)rootView {
    UITextField *firstResponder = (UITextField *)[rootView findFirstResponder];
    [firstResponder resignFirstResponder];
}
@end
