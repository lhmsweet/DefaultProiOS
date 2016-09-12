
#import <Foundation/Foundation.h>

/*!
 UIView FirstResponder扩展。
 https://github.com/facebook/three20/raw/master/src/Three20UICommon/Sources/UIWindowAdditions.m
 */
@interface UIView (FirstResponder)

/*!
 找当前视图下的firstResponder
 @return 返回找到的firstResponder, 没找到时返回`nil`
 */
- (UIView*)findFirstResponder;

/*!
 找`topView`下的firstResponder
 @param topView 顶级视图
 @return 返回找到的firstResponder, 没找到时返回`nil`
 */
+ (UIView*)findFirstResponderInView:(UIView*)topView;

//NULL class means all classes
- (void)setDelegate:(id) dele forSubviewsOfClass:(Class)class;


- (BOOL)isSubviewOfView:(UIView *) view;
@end
