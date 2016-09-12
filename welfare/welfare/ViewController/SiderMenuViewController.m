//
//  SiderMenuViewController.m
//  welfare
//
//  Created by hazama on 16/7/19.
//  Copyright © 2016年 hazama. All rights reserved.
//

#import "SiderMenuViewController.h"
#import "MMDrawerController.h"

@interface SiderMenuViewController ()

@property(nonatomic,strong) IBOutlet UITableView *tableView;

@end

@implementation SiderMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
