

#import <UIKit/UIKit.h>

@interface UIImage (Addons)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color strokeColor:(UIColor *)strokeColor size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius;
+ (UIImage *)imageWithColor:(UIColor *)color strokeColor:(UIColor *)strokeColor size:(CGSize)size radius:(CGFloat)radius;

+ (UIImage *)imageInMainBundleNamed:(NSString *)name;
+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;

- (UIImage *)grayImage;

- (UIImage *)cropWithRect:(CGRect)rect;

//将图像按一定的规则生成更大的图像，不缩放。主要用来合并背景色和背景图
- (UIImage *)imageInNewSize:(CGSize)newSize edgaeInsets:(UIEdgeInsets)edgeInsets backgroundColor:(UIColor *)backgroundColor;

- (UIImage *)resizable;

@end
