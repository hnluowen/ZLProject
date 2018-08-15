//
//  DCTabBarController.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "DCTabBarController.h"

// Controllers
#import "DCNavigationController.h"
#import "ZLLoginViewController.h"
#import "ZLMallViewController.h"
// Models

// Views
#import "DCTabBar.h"
// Vendors
#import "DCObjManager.h"
// Categories

// Others

@interface DCTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, weak) ZLMallViewController *mallVc;

@property (nonatomic, strong) NSMutableArray *tabBarItems;
//给item加上badge
@property (nonatomic, weak) UITabBarItem *item;

@property (nonatomic, strong) DCTabBar *mcTabbar;

@end

@implementation DCTabBarController

#pragma mark - LazyLoad
- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    
    return _tabBarItems;
}

#pragma mark - LifeCyle

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 添加通知观察者
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadgeValue) name:@"DCMESSAGECOUNTCHANGE" object:nil];
    
    // 添加badgeView
    
    WEAKSELF
    [[NSNotificationCenter defaultCenter] addObserverForName:@"LOGINOFFSELECTCENTERINDEX" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        weakSelf.selectedViewController = [weakSelf.viewControllers objectAtIndex:DCTabBarControllerMall]; //默认选择商城index为1
    }];
    
}


#pragma mark - initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mcTabbar = [[DCTabBar alloc] init];
    [_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
//    _mcTabbar.tintColor = [UIColor colorWithRed:27.0/255.0 green:118.0/255.0 blue:208/255.0 alpha:1];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _mcTabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];

    self.delegate = self;
    
    [self addDcChildViewContorller];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor dc_colorWithHexString:@"#999999"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor dc_colorWithHexString:@"#F23033"]} forState:UIControlStateSelected];
    

    self.selectedViewController = [self.viewControllers objectAtIndex:DCTabBarControllerMall]; //默认选择商城index为1
}

- (void)buttonAction:(UIButton *)button{
    button.selected = YES;
    self.selectedIndex = 2;//关联中间按钮
    for (UIView *imageView in button.subviews) {
//        NSLog(@"%@",NSStringFromClass([imageView class]));
        if ([imageView isKindOfClass:NSClassFromString(@"UIImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }

}



#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"ZLMallViewController",
                              MallTitleKey  : @"商城",
                              MallImgKey    : @"tab_1",
                              MallSelImgKey : @"tab_sel_1"},
                            
                            @{MallClassKey  : @"ZLNearbyViewController",
                              MallTitleKey  : @"周边",
                              MallImgKey    : @"tab_2",
                              MallSelImgKey : @"tab_sel_2"},
                            
                            @{MallClassKey  : @"ZLIMViewController",
                              MallTitleKey  : @"IM",
                              MallImgKey    : @"",
                              MallSelImgKey : @""},

                            @{MallClassKey  : @"ZLBonusViewController",
                              MallTitleKey  : @"红利",
                              MallImgKey    : @"tab_3",
                              MallSelImgKey : @"tab_sel_3"},
                            
                            @{MallClassKey  : @"ZLUserViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"tab_4",
                              MallSelImgKey : @"tab_sel_4"}
                            
                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        DCNavigationController *nav = [[DCNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[MallTitleKey];
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.titlePositionAdjustment = UIOffsetMake(0,-3);
        item.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
        
        [self addChildViewController:nav];
        WEAKSELF
        if ([dict[MallTitleKey] isEqualToString:@"商城"]) {
            weakSelf.mallVc = (ZLMallViewController *)vc; //给美信赋值
        }
        
        // 添加tabBarItem至数组
        [self.tabBarItems addObject:vc.tabBarItem];
    }];
}

#pragma mark - 控制器跳转拦截
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {


//    if(viewController == [tabBarController.viewControllers objectAtIndex:DCTabBarControllerUser] || viewController == [tabBarController.viewControllers objectAtIndex:DCTabBarControllerBonus]){
//
//        if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
//            ZLLoginViewController *dcLoginVc = [[ZLLoginViewController alloc] init];
//
//            [self presentViewController:dcLoginVc animated:YES completion:nil];
//            return NO;
//        }
//    }
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (viewController != [tabBarController.viewControllers objectAtIndex:DCTabBarControllerIM] ) {
        _mcTabbar.centerBtn.selected = NO;
    }
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    if (viewController != [tabBarController.viewControllers objectAtIndex:DCTabBarControllerIM] ) {
        _mcTabbar.centerBtn.selected = NO;
    }

    
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
}



#pragma mark - 只要监听的item的属性一有新值，就会调用该方法重新给属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
//    for (UIView *subView in self.tabBar.subviews) {
//        if ([subView isKindOfClass:[DCTabBadgeView class]]) {
//            if (subView.tag == 1) {
//                DCTabBadgeView *badgeView = (DCTabBadgeView *)subView;
//                badgeView.badgeValue = _beautyMsgVc.tabBarItem.badgeValue;
//            }
//        }
//    }
    
}


#pragma mark - 移除通知
- (void)dealloc {
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

@end
