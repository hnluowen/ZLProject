//
//  ZLUserHome.h
//  ZLong
//
//  Created by David on 2018/8/16.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLUserHome : NSObject
@property (nonatomic,strong) NSString *couponsNum;  //卡包总数
@property (nonatomic,strong) NSString *cardNum;  //cardNum
@property (nonatomic,strong) NSString *orderNum;  //订单总数
@property (nonatomic,strong) NSString *favoriteNum;  //收藏总数
@property (nonatomic,assign) BOOL vip;  //是不是VIP
@property (nonatomic,assign) BOOL userIsOrganization;  //是不是合作伙伴

@property (nonatomic,strong) DCUserInfo *userInfo;
@end
