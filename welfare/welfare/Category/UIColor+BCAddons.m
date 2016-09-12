//
//  UIColor+BCAddons.m
//
//
//  Created by Wang Daolong on 11-12-30.
//  Copyright (c) 2011年. All rights reserved.
//

#import "UIColor+BCAddons.h"

#define ColorBrightnessDelta 0.25

@implementation UIColor (BCAddons)

//http://stackoverflow.com/questions/5893261/how-to-get-inverse-color-from-uicolor
- (UIColor *)inverseColor {
    CGColorRef oldCGColor = self.CGColor;
    
    size_t numberOfComponents = CGColorGetNumberOfComponents(oldCGColor);
    // can not invert - the only component is the alpha
    // e.g. self == [UIColor groupTableViewBackgroundColor]
    if (numberOfComponents == 1) {
        return [UIColor colorWithCGColor:oldCGColor];
    }
    const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
    CGFloat newComponentColors[numberOfComponents];
    
    int i = (int)(numberOfComponents - 1);
    newComponentColors[i] = oldComponentColors[i]; // alpha
    while (--i >= 0) {
        newComponentColors[i] = 1 - oldComponentColors[i];
    }
    
    CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
    UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
    CGColorRelease(newCGColor);
    
    return newColor;
}

+ (UIColor *)colorWithR:(int)red G:(int)green B:(int)blue A:(int)alpha {
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha / 255.0f];
}

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColorWithR:(int)red G:(int)green B:(int)blue A:(int)alpha {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha / 255.0f];
    return view;
}

+ (UIView *)backgroundViewWithPureBackgroundColorWithR:(int)red G:(int)green B:(int)blue A:(int)alpha {
    return [self viewWithFrame:CGRectMake(0, 0, 1, 1) backgroundColorWithR:red G:green B:blue A:alpha];
}

//http://stackoverflow.com/questions/11598043/get-slightly-lighter-and-darker-color-from-uicolor
- (UIColor *)lighterColor {
    CGFloat h = 0.0, s = 0.0, b = 0.0, a = 0.0;
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) && [self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * (1 + ColorBrightnessDelta), 1.0)
                               alpha:a];
    }
    return self;
}

- (UIColor *)darkerColor {
    CGFloat h = 0.0, s = 0.0, b = 0.0, a = 0.0;
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) && [self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * (1 - ColorBrightnessDelta)
                               alpha:a];
    }
    return self;
}

+ (UIColor *)selectedColor {
    return [self colorWithR:0x4c G:0x96 B:0xd3 A:255];
}

+ (UIColor *)unselectedColor {
    //return [self colorWithR:0x3a G:0x3e B:0x3f A:255];
    return [self colorWithR:0x8c G:0x93 B:0x98 A:255];
}

+ (UIColor *)backgroundColor {
    return [self colorWithR:249 G:249 B:249 A:255];
}

@end

@implementation UIColor (HexColors)

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    return [[self colorWithHexString:hexString] colorWithAlphaComponent:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString: @""];
    
    if ([hexString length] < 6) {
        return nil;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-fA-F|0-9]" options:0 error:NULL];
    NSUInteger match = [regex numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, [hexString length])];
    if (match != 0) {
        return nil;
    }
    
    NSRange range = NSMakeRange(0, 2);
    unsigned int val = 0;
    NSString *component = [hexString substringWithRange:range];
    [[NSScanner scannerWithString:component] scanHexInt:&val];
    float rRetVal = val / 255.f;
    
    range.location += 2;
    component = [hexString substringWithRange:range];
    [[NSScanner scannerWithString:component] scanHexInt:&val];
    float gRetVal = val / 255.f;
    
    range.location += 2;
    component = [hexString substringWithRange:range];
    [[NSScanner scannerWithString:component] scanHexInt:&val];
    float bRetVal = val / 255.f;
    
    return [UIColor colorWithRed:rRetVal green:gRetVal blue:bRetVal alpha:1.0f];
}

- (NSString *)hexValues {
    if (self == [UIColor whiteColor]) {
        // Special case, as white doesn't fall into the RGB color space
        return @"ffffff";
    }
    
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int redDec = (int)(red * 255);
    int greenDec = (int)(green * 255);
    int blueDec = (int)(blue * 255);
    
    NSString *returnString = [NSString stringWithFormat:@"%02x%02x%02x", (unsigned int)redDec, (unsigned int)greenDec, (unsigned int)blueDec];
    
    return returnString;
}

@end
