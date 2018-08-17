//
//  AppDelegate.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "AppDelegate.h"
#import "DCTabBarController.h"
#import "LLAppversionTool.h"
#import "ZLAPITest.h"
#import "DCNewFeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [DCUserInfo clearLoginCookie];
    [DCUserInfo readLoginCookie];
    [self setUpRootVC]; //跟控制器判断
    [self setUpFixiOS11]; //适配iOS11
    [self.window makeKeyAndVisible];
//    [ZLAPITest testAPIUser];
//    [ZLAPITest testAPILogin];
//    [ZLAPITest testAPIBonus];
//    [ZLAPITest testAPIHome];
//    NSString *path = NSHomeDirectory();//主目录
//    NSLog(@"NSHomeDirectory:%@",path);
//    NSString *userName = NSUserName();//与上面相同
//    NSString *rootPath = NSHomeDirectoryForUser(userName);
//    NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
//    NSLog(@"NSDocumentDirectory:%@",documentsDirectory);
    return YES;
}

#pragma mark - 根控制器
- (void)setUpRootVC {
    
    self.window.rootViewController = [[DCTabBarController alloc] init];

//    if ([BUNDLE_VERSION isEqualToString:[LLAppversionTool dc_GetLastOneAppVersion]]) { ////判断是否当前版本号等于上一次储存版本号
//        self.window.rootViewController = [[DCTabBarController alloc] init];
//    } else {
//        // 设置窗口的根控制器
//        DCNewFeatureViewController *dcFVc = [[DCNewFeatureViewController alloc] init];
//        [dcFVc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
//
//            *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
//            *showPageCount = YES;
//            *showSkip = YES;
//        }];
//        self.window.rootViewController = dcFVc;
//
//    }

}

#pragma mark - 适配
- (void)setUpFixiOS11
{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}
@end
