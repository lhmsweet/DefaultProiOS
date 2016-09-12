//
//  HomePageViewController.m
//  welfare
//
//  Created by hazama on 16/7/20.
//  Copyright © 2016年 hazama. All rights reserved.
//

#import "HomePageViewController.h"
#import "UINavigationController+Addons.h"
#import "SiderMenuViewController.h"
#import "MenuView.h"

@interface HomePageViewController ()<SiderMenuViewControllerDelegate>

@property(nonatomic, strong) MenuView *menuView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController addButtonWithImageNamed:@"nav-sidebar" title:nil type:BarButtonTypeLeft target:self action:@selector(showSiderMenu) index:0];
    [self.navigationController addLeftButtonWithImageName:@"nav-sidebar" target:self action:@selector(showSiderMenu)];
    self.title = @"aaaaaa";
    SiderMenuViewController *leftMenuView = [[SiderMenuViewController alloc] init];
    CGRect rect = [[UIScreen mainScreen] bounds];
    leftMenuView.view.frame = CGRectMake(0, 0, rect.size.width * 0.8, rect.size.height);
    NSLog(@"%f",leftMenuView.view.frame.size.height);
    leftMenuView.delegate = self;
    self.menuView = [[MenuView alloc]initWithDependencyView:self.view MenuView:leftMenuView.view isShowCoverView:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSiderMenu {
    [self.menuView show];
}

- (void)LeftMenuViewClick:(NSInteger)tag {
    
}

@end
