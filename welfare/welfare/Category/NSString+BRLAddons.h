//
//  NSString+BRLAddons.h
//  loanProject
//
//  Created by lihuaming on 14-6-15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (BRLAddons)

/*!
 是否是纯数字0-9
 @return YES 表示纯数字，NO表示不是
 */
- (BOOL)isNumericString;

- (NSString *) sha1;
- (NSString *)stringAfterMD5Hashing;
- (NSString *)urlEncodedString;
- (NSString *)urlDecodedString;
-(BOOL)isFloatNumberString;
@end
