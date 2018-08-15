//
//  DCBaseSetViewController.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "DCBaseSetViewController.h"

// Controllers
#import "DCTabBarController.h"
// Models

// Views

// Vendors

// Categories

// Others

@interface DCBaseSetViewController ()



@end

@implementation DCBaseSetViewController

#pragma mark - LazyLoad

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self setUpAcceptNote];
}

#pragma mark - 接受跟换控制
- (void)setUpAcceptNote
{
    WEAKSELF
    [[NSNotificationCenter defaultCenter]addObserverForName:@"LOGINSELECTCENTERINDEX" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.tabBarController.selectedIndex = DCTabBarControllerUser; //跳转到我的界面
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
