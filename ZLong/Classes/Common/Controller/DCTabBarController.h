//
//  DCTabBarController.h
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger ,DCTabBarControllerType){
    DCTabBarControllerMall = 0,  //商城
    DCTabBarControllerNearby = 1, //周边
    DCTabBarControllerIM = 2,  //IM
    DCTabBarControllerBonus = 3,  //红利
    DCTabBarControllerUser = 4, //个人中心
};

@interface DCTabBarController : UITabBarController

/* 控制器type */
@property (assign , nonatomic)DCTabBarControllerType tabVcType;

@end

