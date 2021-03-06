//
//  DCUserInfo.h
//  CDDMall
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "JKDBModel.h"

@interface DCUserInfo : JKDBModel

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *headurl;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *ismember;

@property (nonatomic, copy) NSString *loginname;

@property (nonatomic, copy) NSString *dlAmount; //已消费生虾
@property (nonatomic, copy) NSString *moneyAmount;
@property (nonatomic, copy) NSString *lqAmount; //已消费虾券
@property (nonatomic, copy) NSString *outDlMoney; //以提现生虾

+ (void)saveLoginCookie;
+ (void)clearLoginCookie;
+ (void)readLoginCookie;

@end
