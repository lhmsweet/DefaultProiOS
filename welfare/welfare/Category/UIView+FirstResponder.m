
#import "UIView+FirstResponder.h"


#define TAG_BACKGROUND_IMAGEVIEW 10018
@implementation UIView (FirstResponder) 

- (UIView*)findFirstResponder {
	return [[self class] findFirstResponderInView:self];
}


+ (UIView*)findFirstResponderInView:(UIView*)topView {
	//DebugLog(@"currentView:%@", topView);
#if 1
	if ([topView isFirstResponder]) {//doesn't work in our case
		return topView;
	}
#else
	if ([topView isKindOfClass:[UITextField class]]) {
		if ([(UITextField *) topView isEditing]) {
			return topView;
		}
	}
#endif
	
	for (UIView* subView in topView.subviews) {
		UIView* firstResponderCheck = [self findFirstResponderInView:subView];
		if (nil != firstResponderCheck) {
			return firstResponderCheck;
		}
	}
	return nil;
}

//NULL class means all classes
- (void)setDelegate:(id) dele forSubviewsOfClass:(Class)class {
    if (!class || [self isKindOfClass:class]) {
        if ([self respondsToSelector:@selector(setDelegate:)]) {
            //DebugLog(@"setting delegate for %@", self);
            [self performSelector:@selector(setDelegate:) withObject:dele];
        } else {
           // DebugLog(@"ignoring %@ because it doesn't respond to setDelegate", self);
        }
    }
    for (UITextField* subView in self.subviews) {
        //DebugLog(@"recursive call on %@", subView);
        [subView setDelegate:dele forSubviewsOfClass:class];
    }
}


- (BOOL)isSubviewOfView:(UIView *) view {
    UIView *v = self;
    BOOL rt = v == view;
    while (!rt && v.superview != nil) {
        v = v.superview;
        rt = v == view;
    }
    return rt;
}
@end
