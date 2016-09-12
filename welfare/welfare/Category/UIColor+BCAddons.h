//
//  UIColor+BCAddons.h
//  
//
//  Created by Wang Daolong on 11-12-30.
//  Copyright (c) 2011年. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 常用的颜色扩展。
 */
@interface UIColor (BCAddons)

///-------------------------------
/// @name 生成常用颜色
///-------------------------------

/*!
 生成颜色的快速方法。参数取数范围为0~255而不是系统方法的0~1。
 @param red 红色，取数范围为0~255
 @param green 绿色，取数范围为0~255
 @param blue 蓝色，取数范围为0~255
 @param alpha 透明程度，取数范围为0~255
 */
+ (UIColor *)colorWithR:(int)red G:(int)green B:(int)blue A:(int)alpha;

/*!
 获得当前颜色的反色。
 */
- (UIColor *)inverseColor;

/*!
 生成亮一些的颜色。
 */
- (UIColor *)lighterColor;

/*!
 生成暗一些的颜色。
 */
- (UIColor *)darkerColor;

/*!
 列表项选中的文字的颜色。
 */
+ (UIColor *)selectedColor;

/*!
 列表项非选中的文字的颜色。
 */
+ (UIColor *)unselectedColor;

+ (UIColor *)backgroundColor;

///-------------------------------
/// @name 生成单色视图
///-------------------------------

/*!
 生成指定颜色的视图的快速方法。
 @param frame 视图大小
 @param color 视图背影颜色。
 */
+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

/*!
 生成指定颜色的视图的快速方法。
 @param frame 视图大小
 @param red 红色，取数范围为0~255
 @param green 绿色，取数范围为0~255
 @param blue 蓝色，取数范围为0~255
 @param alpha 透明程度，取数范围为0~255
 */
+ (UIView *)viewWithFrame:(CGRect)frame backgroundColorWithR:(int)red G:(int)green B:(int)blue A:(int)alpha;

/*!
 生成1*1大小的指定颜色的视图。主要用来填充背景用。
 @param red 红色，取数范围为0~255
 @param green 绿色，取数范围为0~255
 @param blue 蓝色，取数范围为0~255
 @param alpha 透明程度，取数范围为0~255
 */
+ (UIView *)backgroundViewWithPureBackgroundColorWithR:(int)red G:(int)green B:(int)blue A:(int)alpha;

@end

@interface UIColor (HexColors)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

- (NSString *)hexValues;

@end
