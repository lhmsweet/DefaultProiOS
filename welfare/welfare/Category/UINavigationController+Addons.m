

#import "UINavigationController+Addons.h"

#import "UIImage+Addons.h"
#import "UIColor+BCAddons.h"
#import "NSArray+BCAddons.h"

#define ButtonWidth 49
#define ButtonHeight (self.navigationBar.frame.size.height)

@implementation UINavigationController (Addons)

#pragma mark auto rotation iOS 6

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

#pragma mark auto rotation old iOS
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

#pragma mark - Customization

- (void)addButtonWithImageNamed:(NSString *)imageName
                                title:(NSString *)title
                                 type:(BarButtonType)type
                               target:(id)target
                               action:(SEL)action
                                index:(NSInteger)index {
    [self addButtonWithImageNamed:imageName
                            title:title
                             type:type
                            width:ButtonWidth
                           target:target
                           action:action
                            index:index];
}

- (void)addButtonWithImageNamed:(NSString *)imageName
                                title:(NSString *)title
                                 type:(BarButtonType)type
                                width:(CGFloat)buttonWidth
                               target:(id)target
                               action:(SEL)action
                                index:(NSInteger)index {
    
     //Perpare for button to be added and wrapper it with UIBarButtonItem
    UIImage *backgroundImage = nil;
    UIImage *highlightedBackgroundImage = nil;
//    BOOL left = (BarButtonTypeLeft == type) && (index == 0) && (title.length || imageName.length);
//    BOOL right = (BarButtonTypeRight == type) && (index == 0) && (title.length || imageName.length);
//    if (left) {
//        backgroundImage = [[UIImage imageNamed:@"bg_navibutton_right"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//        highlightedBackgroundImage = [[UIImage imageNamed:@"bg_navibutton_right_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//    } else if (right) {
//        backgroundImage = [[UIImage imageNamed:@"bg_navibutton_left"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//        highlightedBackgroundImage = [[UIImage imageNamed:@"bg_navibutton_left_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//    } else {
//        highlightedBackgroundImage = [UIImage imageWithColor:[UIColor colorWithR:0 G:0 B:0 A:100] size:CGSizeMake(1, 1)];
//    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, buttonWidth, ButtonHeight);
    // make button item invisible when no content is to be shown
    if (!imageName.length && !title.length) {
        button.userInteractionEnabled = NO;
    } else {
        button.userInteractionEnabled = YES;
    }
    
    if (backgroundImage) {
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    if (highlightedBackgroundImage) {
        [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    }
    
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    //buttonItem.tintColor = [UIColor clearColor];
    
    UINavigationItem *navigationItem = self.topViewController.navigationItem;
    // Make a toolbar to accept and align more than one UIBarButtonItem items
    UIBarButtonItem *toolbarItem = (type == BarButtonTypeLeft) ? [navigationItem.leftBarButtonItems objectOrNilAtIndex:1] :[navigationItem.rightBarButtonItems objectOrNilAtIndex:1];
    
    UIToolbar *toolbar = (id)toolbarItem.customView;
    if (!toolbar || ![toolbar isKindOfClass:[UIToolbar class]]) {
        toolbar = [[UIToolbar alloc] init];
        toolbar.barStyle = 0;
    }
    
    NSMutableArray *items = (type == BarButtonTypeLeft) ? [NSMutableArray arrayWithArray:toolbar.items] : [NSMutableArray arrayWithArray:[toolbar.items reverseObjects]];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10.f;
    // Every new button is accompanied with a spacer
    index = index * 2;
    [items setObjectOrNil:negativeSpacer atIndex:index];
    [items setObjectOrNil:buttonItem atIndex:index + 1];
    
    // Replace possible placeholder as UIBarButtonItem item.
    for (NSUInteger idx = 0; idx < [items count]; ++idx) {
        id obj = [items objectAtIndex:idx];
        if ([obj isKindOfClass:[NSNull class]]) {
            [items replaceObjectAtIndex:idx withObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil]];
        }
    }
    
    const CGFloat offset = 22;
    toolbar.items = (type == BarButtonTypeLeft) ? items : [items reverseObjects];
    CGFloat width = ([items count] / 2) * buttonWidth + offset;
    toolbar.frame = (type == BarButtonTypeLeft) ? CGRectMake(0, 0, width, ButtonHeight) : CGRectMake(self.navigationBar.frame.size.width - width, 0, width, ButtonHeight);
    
    // Make a negative spacer to align UIBarButtonItem item in navigation bar.
    UIBarButtonItem *negativeSpacerItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
    negativeSpacerItem.width = -offset;
    
    toolbarItem = [[UIBarButtonItem alloc] initWithCustomView:toolbar];
    NSArray *newBarItems = @[negativeSpacerItem, toolbarItem];
    if (type == BarButtonTypeLeft) {
        [navigationItem setLeftBarButtonItems:newBarItems animated:NO];
    } else {
        [navigationItem setRightBarButtonItems:newBarItems animated:NO];
    }
}


- (void)addLeftButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, ButtonWidth, ButtonHeight);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem =[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    negativeSpacer.width = -20;//这个数值可以根据情况自由变化
    [self.topViewController.navigationItem setLeftBarButtonItems:@[negativeSpacer,buttonItem]];
}

- (UIButton *)buttonOfType:(BarButtonType)type atIndex:(NSInteger)index {
    UINavigationItem *navigationItem = self.topViewController.navigationItem;
    UIBarButtonItem *toolbarItem = (type == BarButtonTypeLeft) ? [navigationItem.leftBarButtonItems objectOrNilAtIndex:1] :[navigationItem.rightBarButtonItems objectOrNilAtIndex:1];
    
    UIToolbar *toolbar = (id)toolbarItem.customView;
    if (!toolbar || ![toolbar isKindOfClass:[UIToolbar class]]) {
        return nil;
    }
    
    NSMutableArray *items = (type == BarButtonTypeLeft) ? [NSMutableArray arrayWithArray:toolbar.items] : [NSMutableArray arrayWithArray:[toolbar.items reverseObjects]];
    UIBarButtonItem *buttonItem = [items objectOrNilAtIndex:index * 2 + 1];
    
    return (id)buttonItem.customView;
}

-(void)removeButtonWithType:(BarButtonType)type atIndex:(NSInteger)index {
    [self addButtonWithImageNamed:nil title:@"" type:type target:nil action:nil index:index];
}

@end
