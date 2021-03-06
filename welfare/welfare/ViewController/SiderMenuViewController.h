//
//  SiderMenuViewController.h
//  welfare
//
//  Created by hazama on 16/7/19.
//  Copyright © 2016年 hazama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol SiderMenuViewControllerDelegate <NSObject>

-(void)LeftMenuViewClick:(NSInteger)tag;

@end

@interface SiderMenuViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, weak) id<SiderMenuViewControllerDelegate> delegate;

@end
