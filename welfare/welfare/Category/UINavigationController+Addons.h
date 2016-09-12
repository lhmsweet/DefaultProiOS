

#import <UIKit/UIKit.h>

@interface UINavigationController (Addons)

@end

/*!
 导航条按钮位置
 */
typedef NS_ENUM(NSInteger, BarButtonType) {

   
    BarButtonTypeLeft = 0,
    
    
    BarButtonTypeRight,
};

@interface UINavigationController (Customization)

/*!
 Add a custom button with image or title on navigation bar
 
 @param imageName name of image
 @param title     content of title
 @param type      type of button
 @param target    receiver of action
 @param action    action when button is pressed
 @param index     order of button in navigation bar,
                  0 stands for the most left side as type is BarButtonTypeLeft;
                  0 stands for the most right side as type is BarButtonTypeRight;
 @note imageName or title must not be nil at the same time
 
 @return button new added
 */
- (void)addButtonWithImageNamed:(NSString *)imageName title:(NSString *)title type:(BarButtonType)type target:(id)target action:(SEL)action index:(NSInteger)index;

/*!
 Add a custom button with image or title on navigation bar
 
 @param imageName name of image
 @param title     content of title
 @param type      type of button
 @param width     button buttonWidth
 @param target    receiver of action
 @param action    action when button is pressed
 @param index     order of button in navigation bar,
 0 stands for the most left side as type is BarButtonTypeLeft;
 0 stands for the most right side as type is BarButtonTypeRight;
 @note imageName or title must not be nil at the same time
 
 @return button new added
 */
- (void)addButtonWithImageNamed:(NSString *)imageName
                                title:(NSString *)title
                                 type:(BarButtonType)type
                                width:(CGFloat)buttonWidth
                               target:(id)target
                               action:(SEL)action
                                index:(NSInteger)index;

/*!
 Get the custom button on navigation bar
 
 @param type  type of button
 @param index order of button in navigation bar,
              0 stands for the most left side as type is BarButtonTypeLeft;
              0 stands for the most right side as type is BarButtonTypeRight.
 
 @return button wanted or nil if not found
 */
- (UIButton *)buttonOfType:(BarButtonType)type atIndex:(NSInteger)index;

/*!
 Remove the custom button on navigtion bar
 
 @param type  type of button
 @param index order of button in navigation bar,
              0 stands for the most left side as type is BarButtonTypeLeft;
              0 stands for the most right side as type is BarButtonTypeRight.
 */
- (void)removeButtonWithType:(BarButtonType)type atIndex:(NSInteger)index;


- (void)addLeftButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

@end
