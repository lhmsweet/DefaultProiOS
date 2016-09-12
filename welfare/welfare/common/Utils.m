//
//  Utils.m
//  loanProject
//
//  Created by lihuaming on 14-6-15.
//
//

#import "Utils.h"

@implementation Utils

+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)message Delegate:(id)delegate {
    if (![message length]) {
        message = @"未知错误";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    
    
    [alert show];
}

+ (void)showAlertWithMessage:(NSString *)message {
    [self showAlertWithTitle:nil Message:message Delegate:nil];
}
@end
