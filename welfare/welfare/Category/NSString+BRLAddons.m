//
//  NSString+BRLAddons.m
//  loanProject
//
//  Created by lihuaming on 14-6-15.
//
//

#import "NSString+BRLAddons.h"
#import <CommonCrypto/CommonDigest.h>


#define SECURITY_KEY @"brilliance$kg$dataMangaer"

@implementation NSString (BRLAddons)

- (BOOL)isNumericString {
    NSString *regex = @"[0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:self]) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)isFloatNumberString {
    NSString *regex = @"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:self]) {
        
        return YES;
    }
    
    return NO;
    
}


- (NSString*) sha1
{
    NSString *string = [NSString stringWithFormat:@"%@%@",self,SECURITY_KEY];
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (uint32_t)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)stringAfterMD5Hashing {
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (uint32_t)strlen(input), result);
	
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)urlEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            (CFStringRef)@"!$&'()*+,-/:;=?@_~%#[]",
                                            kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)urlDecodedString
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
